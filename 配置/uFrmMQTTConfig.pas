unit uFrmMQTTConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,IniFiles,MQTT,UFrmMQTTClient,
  Vcl.ComCtrls;

type
  TFrmMQTTConfig = class(TForm)
    pnl2: TPanel;
    pnl1: TPanel;
    BtnCSLJ: TBitBtn;
    BtnMod: TBitBtn;
    BtnSave: TBitBtn;
    BtnCancel: TBitBtn;
    lbl1: TLabel;
    EdtServer: TEdit;
    lbl2: TLabel;
    EdtClientID: TEdit;
    lbl3: TLabel;
    EdtUserName: TEdit;
    EdtPass: TEdit;
    lbl5: TLabel;
    ckReConnect: TCheckBox;
    lbl4: TLabel;
    EdtSub: TEdit;
    ckSub: TCheckBox;
    lbl6: TLabel;
    EdtPub: TEdit;
    cbbSubQos: TComboBox;
    ckAutoPing: TCheckBox;
    ckRetain: TCheckBox;
    ckclearsession: TCheckBox;
    stat1: TStatusBar;
    ckMQTT: TCheckBox;
    procedure BtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnModClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnCSLJClick(Sender: TObject);
    procedure ckMQTTClick(Sender: TObject);
  private
    procedure ReadConfig;
    function BSTATUS(ISTATUS: Boolean): boolean;
    { Private declarations }
  public
    YxSCKTINI:string;
    { Public declarations }
  end;

var
  FrmMQTTConfig: TFrmMQTTConfig;

implementation

{$R *.dfm}

procedure TFrmMQTTConfig.BtnCancelClick(Sender: TObject);
begin
  BSTATUS(false);
  ReadConfig;
end;

procedure TFrmMQTTConfig.BtnCSLJClick(Sender: TObject);
begin
  with TFrmMQTTClient.Create(self) do
  try
    Position := poScreenCenter;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmMQTTConfig.BtnModClick(Sender: TObject);
begin
  BSTATUS(True);
end;

procedure TFrmMQTTConfig.BtnSaveClick(Sender: TObject);
var
  AINI: TIniFile;
begin
  AINI := TIniFile.Create(YxSCKTINI);
  try
    AINI.WriteString('MQTT', 'Server', EdtServer.Text);
    AINI.WriteString('MQTT', 'ClientID', EdtClientId.Text);
    AINI.WriteString('MQTT', 'User', EdtUserName.Text);
    AINI.WriteString('MQTT', 'Pass', EdtPass.Text);
    AINI.WriteString('MQTT', 'SubTopic', EdtSub.Text);
    AINI.WriteString('MQTT', 'PubTopic', EdtPub.Text);
    AINI.WriteBool('MQTT', 'BSub', ckSub.CHECKED);
    AINI.WriteBool('MQTT', 'Retain', ckRetain.CHECKED);
    AINI.WriteBool('MQTT', 'ReConnect', ckReConnect.CHECKED);
    AINI.WriteBool('MQTT', 'ClearSession', ckclearsession.CHECKED);
    AINI.WriteBool('MQTT', 'AutoPing', ckAutoPing.CHECKED);
    AINI.WriteInteger('MQTT', 'Qos', cbbSubQos.ItemIndex);
    AINI.WriteBool('MQTT', 'BMQTT', CKMQTT.CHECKED);
  finally
    FreeAndNil(AINI);
  end;
  MessageBox(Handle, '配置保存成功！请重启程序生效！', '提示', MB_ICONASTERISK and MB_ICONINFORMATION);
  ReadConfig;
  BSTATUS(false);
end;

procedure TFrmMQTTConfig.FormShow(Sender: TObject);
begin
  BSTATUS(false);
  ReadConfig;
end;

function TFrmMQTTConfig.BSTATUS(ISTATUS: Boolean): boolean;
begin
  pnl1.Enabled := ISTATUS;
  BtnCancel.Enabled := ISTATUS;
  BtnSave.Enabled := ISTATUS;
  BtnMod.Enabled := not ISTATUS;
  Result := True;
end;

procedure TFrmMQTTConfig.ReadConfig;
var
  Aini: TIniFile;
begin
  YxSCKTINI := ChangeFileExt(ParamStr(0), '.ini');
  if FileExists(YxSCKTINI) then
  begin
    Aini := TIniFile.Create(YxSCKTINI);
    try
      EdtServer.Text := Aini.ReadString('MQTT', 'Server', '');
      EdtClientId.Text := Aini.ReadString('MQTT', 'ClientID', '');
      EdtUserName.Text := Aini.ReadString('MQTT', 'User', '');
      EdtPass.Text := Aini.ReadString('MQTT', 'Pass', '');
      EdtSub.Text := Aini.ReadString('MQTT', 'SubTopic', '');
      EdtPub.Text := Aini.ReadString('MQTT', 'PubTopic', '');
      ckSub.CHECKED := Aini.ReadBool('MQTT', 'BSub', False);
      ckRetain.CHECKED := Aini.ReadBool('MQTT', 'Retain', False);
      ckReConnect.CHECKED := Aini.ReadBool('MQTT', 'ReConnect', False);
      ckclearsession.CHECKED := Aini.ReadBool('MQTT', 'ClearSession', False);
      ckAutoPing.CHECKED := Aini.ReadBool('MQTT', 'AutoPing', False);
      cbbSubQos.ItemIndex := Aini.ReadInteger('MQTT', 'Qos', -1);
      CKMQTT.CHECKED := Aini.ReadBool('MQTT', 'BMQTT', false);
    finally
      FreeAndNil(Aini);
    end;
  end;
end;

procedure TFrmMQTTConfig.ckMQTTClick(Sender: TObject);
var
  AINI: TIniFile;
begin
  AINI := TIniFile.Create(YxSCKTINI);
  try
    AINI.WriteBool('MQTT', 'BMQTT', CKMQTT.CHECKED);
  finally
    FreeAndNil(AINI);
    if ckMQTT.Checked then
      GetMQTT
    else
    begin
      if MQ.Connected then
        MQ.DisConnect;
    end;
  end;

end;

end.

