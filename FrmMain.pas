unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, StdCtrls, HTTPApp, System.IniFiles, Winapi.ShellAPI,
  {$IFDEF MORMOT}SynWebServer{$ELSE}IdHTTPWebBrokerBridge{$ENDIF},
  SQLConnect, Vcl.ExtCtrls, Vcl.Menus, uDataYxCisSvr, uEncry,
  DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait,
  Data.DB, Vcl.Buttons,UpubFun;

const
  WM_BARICON = WM_USER + 200;
  WM_LOGDATA = WM_USER + 201;
  WM_VIEWCIS = WM_USER + 202;
  WM_HTTPINFO = WM_USER + 203;

type
  TMainForm = class(TForm)
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Mag1: TFDManager;
    btnStop: TBitBtn;
    btnStart: TBitBtn;
    tmr1: TTimer;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
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
  private
    HttpGetCount:integer;
    oParams: TStrings;
    lpData: TNotifyIcondata;
    IsFirst: Boolean;
    BeginServer: Boolean;   //��ǰ�Ƿ�������
    Aini: Tinifile;
    FServer: {$IFDEF MORMOT}TSynHTTPWebBrokerBridge{$ELSE}TIdHTTPWebBrokerBridge{$ENDIF};
    //��ʼ����
    procedure StartSvr;
    //ֹͣ����
    procedure StopSvr;
     //������С����Ϣ �������С��������
    procedure MSG_SYSCOMAND(var message: TMessage); message WM_SYSCOMMAND;
    //������������˫��ͼ���¼����Իָ�FORM
    procedure MSG_BackWindow(var message: TMessage); message WM_BARICON;
    //�����Ҽ�
    procedure MSG_Rbutton(var message: TMessage); message WM_RBUTTONDOWN;
    //��־
    procedure MSG_Log(var message: TMessage); message WM_LogDATA;
    //ð�ݼ���http����
    procedure MSG_HTTPListen(var message: TMessage);message WM_HTTPINFO;
    //�ػ�
    procedure WinExit(var msg: TMessage); message WM_CLOSE;
    //�������ӳ�
    procedure SetDACManager;
    //��������ͼ��
    procedure CreateTratIcons(sender: TObject);
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
  DBServer, DataBase, UserName, PassWord: string;
begin
  //��ȡ���ݿ�����
  DBServer := DeCode(AINI.ReadString('DB', 'Server', ''));
  DataBase := DeCode(AINI.ReadString('DB', 'DataBase', ''));
  UserName := DeCode(AINI.ReadString('DB', 'UserName', ''));
  PassWord := DeCode(AINI.ReadString('DB', 'PassWord', ''));
  //*****��ʼ��*****
  oParams := TStringList.Create;
  //********* ���ӳ�
  oParams.Add('DriverID=MSSQL');
  oParams.Add('CharacterSet=utf8');
  oParams.Add('Server=' + DBServer);
  oParams.Add('Port=1433');
  oParams.Add('Database=' + DataBase);
  oParams.Add('User_Name=' + UserName);
  oParams.Add('Password=' + PassWord);
  oParams.Add('LoginTimeout=3');
  //oParams.add('ResourceOptions.CmdExecTimeout=3');
    //�����ѯֻ����50����������
  oParams.add('FetchOptions.Mode=fmAll');
    //�������&���ַ��������ݿ�ʱ��ʧ
  oParams.add('ResourceOptions.MacroCreate=False');
  oParams.add('ResourceOptions.MacroExpand=False');
    //  ����
  oParams.Add('POOL_CleanupTimeout=36000');
    //  ����
  oParams.Add('POOL_ExpireTimeout=600000');
    //���������
  oParams.Add('POOL_MaximumItems=60');
  oParams.Add('Pooled=True');
    //*******
  Mag1.Close;
  Mag1.AddConnectionDef('MSSQL_Pooled', 'MSSQL', oParams);
  Mag1.Active := True;

