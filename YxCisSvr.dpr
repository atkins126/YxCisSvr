program YxCisSvr;

uses
  Forms,
  Winapi.Windows,
  System.SysUtils,
  uFrmMain in 'uFrmMain.pas' {MainForm},
  SoapImpl in 'WEB\SoapImpl.pas',
  SoapIntf in 'WEB\SoapIntf.pas',
  SynWebEnv in 'WEB\SynWebEnv.pas',
  SynWebReqRes in 'WEB\SynWebReqRes.pas',
  SynWebServer in 'WEB\SynWebServer.pas',
  uWebModule in 'WEB\uWebModule.pas' {WebModule1: TWebModule},
  uHtml in 'WEB\uHtml.pas',
  uEncry in '公用\uEncry.pas',
  ElAES in '公用\ElAES.pas',
  UpubFun in '公用\UpubFun.pas',
  SQLFirDACPoolUnit in '公用\SQLFirDACPoolUnit.pas',
  uFrmSQLConnect in '配置\uFrmSQLConnect.pas' {FrmSQLConnect},
  uFrmSvrConfig in '配置\uFrmSvrConfig.pas' {FrmSvrConfig},
  uFrmMQTTConfig in '配置\uFrmMQTTConfig.pas' {FrmMQTTConfig},
  uDataClass in '服务\uDataClass.pas',
  uDataYxCisSvr in '服务\uDataYxCisSvr.pas',
  MQTT in 'MQTT\MQTT.pas',
  uFrmMQTTClient in 'MQTT\uFrmMQTTClient.pas' {FrmMQTTClient};

{$R *.res}
{$R YKTDK.RES}
var
  hMutex: HWND;
  Ret: Integer;

begin
  Application.Initialize;
  //初始化程序中使用的时间格式
  formatsettings.LongDateFormat := 'yyyy-MM-dd';
  formatsettings.ShortDateFormat := 'yyyy-MM-dd';
  formatsettings.LongTimeFormat := 'HH:nn:ss';
  formatsettings.ShortTimeFormat := 'HH:nn:ss';
  formatsettings.DateSeparator := '-';
  formatsettings.TimeSeparator := ':';

  Application.Title := 'YxCis应用服务器';
  //禁止启动多个EXE
  if ParamStr(1) = '' then
  begin
    hMutex := CreateMutex(nil, False, 'YxCisSvr');
    Ret := GetLastError;
    ReleaseMutex(hMutex);
    if Ret = ERROR_ALREADY_EXISTS then
    begin
      MessageBox(Application.Handle, '程序已运行！', '错误', MB_ICONERROR);
      Exit;
    end;
  end;
  //检查注册信息
  if ParamStr(2) <> 'RegisterY*********' then
  begin
    if not CheckCPUID then
    begin
      MessageBox(Application.Handle, '服务未注册！请安装相应运行环境！', '错误', MB_ICONERROR);
      Exit;
    end;
  end
  else if ParamStr(2) = 'RegisterY*********' then
  begin
    if not RegisterCPUID then
      MessageBox(Application.Handle, '运行环境安装失败！请重试！', '错误', MB_ICONERROR)
    else
      MessageBox(Application.Handle, '运行环境安装成功！请重启程序！', '提示', MB_ICONASTERISK
        and MB_ICONINFORMATION);
    Exit;
  end;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.

