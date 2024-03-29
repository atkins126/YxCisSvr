unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, StdCtrls, HTTPApp, System.IniFiles, Winapi.ShellAPI,
  SynWebServer, Vcl.ExtCtrls, Vcl.Menus, uDataYxCisSvr, Qlog, uEncry, UpubFun,
  Vcl.Buttons, uFrmSvrConfig, Registry, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Phys.Intf;

const
  WM_BARICON = WM_USER + 200;
  WM_HTTPINFO = WM_USER + 203;
  WM_HTTPCOUNT = WM_USER + 204;

type
  TMainForm = class(TForm)
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    tmr1: TTimer;
    btnStart: TBitBtn;
    btnStop: TBitBtn;
    tmr2: TTimer;
    Mag1: TFDManager;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
  private
    //是否开启接口日志
    BDEBUG: Boolean;
    //日志文件分页大小
    LogSize: integer;
    //服务接收到的请求数量、成功数、失败数、工作总线程数、当前工作线程数
    IRevcive, Ycount, Ncount, IWeb, IWebActice: Integer;
    //firedac连接池
    oParams: TStrings;
    //系统托盘
    lpData: TNotifyIcondataA;
    //当前是否开启服务
    BeginServer: Boolean;
    //配置文件
    Aini: Tinifile;
    //HttpApi对象
    FServer: TSynHTTPWebBrokerBridge;
    //开始服务
    procedure StartSvr;
    //停止服务
    procedure StopSvr;
    //创建托盘图标
    procedure CreateTratIcons(Sender: TObject);
     //捕获最小化消息 后程序缩小到托盘区
    procedure MSG_SYSCOMAND(var message: TMessage); message WM_SYSCOMMAND;
    //捕获在托盘区双击图标事件，以恢复FORM
    procedure MSG_BackWindow(var message: TMessage); message WM_BARICON;
    //捕获右键
    procedure MSG_Rbutton(var message: TMessage); message WM_RBUTTONDOWN;
    //日志  --已弃用，日志使用Qlog处理
    //procedure MSG_Log(var message: TMessage); message WM_LOG;
    //关机
    procedure WinExit(var msg: TMessage); message WM_CLOSE;
    //HTTP信息
    procedure MSG_GetHTTPINFO(var message: TMessage); message WM_HTTPINFO;
    //服务线程数
    procedure MSG_GetHTTPCount(var message: TMessage); message WM_HTTPCOUNT;
    //设置连接池
    procedure SetDACManager;
    //使用工作集引擎来写日志 //已弃用，日志使用Qlog处理
    //代码源自：https://github.com/yangyxd/YxdWorker
    //procedure WriteLog;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
procedure TMainForm.SetDACManager;
var
  DBServer,DataBase,UserName,PassWord:string;
begin
    //读取数据库配置
    DBServer := DeCode(AINI.ReadString('DB', 'Server', ''));
    DataBase := DeCode(AINI.ReadString('DB', 'DataBase', ''));
    UserName := DeCode(AINI.ReadString('DB', 'UserName', ''));
    PassWord := DeCode(AINI.ReadString('DB', 'PassWord', ''));
    //*****初始化*****
    oParams := TStringList.Create;
    //********* 连接池
    oParams.Add('DriverID=MSSQL');
    oParams.Add('CharacterSet=utf8');
    oParams.Add('Server='+DBServer);
    oParams.Add('Port=1433');
    oParams.Add('Database='+DataBase);
    oParams.Add('User_Name='+UserName);
    oParams.Add('Password='+PassWord);
    oParams.Add('LoginTimeout=3');
    //解决查询只返回50条数据问题
    oParams.add('FetchOptions.Mode=fmAll');
    //解决！，&等字符插入数据库时丢失
    oParams.add('ResourceOptions.MacroCreate=False');
    oParams.add('ResourceOptions.MacroExpand=False');
    //  毫秒
    oParams.Add('POOL_CleanupTimeout=36000');
    //  毫秒
    oParams.Add('POOL_ExpireTimeout=600000');
    //最多连接数
    oParams.Add('POOL_MaximumItems='+inttostr(AINI.ReadInteger('YxCisSvr', 'Pools', 32)));
    oParams.Add('Pooled=True');
    //*******
    Mag1.Close;
    Mag1.AddConnectionDef('MSSQL_Pooled','MSSQL',oParams);
    Mag1.Active := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //获取程序开始运行时刻
  StartRunTime := GetTickCount64;
  IRevcive := 0;
  YCount := 0;
  NCount := 0;
  IWeb := 0;
  IWebActice := 0;
  AINI := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  BDEBUG := AINI.ReadBool('YxCisSvr', 'DEBUG', False);
  LogSize := AINI.ReadInteger('YxCisSvr', 'LogSize', 10);
  //程序系统菜单添加菜单选项
  appendmenu(GetSystemMenu(Handle, False), MF_SEPARATOR, 0, nil);
  appendmenu(GetSystemMenu(Handle, False), MF_ByPosition + MF_String, 888, '接口配置...');
  //创建系统托盘
  CreateTratIcons(Self);
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  rs: TResourceStream;
  LogPath: string;