end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  rs: TResourceStream;
begin
  if IsFirst then
  begin
    IsFirst := False;
    if (Aini.ReadBool('YxCisSvr', 'Auto', True) = True) then
    begin
      StartSvr;
      PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    end;
    SelfAutoRun(Aini.ReadBool('YxCisSvr', 'AutoRun', False));
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
    if not FileExists('YxCisSvrDK.dll') then
    begin
      if 0 <> FindResource(hInstance, 'YKTDK', 'DLL') then
      begin
        rs := TResourceStream.Create(hInstance, 'YKTDK', 'DLL');
        rs.SaveToFile('YxCisSvrDK.dll');
        rs.Free;
      end;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  StartRunTime := GetTickCount64;
  HttpGetCount := 0;
  AINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'YxCisSvr.ini');
  if AINI.ReadBool('Register', 'NGINX', False) = False then
  begin
    if ParamStr(2) <> 'RegisterY' then
    begin
      if not CheckCPUID then
      begin
        MessageBox(Handle, 'WEBSERVICE����δע�ᣡ�밲װ��Ӧ���л�����', '����', MB_ICONERROR);
        Application.Terminate;
      end;
    end
    else if ParamStr(2) = 'RegisterY' then
    begin
      if not RegisterCPUID then
        MessageBox(Handle, 'WEBSERVICE����װʧ�ܣ������ԣ�', '����', MB_ICONERROR)
      else
        MessageBox(Handle, 'WEBSERVICE����װ�ɹ�������������', '��ʾ', MB_ICONASTERISK and MB_ICONINFORMATION);
      Application.Terminate;
    end;
  end;
  IsFirst := True;
  appendmenu(GetSystemMenu(Handle, False), MF_SEPARATOR, 0, nil);
  appendmenu(GetSystemMenu(Handle, False), MF_ByPosition + MF_String, 999, '���ݿ�����...');
  CreateTratIcons(Self);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  StartSvr;
  PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;


procedure TMainForm.btnStopClick(Sender: TObject);
begin
  StopSvr;
end;


procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @lpData);
  if BeginServer then
    FServer.Destroy;
  FreeAndNil(AINI);
end;

procedure TMainForm.StartSvr;
begin
  FServer := {$IFDEF MORMOT}TSynHTTPWebBrokerBridge{$ELSE}TIdHTTPWebBrokerBridge{$ENDIF}.Create(Self);
{$IFNDEF MORMOT}
    Port := 0;
  if ParamStr(1) <> '' then
    Port := IntToStrDef(ParamStr(1), 0);
  if Port = 0 then
    if not FServer.Active then
    begin
      FServer.Bindings.Clear;
      FServer.DefaultPort := Port;
      FServer.Active := True;
    end;
{$ENDIF}
  BeginServer := True;
  BtnStart.Enabled := False;
  BtnStop.Enabled := True;
  {if Self.Visible then
    if BtnStop.CanFocus then
      BtnStop.SetFocus;  }
  //SetDACManager;
end;

procedure TMainForm.StopSvr;
begin
  BtnStart.Enabled := True;
  BtnStop.Enabled := False;
{$IFDEF MORMOT}
  FServer.Destroy;
 // Close;
{$ELSE}
  FServer.Active := False;
  FServer.Bindings.Clear;
{$ENDIF}
  {if Self.Visible then
    if BtnStart.CanFocus then
      BtnStart.SetFocus;}
  BeginServer := False;
  FreeAndNil(oParams);
  Mag1.Active := False;
end;

procedure TMainForm.tmr1Timer(Sender: TObject);

  {function GetLinkCount(): Integer;
  begin
    if Assigned(FSvr) then
      Result := FSvr.WebService.ClientCount
    else
      Result := 0;
  end; }
