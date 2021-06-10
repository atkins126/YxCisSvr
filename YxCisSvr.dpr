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
  uEncry in '����\uEncry.pas',
  ElAES in '����\ElAES.pas',
  UpubFun in '����\UpubFun.pas',
  SQLFirDACPoolUnit in '����\SQLFirDACPoolUnit.pas',
  uFrmSQLConnect in '����\uFrmSQLConnect.pas' {FrmSQLConnect},
  uFrmSvrConfig in '����\uFrmSvrConfig.pas' {FrmSvrConfig},
  uFrmMQTTConfig in '����\uFrmMQTTConfig.pas' {FrmMQTTConfig},
  uDataClass in '����\uDataClass.pas',
  uDataYxCisSvr in '����\uDataYxCisSvr.pas',
  MQTT in 'MQTT\MQTT.pas',
  uFrmMQTTClient in 'MQTT\uFrmMQTTClient.pas' {FrmMQTTClient};

{$R *.res}
{$R YKTDK.RES}
var
  hMutex: HWND;
  Ret: Integer;

begin
  Application.Initialize;
  //��ʼ��������ʹ�õ�ʱ���ʽ
  formatsettings.LongDateFormat := 'yyyy-MM-dd';
  formatsettings.ShortDateFormat := 'yyyy-MM-dd';
  formatsettings.LongTimeFormat := 'HH:nn:ss';
  formatsettings.ShortTimeFormat := 'HH:nn:ss';
  formatsettings.DateSeparator := '-';
  formatsettings.TimeSeparator := ':';

  Application.Title := 'YxCisӦ�÷�����';
  if ParamStr(1) = '' then
  begin
    hMutex := CreateMutex(nil, False, 'YxCisSvr');
    Ret := GetLastError;
    ReleaseMutex(hMutex);
    if Ret = ERROR_ALREADY_EXISTS then
      Exit;
  end;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.