begin
  //自动开始服务
  if (Aini.ReadBool('YxCisSvr', 'Auto', False)) or (Aini.ReadBool('YxCisSvr',
    'ReBoot', False)) then
    StartSvr;
  //程序开机自启动
  SelfAutoRun(Aini.ReadBool('YxCisSvr', 'AutoRun', False));
  //从资源文件中加载YxCisSvrDK.dll，保存到本地供读卡时调用
  if not FileExists('YxCisSvrDK.dll') then
  begin
    if 0 <> FindResource(hInstance, 'YKTDK', 'DLL') then
    begin
      try
        rs := TResourceStream.Create(hInstance, 'YKTDK', 'DLL');
        try
          rs.SaveToFile('YxCisSvrDK.dll');
        finally
          FreeAndNil(rs);
        end;
      except
      end;
    end;
  end;
  //重启程序定时Timer的赋值
  tmr2.Enabled := Aini.ReadBool('YxCisSvr', 'ReBoot', False);
  tmr2.interval := Aini.ReadInteger('YxCisSvr', 'ReBootT', 3) * 1000 * 24 * 60 * 60;
  DeleteFile(ExtractFilePath(ParamStr(0)) + 'ReBoot.cmd');
 {if log = nil then // 日志
  begin
    log := TSynLog.Add;
    log.Family.DestinationPath := ExtractFilePath(ParamStr(0)) + '\YxCisSvrlog';
    log.Family.Level := [sllInfo, sllError, sllLastError, sllException,
      sllExceptionOS, sllFail, sllSQL];
    log.Family.AutoFlushTimeOut := 60;
  end;}
  LogPath := ExtractFilePath(ParamStr(0)) + '\YxCisSvrlog';
  if not DirectoryExists(LogPath) then
    CreateDir(LogPath);
  //是否写错误日志
  Logs.BInFree := BDEBUG;
  //设置日志文件
  SetDefaultLogFile(LogPath + '\Log.TXT', LogSize * 1048576, True, True);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @lpData);
  if BeginServer then
    FServer.Destroy;
  FreeAndNil(AINI);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  StartSvr;
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  StopSvr;
end;

procedure TMainForm.StartSvr;
//var
//  Port: integer;
begin
  PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  FServer := TSynHTTPWebBrokerBridge.Create(Self);
  {Port := 0;
  if ParamStr(1) <>'' then Port := StrToIntDef(ParamStr(1),0);
  if Port = 0 then
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := Port;
    FServer.Active := True;
  end; }
  BeginServer := True;
  BtnStart.Enabled := False;
  BtnStop.Enabled := True;
  //SetDACManager;
end;

procedure TMainForm.StopSvr;
begin
  BtnStart.Enabled := True;
  BtnStop.Enabled := False;
  FServer.Destroy;
  BeginServer := False;
  if Assigned(oParams) then
    FreeAndNil(oParams);
  Mag1.Active := False;
end;

procedure TMainForm.tmr1Timer(Sender: TObject);
begin
  try
    Lbl2.Caption := Format('CPU: %f%%,内存: %sMB,线程: %d',
      [GetCPURate, inttostr(CurrentMemoryUsage),GetProcessThreadCount]);
    Lbl3.Caption := Format('%d/%d,%s', [IWebActice, IWeb, GetRunTimeInfo]);
    lbl6.Caption := Format('T:%s,N:%s', [SetHTTPCount(IRevcive), SetHTTPCount(NCOUNT)]);
  except
  end;
end;

procedure TMainForm.tmr2Timer(Sender: TObject);
var
  F: TextFile;
begin
  Shell_NotifyIconA(NIM_DELETE, @lpData);
  try
    AssignFile(F, 'ReBoot.cmd');
    Rewrite(F);
    Writeln(F, '@echo 重启YxCisSvr服务');
    Writeln(F, 'taskkill /f /im YxCisSvr.exe');
    Writeln(F, 'start ' + ParamStr(0));
  finally
    CloseFile(F);
  end;
  WinExec('Reboot.cmd', SW_HIDE);
end;

procedure TMainForm.CreateTratIcons(Sender: TObject);
begin
  //创建托盘图标
  //lpData
  lpData.cbSize := sizeof(TNotifyIcondataA);
  //取应用程序主窗体的句柄
  lpData.Wnd := handle;
  //用户自定义的一个数值，在uCallbackMessage参数指定的消息中使用
  lpData.uID := 0;
  //指定在该结构中uCallbackMessage、hIcon和szTip参数都有效
  lpData.uFlags := NIF_ICON + NIF_TIP + NIF_MESSAGE;
  //指定的窗口消息
  lpData.uCallbackMessage := WM_BARICON;
  //指定系统状态栏显示应用程序的图标句柄
  lpData.hIcon := Application.Icon.handle;
  //当鼠标停留在系统状态栏该图标上时，出现该提示信息
  lpData.szTip := 'YxCis应用服务器';
  //系统右下角添加托盘图标
  shell_notifyicona(NIM_ADD, @lpData);