begin
   try
     try
       // tmr1.Enabled := false;
        Lbl2.Caption :=Format('CPU: %f%%,�ڴ�: %sMB,�߳�: %d',
        [
          GetCPURate,
          inttostr(CurrentMemoryUsage),
          GetProcessThreadCount]);
        Lbl3.Caption := Format({'������: %d, �����߳�: %d/%d,} '%s',
        [
          {0,
          GetTaskWorkerCount(),
          GetTaskWorkerMaxCount(), }
          GetRunTimeInfo]);
        lbl6.Caption := SetHTTPCount(httpgetcount);
     except
       on e:Exception do
         PostMessage(Application.MainForm.Handle, WM_LOGDATA,
           integer(strnew(pansichar(ansistring('Timer��'+e.message)))),0);
     end;
   finally
     //tmr1.Enabled := True;
   end;
end;

procedure TMainForm.CreateTratIcons(Sender: TObject);
begin
  //��������ͼ��
  //ָ��lpData�ĳ���
  lpData.cbSize := sizeof(TNotifyIcondata);
  //ȡӦ�ó���������ľ��
  lpData.Wnd := handle;
  //�û��Զ����һ����ֵ����uCallbackMessage����ָ������Ϣ��ʹ
  lpData.uID := 0;
  //ָ���ڸýṹ��uCallbackMessage��hIcon��szTip��������Ч
  lpData.uFlags := NIF_ICON + NIF_TIP + NIF_MESSAGE + NIF_INFO;
  //ָ���Ĵ�����Ϣ
  lpData.uCallbackMessage := WM_BARICON;
  //ָ��ϵͳ״̬����ʾӦ�ó����ͼ����
  lpData.hIcon := Application.Icon.handle;
  //�����ͣ����ϵͳ״̬����ͼ����ʱ�����ָ���ʾ��Ϣ
  lpData.szTip := 'YxCisӦ�÷�����';
  shell_notifyicon(NIM_ADD, @lpData);
end;

procedure TMainForm.MSG_SYSCOMAND(var message: TMessage);
begin
  if message.WParam = SC_MINIMIZE then
  begin
    shell_notifyicon(NIM_ADD, @lpData);
    MainForm.Visible := False;
  end
  else if message.WParam = 999 then
  begin
    with TFrmSQLConnect.Create(self) do
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
  PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0)
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
    shell_notifyicon(NIM_DELETE, @lpData);
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

procedure TMainForm.MSG_HTTPListen(var message: TMessage);
var
  msg: string;
begin
   Inc(HttpGetCount);
  {msg := string(Pointer(message.wParam)^);
  if msg <> '' then
  begin
    StrPCopy(lpData.szInfoTitle,'YxCisSvr�յ�����');
    StrPCopy(lpData.szInfo,msg);
    lpData.uTimeout := 3;
    lpData.dwInfoFlags := NIIF_INFO;
    shell_notifyicon(NIM_MODIFY, @lpData);
  end;}
end;

procedure TMainForm.MSG_Log(var message: TMessage);
var
  msg: string;
  F: TextFile;
  FileName, ExeRoad, Path: string;
begin
  try
    msg := string(pansichar(message.WParam));
    if msg <> '' then
    begin
      try
        //EnterCriticalSection(cs);
        ExeRoad := ExtractFilePath(ParamStr(0));
        if not DirectoryExists(ExeRoad + '\YxCisSvrlog') then
        begin
          CreateDir(ExeRoad + '\YxCisSvrlog');
        end;
        Path := ExeRoad + '\YxCisSvrlog\' + FormatDateTime('YYMMDD', Now);
        if not DirectoryExists(Path) then
        begin
          CreateDir(Path);
        end;
        FileName := Path + '\' + FormatDateTime('YYMMDD', Now) + '-' + FormatDateTime('HH', Now) + '.TXT';
        if not FileExists(FileName) then
        begin
          AssignFile(F, FileName);
          ReWrite(F);
        end
        else
          AssignFile(F, FileName);
        Append(F);
        Writeln(F, '[' + FormatDateTime('yyyy-mm-dd hh:nn:ss:zz', Now) + ']:' + msg);
        Writeln(F, '**********************************************************************************************');
        CloseFile(F);

      except
        //�����������е���,��������
      end;
    end;
  finally
    strdispose(pansichar(message.wParam));
  end;
end;

procedure TMainForm.WinExit(var msg: TMessage);
begin
  shell_notifyicon(NIM_DELETE, @lpData);
  Application.Terminate;
end;


end.