end;

procedure TMainForm.MSG_SYSCOMAND(var message: TMessage);
begin
  if message.WParam = SC_MINIMIZE then
  begin
    shell_notifyicona(NIM_ADD, @lpData);
    MainForm.Visible := False;
  end
  else if message.WParam = 888 then
  begin
    with TFrmSvrConfig.Create(self) do
    try
      Position := poScreenCenter;
      ShowModal;
    finally
      Free;
    end;
  end
  else
    DefWindowProc(MainForm.Handle, message.Msg, message.WParam, message.LParam);
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
  StartSvr;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  StopSvr;
end;

procedure TMainForm.N3Click(Sender: TObject);
var
  message: TMessage;
begin
  message.LPARAM := WM_LBUTTONDBLCLK;
  MSG_BackWindow(message);
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.MSG_BackWindow(var message: TMessage);
begin
  if (message.LParam = WM_LBUTTONDBLCLK) then
  begin
    shell_notifyicona(NIM_DELETE, @lpData);
    MainForm.Visible := True;
  end
  else if (message.LParam = WM_RBUTTONDOWN) then
    MSG_Rbutton(message);
end;

procedure TMainForm.MSG_Rbutton(var message: TMessage);
begin
  if BeginServer then
  begin
    N1.Enabled := False;
    N2.Enabled := True;
  end
  else
  begin
    N1.Enabled := True;
    N2.Enabled := False;
  end;
  PM1.Popup(Mouse.CursorPos.x, Mouse.CursorPos.y);
end;

procedure TMainForm.MSG_GetHTTPCount(var message: TMessage);
begin
  if message.WParam = 0 then
    IWeb := message.LParam
  else if message.WParam = 1 then
    IWebActice := message.LParam;
end;

procedure TMainForm.MSG_GetHTTPINFO(var message: TMessage);
{var
  i:Integer; }
begin
  if message.LParam = 0 then
  begin
    inc(IRevcive);
   { if MainForm.Visible  then
    begin
      for I := 0 to 1 do begin
        Self.Top := Self.Top - 3; Sleep(40);
        Self.Left := Self.Left - 3; Sleep(40);
        Self.Top := Self.Top + 3; Sleep(40);
        Self.Left := Self.Left + 3; Sleep(40);
      end;
    end;  }
  end
  else if message.LParam = 1 then
    inc(Ycount)
  else if message.LParam = 2 then
    inc(Ncount);
end;

//procedure TMainForm.WriteLog;
//var
//  msg:string;
//  F:TextFile;
//  FileName,ExeRoad,Path:String;
//begin
//  if logList.Count < 1 then Exit;
//  begin
//    if Assigned(logList) then
//    begin
//      EnterCriticalSection(FSection);
//      if logList.Count < 1 then Exit;
//      // 添加当前日志内容
//      try
//        msg := logList[0];
//        logList.Delete(0);
//        try
//          ExeRoad := ExtractFilePath(ParamStr(0));
//          if not DirectoryExists(ExeRoad + '\YxCisSvrlog') then
//          begin
//            CreateDir(ExeRoad + '\YxCisSvrlog');
//          end;
//          Path := ExeRoad +'\YxCisSvrlog\'+FormatDateTime('YYMMDD',Now);
//          if not DirectoryExists(Path) then
//          begin
//            CreateDir(Path);
//          end;
//          FileName := Path + '\' + FormatDateTime('YYMMDD', Now) +'-'+FormatDateTime('HH', Now)+ '.TXT';
//          try
//            if not FileExists(FileName) then
//            begin
//              AssignFile(F, FileName);
//              ReWrite(F);
//            end
//            else
//              AssignFile(F, FileName);
//            Append(F);
//            Writeln(F,'[' + FormatDateTime('yyyy-mm-dd hh:nn:ss:zz', Now)+']:'+ Msg);
//            Writeln(F, '**********************************************************************************************');
//          finally
//            CloseFile(F);
//          end;
//        except
//
//        end;
//      finally
//        LeaveCriticalSection(FSection);
//      end;
//    end;
//    //Sleep(10);
//  end;
//end;

//procedure TMainForm.MSG_Log(var message: TMessage);
//var
//  msg:string;
//  PS:PString;
//begin
//  ps := nil;
//  try
//    if not BDEBUG then Exit;
//    PS:=PString(message.LParam);
//    if not Assigned(ps) then Exit;
//    msg:=PS^;
//    if msg = '' then Exit;
//    try
//      //logList.Add(msg);
//      //log.log(sllFail, msg);
//      //Workers.Post(WriteLog, nil);
//
//      PostLog(llError,Msg);
//    except
//
//    end;
//  finally
//    if Assigned(ps) then
//      Dispose(PS);
//  end;
//end;

procedure TMainForm.WinExit(var msg: TMessage);
begin
  shell_notifyicona(NIM_DELETE, @lpData);
  Application.Terminate;
end;

end.

