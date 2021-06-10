unit uDataYxCisSvr;

interface

uses
  SysUtils, Classes, Variants, OleCtrls, StrUtils, ComObj, DBClient, Forms,
  IniFiles, FireDAC.Comp.Client, DB, Winapi.ActiveX, SQLFirDACPoolUnit,
  uDataClass, msxml, Winapi.Messages, Winapi.Windows, EncdDecd;

type
  TYXSVR = class
  private
    LstDJH:TStringList;//��Ŀ�˷ѵ��ݺ�list/���ص��շѻ����˷ѵ��ݺ�
    SDBLX: string;     //�������ݿ��׺
    FCBH: string;      //���뵥��
    FIBRLX: Integer;   //�������� 0�����1��סԺ
    FAmode: string;    //���뵥���� JC,JY
    Rdata: TDateTime;  //���ݿ������ʱ��
    Flag: Integer;     //�������� 1��0��
    FCYLH: string;     //����
    FCYLKMW: string;   //������
    FCBRH: string;     //����/סԺ��
    FCSFD: string;     //�����շѵ���
    FBQ: string;       //סԺ���˲���
    FCCZY:string;      //�շѲ���Ա

    TBXXWZX: string;   //���뵥��Ϣδִ�б�
    TBXMWZX: string;   //���뵥��Ŀδִ�б�
    TBMXWZX: string;   //���뵥��ϸδִ�б�
    TBXXWGD: string;   //���뵥��Ϣδ�鵵��
    TBXMWGD: string;   //���뵥��Ŀδ�鵵��
    TBMXWGD: string;   //���뵥��ϸδ�鵵��
    TBBGXX: string;    //���浥��Ϣ��
    TBBGMX: string;    //���浥��ϸ��
    TBBGBGMX: string;  //���浥�����ϸ��
    TBYZYJWZX: string;  //ҽ��ҽ����Ϣ��
    TBYZBYZYLBQ: string; //ҽ����ҽ��ҽ�Ʋ�����

    FMRZXKSBM: string; //�շ�Ĭ��ִ�п��ұ���
    FMRZXKSMC: string; //�շ�Ĭ��ִ�п�������
    FSQDZXKSCLFS: string; //���뵥ִ�п��Ҵ���ʽ
    FCZYGH: string; //����Ա����
    FCZYMC: string; //����Ա����
    FIKS: string;   //����Ա���ұ���
    FCKS: string;   //����Ա��������
    FIZXKS: string; //����Աִ�п��ұ���
    FCZXKS: string; //����Աִ�п�������
    FBFJF: Boolean;    //�Ƿ���ȡ���ӷ�
    FBSFZX: Boolean;   //�շ��Ƿ�ͬʱִ��
    FBYKTJZ: Boolean;  //һ��ͨ�ܷ�Ƿ��
    FBZTDCSF: Boolean; //�����Ŀ�Ƿ񵥴��շ�
    FBTFCSDCSF: Boolean; //�˷�����ʱ�����շѱ��
    FBQYLYZ: Boolean;    //���뵥�Ƿ�д��ҽ��ҽ����
    FBSFKZ: Boolean;     //δ�շ��Ƿ���ִ�У�����
    FBZXKZ: Boolean;     //δִ���Ƿ��ܱ���
    AMZFYMX, AFYMXTF: TMZFYMX;    //���������ϸ��
    AZYFYMX: TZYFYMX;            //סԺ������ϸ��
    AMZBR: TMZBR;                //���ﲡ����
    AZYBR: TZYBR;                //סԺ������
    MZHZE, MZHZF, MJZJE, MZHYE: Currency; //�˻����˻�֧���������ܶ�˻����
    QTZTLIST: TStringList;  //ȫ�˼����Ŀ
    WTFZTLIST: TStringList; //�����˷ѣ�δ�˼����Ŀ�����շ�
    CZTBMLIST: TStringList; //Ҫ�˼����Ŀ
    CDCSFZT: string; //�����շѼ����Ŀ
    CDCSF: string;   //�����շѵ��ַ���
    CGLSQL: string;  //�������Ϸ�SQL
    DSJ: TDateTime;  //EXecCharge����ʱ��
    function GetRdata: Tdatetime;
    procedure GetMode(CSQDH: string; out BH, CLX: string);
    function CheckSQD(AQry: TFDQuery): Boolean;
    procedure SetTBInfo;
  public
    /// <summary>������Ϣ</summary>
    AERROR: string;
    /// <summary>���ݿ�����</summary>
    DATABASE: TFDConnection;
    /// <summary>�µ��������뵥��</summary>
    MAKESQDH: string;
    /// <summary>�⿨���ؿ���</summary>
    ReadCardH: string;
    /// <summary>��������</summary>
    /// <param name="CYKT">����������</param>
    /// <param name="CDBLX">�����׺�����������ݿ⴫��ֵ</param>
    function ReadCard(CYKT: string; CDBLX: string = ''): Boolean; stdcall;
    //�´����뵥   ���� 0����� 1������|�������� 0������ 1��סԺ|���˺�|ģ����|�����Ŀ����|��������
    function MakeSQD(ILX, IBRLX: Integer; const CBRH: string; MRCMBBH: string;
      MRCZTBM: string; CKDKSBM: string = ''; CKDKSMC: string = ''; CDBLX: string
      = ''; CST: string = 'CSTXX5'; CRY: string = ''): Boolean; stdcall;
    //ɾ�����뵥  ���� 0����� 1������|�������� 0������ 1��סԺ|���˺�|���뵥��|��������
    function DelSQD(ILX, IBRLX: Integer; const CBRH, CSQDH: string; CDBLX:
      string = ''): Boolean; stdcall;
    //�Ǽ� �������� 0ȡ���Ǽ�1�Ǽ�|�������� 0������ 1��סԺ|���˺�|���뵥��|�����Ŀ����
    function WriteRegInfo(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM: string; CDBLX:
      string = ''): Boolean; stdcall;
    //���뵥�շ�   ���� 0���˷� 1���շ�|�������� 0������ 1��סԺ|���˺�|���뵥��=�����Ŀ����1,2,3|Ĭ��ִ�п��ұ���
    function DoCharge(ILX, IBRLX: Integer; CZY, CBRH, CSQDH: string; CMRZXKSBM:
      string = ''; CDBLX: string = ''): Boolean; stdcall;
    //ִ�����뵥   ���� 0��ȡ��ִ�� 1��ִ��|�������� 0������ 1��סԺ|���˺�|���뵥��|�����Ŀ����
    function DoPerForm(ILX, IBRLX: Integer; CBRH, CSQDH: string; CDBLX: string =
      ''): Boolean; stdcall;
    //���� �������� 0ȡ������1����|�������� 0������ 1��סԺ|���˺�|���뵥��|�����Ŀ����|���浥XML����
    function WriteReport(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, XMLDATA:
      string; CDBLX: string = ''): Boolean; stdcall;
    //�շ���Ŀ�����շ�
    function ExecCharge(Invalue: string; out OutValue: string): Boolean;
    //http����
    function DoExcute(InValue: string; out OutValue: string): Boolean;
    //���HTTP����Ƿ���ϱ�׼
    function CheckInvalue(InNode: IXMLDOMNode; out OutValue: string): Boolean;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    //��ȡ����
    function GetTBName(MBTableName: string; Invalue: string = ''; DefType:
      Integer = 7; InDate: TDateTime = 0): string;
    //��ȡ�� BeginDate-endDate�����б�
    function GetNkTables(MBTableName: string; BeginDate, endDate: TDateTime): Tstrings;
    //������ݿ�
    function DataBaseCheck(DbName: string): boolean;
    //����
    function TableCheck(Tablename: string): boolean;
    //��ȡ����
    function GetUserParam(CNBMC: string; DefValue: string): string; overload;
    function GetUserParam(CNBMC: string; DefValue: Integer): Integer; overload;
    function GetYXXTCSI(CCSMC: string; DefValue: string): string; overload;
    function GetYXXTCSI(CCSMC: string; DefValue: Integer): Integer; overload;
    //��ȡ��ˮ��
    function GetSysNumber2(CBH: string; Diff: Integer; TJ: string): string;
    //ִ��SQL���
    function ExeSql(AQuery: TFDQuery; CSQL: string; ExecFlag: Boolean;
      FunctionName: string = ''): Boolean; overload;
    function ExeSql(AQuery: TFDQuery; CSQL: wideString): Integer; overload;
    //iif����
    function iif(Expr: Boolean; vTrue, vFalse: string): string; overload;
    function iif(Expr: Boolean; vTrue, vFalse: integer): integer; overload;
    function iif(Expr: Boolean; vTrue, vFalse: TDateTime): TDateTime; overload;
    function iif(Expr: Boolean; vTrue, vFalse: Boolean): Boolean; overload;
    //����ַ���
    function Addstr(Ostr: string; Astr: string; Lnum: integer): string; //�ַ������
    //if True result 1 else result 0
    function BoolToStr(B: Boolean): string;
    function GetNextEle(inElemList: IXMLDOMNodeList): IXMLDOMElement;
    function GetFirstEle(inElemList: IXMLDOMNodeList): IXMLDOMElement;
    function LoadXMLText(AXML: IXMLDOMDocument2; AText: WideString): Boolean;
    {�Ƿ���������}
    function InTransaction(ConnectType: Integer = 1): Boolean;
    {��ʼ����}
    function StartTransaction(ConnectType: Integer = 1; AutoRollBack: Boolean =
      True): IInterface;
    {�ύ����}
    procedure Commit(ConnectType: Integer = 1);
    {�ع�����}
    procedure Rollback(ConnectType: Integer = 1);
    //��ȡ����Ա��Ϣ
    function GetCZY(CZY: string): boolean;
    //������ݿ�����
    function CheckDataBase: boolean;
    //��ʼ����
    function InitClass(ILX, IBRLX: Integer): boolean;
    //�ͷ���
    procedure DestroyClass;
    //�����
    function CheckLock(ITYPE: Integer): Boolean;
    //����
    function Lock(ITYPE: Integer): Boolean;
    //����
    function UnLock(ITYPE: Integer): Boolean;
    //������
    function CheckCardNo(const Card: WideString): Integer;
    //��ȡ�����
    function GetMZHYE: Boolean;
    //��ȡGCP���
    function GetIGCP: integer;
    //******************************���ô���***************************
    //׼��סԺ������ϸ
    function SetZYFYMX(TmpLIST: TStringlist): Boolean;
    //����סԺ��������
    function SaveZYFYMX: Boolean;
     //׼�����������ϸ
    function SetMZFYMX(TmpLIST: TStringlist): Boolean;
    //׼�������˷���ϸ
    function SetMZFYMXTF(TmpLIST: TStringList): Boolean;
    //���������������
    function SaveMZFYMX(ILX: Integer): Boolean;
    //����һ��ͨ��������
    function SaveYKTFYMX(AMZFYMX: TMZFYMX): Boolean;
    //****************************���ӷ��ô���*****************************************
    //׼�����ӷ�����ϸ
    function SetFJF(TmpNode: IXMLDOMNode): Boolean;
    //���渽�ӷ�����ϸ
    function SaveFJF:Boolean;
    //д��־��¼
    procedure Writelog(Msg: string);
  end;

implementation

uses
  Math, ElAES;

type
  TAutoRollback = class(TInterfacedObject)
  private
    FConnectType: Integer;
    UYXSvr: TYXSVR;
  public
    destructor Destroy; override;
  end;

destructor TAutoRollback.Destroy;
begin
  if UYXSvr.InTransaction(FConnectType) then
  begin
    //�ع�
    UYXSvr.Rollback(FConnectType);
    //��־
    UYXSvr.AERROR := '�Զ��ع�������,' + UYXSvr.AERROR;
    //if Screen.ActiveForm<>nil then UYXSvr.AERROR := UYXSvr.AERROR +'('+ Screen.ActiveForm.ClassName+')';
  end;
  inherited;
end;

{
function DecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128): string;
function HexToStr(Value: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Value) do
  begin
    if ((I mod 2) = 1) then
      Result := Result + Chr(StrToInt('0x'+ Copy(Value, I, 2)));
  end;
end;
var
  SS, DS: TStringStream;
  Size: Int64;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
begin
  Result := '';
  SS := TStringStream.Create(HexToStr(Value));
  DS := TStringStream.Create('');
  try
    Size := SS.Size;
    SS.ReadBuffer(Size, SizeOf(Size));
    //  --  128 λ�ܳ���󳤶�Ϊ 16 ���ַ� --
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0 );
      Move(PChar(Key)^, AESKey128, Min(SizeOf(AESKey128), Length(Key)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey128, DS);
    end;
    //  --  192 λ�ܳ���󳤶�Ϊ 24 ���ַ� --
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0 );
      Move(PChar(Key)^, AESKey192, Min(SizeOf(AESKey192), Length(Key)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey192, DS);
    end;
    //  --  256 λ�ܳ���󳤶�Ϊ 32 ���ַ� --
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0 );
      Move(PChar(Key)^, AESKey256, Min(SizeOf(AESKey256), Length(Key)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey256, DS);
    end;
    Result := DS.DataString;
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
end;

}

procedure TYXSVR.Writelog(MSG: string);
var
  PS: PString;
begin
  New(PS);
  PS^ := MSG;
  PostMessage(Application.MainForm.Handle, WM_USER + 201, 0, Integer(PS));
end;

function TYXSVR.GetIGCP: integer;
const
  FunctionName = 'GetIGCP';
var
  QryGCP: TFDQuery;
  CSQL: string;
begin
  Result := 0;
  QryGCP := TFDQuery.Create(nil);
  try
    CSQL := 'select * from ' + TBXXWZX + ' with(nolock) where CBH=' + QuotedStr(FCBH);
    if not ExeSql(QryGCP, CSQL, False) then
      Exit;
    if QryGCP.ISEMPTY then
      Exit;
    if QryGCP.FindField('IGCP') <> nil then
      Result := QryGCP.FieldByName('IGCP').AsInteger;
  finally
    FreeAndNil(QryGCP);
  end;
end;

function TYXSVR.GetMZHYE: Boolean;
const
  functionname = 'TYXSVR.GetMZHYE';
var
  QryTemp: TFDQuery;
  CSQL: string;
begin
  Result := False;
  QryTemp := TFDQuery.Create(nil);
  try
    CSQL := 'select MZHZE,MZHZF,MJZJE from ' + SDBLX + '..TBICXX  where CICID='
      + QuotedStr(FCYLH);
    if not ExeSql(QryTemp, CSQL, False) then
      Exit;
    //��Ҫ������ȡһ��,Ϊ��Ч�ʴ˴���ʹ��ReadOnlyOne��ȡ --����With(nolock)
    with QryTemp do
    begin
      MZHZE := Fields[0].AsCurrency;
      MZHZF := Fields[1].AsCurrency;
      MJZJE := Fields[2].AsCurrency;
      MZHYE := MZHZE - MZHZF - MJZJE;
    end;
  finally
    FreeAndNil(QryTemp);
  end;
  Result := True;
end;

function TYXSVR.CheckLock(ITYPE: Integer): Boolean;
const
  FunctionName = 'CheckLock';
var
  CSQL: WideString;
  CFCGX: string;
  CIP: string;
  AQry: TFDQuery;
begin
  //ITYPE=1 ���ʣ�2��Ժ��3ת��,4��;����,5��Ϣ�޸�,6ҽ��ִ��
  //7ҽ�����,8ҽ��ǩ��,9�������,10ҽ�����ȡ��,11δ���˳�Ժȡ��,
  //12��;����ȡ��,13�����ҷ���¼��,14�����ҷ���ִ��,15���䷢ҩ,
  //16ҽ��Ԥͣ���,17������д
  //21������ҳ 22 ת��(��)ҽ�Ʊ���; 23 ���� ;24 �ٴ�·��������;25ҽ��ִ��
  //26ҽ��ҽ��ִ�г���;27������Ŀִ�г���;28 ҩƷҽ������ֵ�;
  //29 ҩƷҽ������ֵ����� ; 30���̼�¼;
  Result := False;
  CIP := '127.0.0.999';
  AQry := TFDQuery.Create(nil);
  try
    CSQL := 'select CFCGX from ' + SDBLX + '..TBZDZYCL with(nolock) where IBM='
      + IntToStr(ITYPE);
    if not ExeSql(AQry, CSQL, False) then
      Exit;
    if AQry.IsEmpty then
    begin
      AERROR := '��TBZDZYCL����û�в鵽��ؼ�¼��CSQL=' + CSQL;
      Exit;
    end;
    CFCGX := AQry.FieldByName('CFCGX').AsString + ',25';
    CSQL := 'select CCZYXM,CTYPE,CXTMC,CIP from ' + SDBLX +
      '..tbzycl with(nolock) where CZYH =' + QuotedStr(FCBRH);
    CSQL := CSQL + ' and ITYPE in (' + CFCGX + ')';
    if not ExeSql(AQry, CSQL, False) then
      Exit;
    with AQry do
    begin
      if not IsEmpty then
      begin
        AERROR := '����Ա:' + FieldByName('CCZYXM').AsString + '����Ϊ�ò��˰���' +
          FieldByName('CTYPE').AsString + '+1+12+|' +
          '������Ϊ�˲��˰���ҵ��+1+12+|' + '����ϵͳ��:' + FieldByName('CXTMC').AsString +
          '+1+12+|' + '��������IP:' + FieldByName('CIP').AsString + '+1+12+|';
        Exit;
      end;
    end;
  finally
    FreeAndNil(AQry);
  end;
  Result := True;
end;

function TYXSVR.Lock(ITYPE: Integer): Boolean;
const
  FunctionName = 'Lock';
var
  CSQL: WideString;
  CIP: string;
  CFCGX: string;
  CTYPE: string;
  CCZYBQ: string;
  AQry: TFDQuery;
begin
  Result := False;
  //ITYPE=1 ���ʣ�2��Ժ��3ת��,4��;����,5��Ϣ�޸�,6ҽ��ִ��
  //7ҽ�����,8ҽ��ǩ��,9�������,10ҽ�����ȡ��,11δ���˳�Ժȡ��,
  //12��;����ȡ��,13�����ҷ���¼��,14�����ҷ���ִ��,15���䷢ҩ,
  //16ҽ��Ԥͣ���,17������д ;18:��λ���� ,19��ҽ����Ŀ,20��ҩ��(������ҩ)
  //21������ҳ 22 ת��(��)ҽ�Ʊ���; 23 ���� ;24 �ٴ�·��������;25ҽ��ִ��
  //26ҽ��ҽ��ִ�г���;27������Ŀִ�г���;28 ҩƷҽ������ֵ�;
  //29 ҩƷҽ������ֵ����� ; 30���̼�¼;
  CIP := '0.0.0.0';
  AQry := TFDQuery.Create(nil);
  try
    CSQL := 'select IBM,CFCGX,CMC from ' + SDBLX + '..TBZDZYCL with(nolock)';
    if not ExeSql(AQry, CSQL, False) then
      Exit;
    with AQry do
    begin
      if not Locate('IBM', ITYPE, []) then
      begin
        AERROR := 'Lock Type ' + IntToStr(ITYPE) + ' ��Ч';
        Exit;
      end;
      CFCGX := FieldByName('CFCGX').AsString;
      CTYPE := FieldByName('CMC').AsString;
      CTYPE := '�������תסԺ';
    end;
    CSQL := 'select CCZYXM,CTYPE from ' + SDBLX +
      '..TBZYCL with(nolock) where CZYH=' + QuotedStr(FCBRH) + ' and ITYPE in ('
      + CFCGX + ')';
    if not ExeSql(AQry, CSQL, False) then
      Exit;
    if not AQry.IsEmpty then
    begin
      AERROR := AQry.FieldByName('CCZYXM').AsString + '���ڽ���' + AQry.FieldByName('CTYPE').AsString
        + '����';
      Exit;
    end;

    CCZYBQ := '��';
    CSQL := 'insert into ' + SDBLX +
      '..tbzycl(CYLH,CZYH,CTYPE,CCZY,CCZYXM,CIP,ITYPE,DLock,CCZYBQ,CBRXM,CBRBQ,CXTMC,CCDMC)VALUES(' +
      QuotedStr(AZYBR.CYLH) + ',' + QuotedStr(FCBRH) + ',' + QuotedStr(CTYPE) +
      ',' + QuotedStr(FCZYGH) + ',' + QuotedStr(FCZYMC) + ',' + QuotedStr(CIP) +
      ',' + IntToStr(ITYPE) + ',' + Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS',
      rdata)) + ',' + QuotedStr(CCZYBQ) + ',' + QuotedStr(AZYBR.CXM) + ',' +
      QuotedStr(AZYBR.CZYBQ) + ',' + QuotedStr('YxCisSvr�շ�ҵ��') + ',' + QuotedStr
      ('YxCisSvr����ӿ�') + ')';
    if not ExeSql(AQry, CSQL, True) then
      Exit;
  finally
    FreeAndNil(AQry);
  end;
  Result := True;
end;

function TYXSVR.UnLock(ITYPE: Integer): boolean;
var
  CSQL: WideString;
  AQry: TFDQuery;
begin
  Result := False;
  if FIBRLX = 0 then Exit;
  AQry := TFDQuery.Create(nil);
  try
    CSQL := 'Delete from ' + SDBLX +
      '..tbzycl where IID in (Select IID from ' + SDBLX +
      '..tbzycl with(nolock) where Czyh=' +
      QuotedStr(FCBRH) + '  and Itype=' + IntToStr(ITYPE);
    CSQL := CSQL + ' and CCZY=''' + FCZYGH + '''';
    CSQL := CSQL + ')';
    if not ExeSql(AQry, CSQL, True) then
      Exit;
  finally
    FreeAndNil(AQry);
  end;
  Result := True;
end;

procedure TYXSVR.DestroyClass;
begin
  if AMZFYMX <> nil then
    FreeAndNil(AMZFYMX);
  if AZYFYMX <> nil then
    FreeAndNil(AZYFYMX);
  if AFYMXTF <> nil then
    FreeAndNil(AFYMXTF);
  if AMZBR <> nil then
    FreeAndNil(AMZBR);
  if AZYBR <> nil then
    FreeAndNil(AZYBR);
end;

function TYXSVR.InitClass(ILX, IBRLX: Integer): Boolean;
var
  CSQL: string;
  QryClass: TFDQuery;
begin
  Result := False;
  QryClass := TFDQuery.Create(nil);
  try
    if IBRLX = 0 then
    begin
      AMZFYMX := TMZFYMX.Create;
      AMZFYMX.ClearItems;
      if ILX = 0 then
      begin
        AFYMXTF := TMZFYMX.Create;
        AFYMXTF.ClearItems;
      end;
      AMZBR := TMZBR.Create;
      CSQL := 'SELECT TOP 1 * FROM ' + GetTBName('TBMZGHMX', FCBRH, 4) +
        ' WITH(NOLOCK) WHERE BTH=0 AND CMZH=' + QuotedStr(FCBRH);
      if not ExeSql(QryClass, CSQL, False) then
        Exit;
      if not AMZBR.ReadFromQry(QryClass) then
      begin
        AERROR := 'δ��ѯ�����˹Һ���Ϣ,��ȷ�ϣ�CSQL=' + CSQL;
        Exit;
      end;
    end
    else if IBRLX = 1 then
    begin
      AZYFYMX := TZYFYMX.create;
      AZYFYMX.ClearItems;
      AZYBR := TZYBR.Create;
      CSQL := 'SELECT TOP 1 * FROM ' + SDBLX +
        '..VTBZYBR WITH(NOLOCK) WHERE CZYH=' + QuotedStr(FCBRH);
      if not ExeSql(QryClass, CSQL, False) then
        Exit;
      if not AZYBR.ReadFromQry(QryClass) then
      begin
        AERROR := 'δ��ѯ��������Ժ��Ϣ,��ȷ�ϣ�CSQL=' + CSQL;
        Exit;
      end;
    end;
  finally
    FreeAndNil(QryClass);
  end;
  Result := True;
end;

function TYXSVR.CheckDataBase: Boolean;
begin
  Result := False;
  if (DATABASE = nil) then
    raise Exception.Create('�����ݿ����ӣ����飡');
  Result := True;
end;

function TYXSVR.GetCZY(CZY: string): Boolean;
const
  FunctionName = 'GetCZY';
var
  CSQL: string;
  QryCZY: TFDQuery;
begin
  Result := False;
  FCZYGH := '';
  FCZYMC := '';
  QryCZY := TFDQuery.Create(nil);
  try
    CSQL := 'SELECT CGH,CMC FROM ' + SDBLX + '..TBCZY WITH(NOLOCK) WHERE CSRM=' +
      '(SELECT CUID FROM ' + SDBLX + '..TBSYSCZY with(nolock) WHERE cbh=' +
      quotedstr(CZY) + ') AND CCXBH=''40''';
    if not ExeSql(QryCZY, CSQL, false) then
      Exit;
    if QryCZY.IsEmpty then
    begin
      AERROR := 'δ�ҵ���Ӧ�Ĳ���Ա��' + CSQL;
      exit;
    end;
    FCZYGH := QryCZY.FIELDBYNAME('CGH').ASSTRING;
    FCZYMC := QryCZY.FIELDBYNAME('CMC').ASSTRING;
    if FMRZXKSBM <> '' then
      CSQL := 'SELECT CBM,CMC FROM ' + SDBLX +
        '..tbzdzxks WITH(NOLOCK) WHERE CBM=' + Quotedstr(FMRZXKSBM)
    else
      CSQL := 'SELECT CBM,CMC FROM ' + SDBLX +
        '..tbzdzxks WITH(NOLOCK) WHERE CYJKSBM=' + '(SELECT CKSBM FROM ' + SDBLX
        + '..TBZDYJYS with(nolock) WHERE CCZYGH=' + quotedstr(CZY) + ')';
    if not ExeSql(QryCZY, CSQL, false) then
      Exit;
    if QryCZY.IsEmpty then
    begin
      AERROR := 'δ�ҵ���Ӧ��ִ�п��ң�' + CSQL;
      exit;
    end;
    FIZXKS := QryCZY.FIELDBYNAME('CBM').ASSTRING;
    FCZXKS := QryCZY.FIELDBYNAME('CMC').ASSTRING;
  finally
    FreeAndNil(QryCZY);
  end;
  Result := True;
end;

function TYXSVR.InTransaction(ConnectType: Integer): Boolean;
begin
  Result := False;
  if Assigned(DATABASE) then
  begin
    Result := Result or DATABASE.InTransaction;
  end;
end;

function TYXSVR.StartTransaction(ConnectType: Integer; AutoRollBack: Boolean): IInterface;
var
  aAutoObject: TAutoRollback;
begin
  if Assigned(DATABASE) then
  begin
    if InTransaction(2) then
      Rollback(2);
    //���ñ�StartTransaction��������̽����󽫣��������ڣ������Զ��ع�����
    if AutoRollBack then
    begin
      aAutoObject := TAutoRollback.Create;
      aAutoObject.FConnectType := 2;
      aAutoObject.UYXSvr := Self;
      Result := aAutoObject as IInterface;
    end;
    //��ʼ����
    DATABASE.StartTransaction;
  end;
end;

procedure TYXSVR.Commit(ConnectType: Integer);
begin
  if Assigned(DATABASE) then
    if InTransaction(2) then
      DATABASE.Commit;
end;

procedure TYXSVR.Rollback(ConnectType: Integer);
begin
  if Assigned(DATABASE) then
    if InTransaction(2) then
      DATABASE.Rollback;
end;

constructor TYXSVR.Create(AOwner: TComponent);
begin
  SDBLX := 'YXHIS';
  DATABASE := DACPool.GetCon(DAConfig);
 { DATABASE:= TFDConnection.Create(nil);
  with DATABASE do
  begin
    ConnectionDefName := 'MSSQL_Pooled';
    try
      Connected := True;
    except
      raise Exception.Create('���ݿ�����ʧ�ܣ��������ݿ����û����������ӣ�');
    end;
  end;   }
  Rdata := GetRdata;
end;

destructor TYXSVR.Destroy;
begin
  DACPool.PutCon(DATABASE);
  //FreeAndNil(DATABASE);
  inherited;
end;

function TYXSVR.ExecCharge(Invalue: string; out OutValue: string): Boolean;
const
  FunctionName = 'ExecCharge';
var
  TmpNode: IXMLDOMNode;
  InMainXML: IXMLDOMDocument2;
  CSQL, CBRID, USEYLKH, CDBLX: string;
  QRYTEMP: TFDQuery;
begin
  Result := False;
  OutValue := '';
  try
    LstDJH := TStringList.Create;
    QRYTEMP := TFDQuery.Create(NIL);
    InMainXML := CoDOMDocument.Create;
    LstDJH.Text := '';
    if not LoadXMLText(InMainXML, Invalue) then
    begin
      AERROR := '����XML����:' + AERROR + ',XML=' + Invalue;
      Exit;
    end;
    TmpNode := InMainXML.selectSingleNode('SFGL');
    if TmpNode = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<SFGL>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    if TmpNode.selectSingleNode('ITYPE') = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<ITYPE>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    flag := StrToIntDef(TmpNode.selectSingleNode('ITYPE').text, -1);  //(1���շѣ�0���˷�)
    if TmpNode.selectSingleNode('CSFR') = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<CSFR>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    FCCZY := VarToStrDef(TmpNode.selectSingleNode('CSFR').text, '');
    if TmpNode.selectSingleNode('CDJH') = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<CDJH>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    LstDJH.Text := VarToStrDef(TmpNode.selectSingleNode('CDJH').text, '');
    if TmpNode.selectSingleNode('BRX') = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<BRX>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    FIBRLX := StrToIntDef(TmpNode.selectSingleNode('BRX/BRX.ILX').text, -1);  //��0�����1��סԺ��
    FCBRH := VarToStrDef(TmpNode.selectSingleNode('BRX/BRX.CBRH').text, '');

    if TmpNode.selectSingleNode('CYLKH') = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<CYLKH>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    USEYLKH := VarToStrDef(TmpNode.selectSingleNode('CYLKH').text, ''); //����
    try
      DSJ := strtodatetime(TmpNode.selectSingleNode('BRX/BRX.DSJ').text);
    except
      on e: Exception do
      begin
        AERROR := '������Ϣ: ' + E.Message;
        Exit;
      end;
    end;
    //Rdata := DSJ;
    if (FIBRLX = -1) or (flag = -1) or (FCBRH = '') then
    begin
      AERROR := 'XML����ֵ��������CBRH or ITYPE or BRX/BRX.ILX,���飡' + #13#10 + Invalue;
      Exit;
    end;
    if (flag = 0) and (LstDJH.Text = '') then
    begin
      AERROR := 'XML����ֵ��������CDJHΪ��,���飡' + #13#10 + Invalue;
      Exit;
    end;
    if TmpNode.selectSingleNode('CDBLX') = nil then
    begin
      AERROR := 'XML����ֵ����ΪNil����<CDBLX>�ڵ�,���飡' + #13#10 + Invalue;
      Exit;
    end;
    CDBLX := VarToStrDef(TmpNode.selectSingleNode('CDBLX').text, ''); //�������ݿ��׺
    if CDBLX <> '' then
      SDBLX := SDBLX + CDBLX;
    if flag = 1 then
    begin
      TmpNode := TmpNode.selectSingleNode('DATA.GRP');
      if TmpNode = nil then
      begin
        AERROR := 'XML����ֵ����ΪNil����<DATA.GRP>�ڵ�,���飡' + #13#10 + Invalue;
        Exit;
      end;
    end;
    if not InitClass(flag, FIBRLX) then
      Exit;
    if FIBRLX = 1 then
    begin
      if AZYBR.BDD then
      begin
        AERROR := '�����Ѿ���Ժ����������ˣ�';
        exit;
      end;
      if not CheckLock(1) then
        Exit;  //��ⲡ����
      if not Lock(1) then
        Exit;  //��Ӳ�����
    end
    else if (FIBRLX = 0) then
    begin
      if USEYLKH = '' then
      begin
        AERROR := 'δ���뿨�ţ����飡';
        Exit;
      end;
      if CheckCardNo(USEYLKH) <> 1 then
      begin
        AERROR := '��������' + AERROR;
        Exit;
      end;
      CSQL := 'SELECT CBRID FROM ' + SDBLX +
        '..TBICXX WITH(NOLOCK) WHERE CICID=' + quotedstr(FCYLH);
      if not ExeSql(QRYTEMP, CSQL, False, FunctionName) then
        Exit;
      if QRYTEMP.IsEmpty then
      begin
        AERROR := 'TBICXX��δ�ҵ���Ӧ����[' + FCYLH + ']�����飡' + CSQL;
        Exit;
      end;
      CBRID := QRYTEMP.fieldbyname('CBRID').AsString;
      if CBRID <> '' then
      begin
        if AMZBR.CBRID <> CBRID then
        begin
          AERROR := '��ҽ�ƿ����ǵ�ǰ�������������飡';
          Exit;
        end;
      end;
      if not GetMZHYE then
      begin
        AERROR := '��ȡ��������';
        Exit;
      end;
    end;
    if not SetFJF(TmpNode) then
    begin
      AERROR := '��������׼��ʧ�ܣ�' + AERROR;
      Exit;
    end;
    try
      if InTransaction(2) then
        Rollback(2);
      StartTransaction(2);
      if not SaveFJF then Exit;
      Commit(2);
    except
      if InTransaction(2) then
        Rollback(2);
    end;
    OutValue := StringReplace(LstDJH.Text, #13#10,'|', [rfReplaceAll]);
  finally
    UnLock(1);
    DestroyClass;
    FreeAndNil(LstDJH);
    FreeAndNil(QRYTEMP);
    InMainXML := nil;
  end;
  Result := True;
end;

function TYXSVR.SetFJF(TmpNode: IXMLDOMNode): Boolean;
const
  FunctionName = 'SetFJF';
var
  IID: Integer;
  CJZD: string;
  I, IXH, NSL: Integer;
  TmpQry: TFDQuery;
  CSQL, CYKTZFFS: string;
  NMDJ: Currency;
  CTFTJ: string;
  TBFYMXS: TStrings;

  function ADDFJF: Boolean;
  begin
    Result := False;
    try
      if FIBRLX = 0 then
      begin
        with AMZFYMX.AItem, AMZFYMX, TmpQry do
        begin
          CSFD := FCSFD;    //�շѵ���
          CJZD := FCSFD;    //�շѵ���
          CFPH := '';              //��Ʊ��
          DJZRQ := Rdata;
          CMZH := AMZBR.CMZH;
          CYLH := AMZBR.CYLH;
          CXM := AMZBR.CXM;
          CXB := AMZBR.CXB;
          CNL := AMZBR.CNL;
          IKS := AMZBR.IKSBM;
          CKS := AMZBR.CKSMC;
          IYS := AMZBR.IYSBM;
          CYS := AMZBR.CYSMC;
          IBRDW := 0;
          CBRDW := '';
          ISFZL := AMZBR.ISFZL;
          CSFZL := AMZBR.CSFZL;
          IGRYH := 1;
          IXMYH := 1;
          IIXH := I + 1;
          IXH := I + 1;
          CXMBM := FieldByName('cbm').AsString;
          CXMMC := FieldByName('CMC').AsString;
          CDW := FieldByName('CDW').AsString;
          CDJH := '';
          ISL := NSL;
          MDJ := NMDJ;
          //����
          MYSJE := MDJ * ISL;
          MSSJE := 0;
          MJZJE := MYSJE * IXMYH;
          MSJJZ := MJZJE;
          CSSBH := '';
          CSFRGH := Fczygh;
          CSFR := Fczymc;
          CBZ := '';
          CYBH := '';
          CZXKSBM := FIZXKS;
          CZXKSMC := FCZXKS;
          CPYM := AMZBR.CPYM;
          IYKT := 1;
          ISFFS := StrToIntDef(COPY(CYKTZFFS, 1, Pos('|', CYKTZFFS) - 1), 0);
          CSFFS := COPY(CYKTZFFS, Pos('|', CYKTZFFS) + 1, length(CYKTZFFS));
          BGRTF := False;
          CZHSFXMBM := '';
          CZHSFXMMC := '';
          BTF := False;
          CCWTJ := FieldByName('CCWTJ').AsString;
          CFYTJ := FieldByName('CFYTJ').AsString;
          DGH := AMZBR.DGH;
          DYJZRQ := 0;
          AMZFYMX.AddItem;
        end;
      end
      else if FIBRLX = 1 then
      begin
        with AZYFYMX, AZYFYMX.AItem, TmpQry do
        begin
          CZYH := AZYBR.CZYH;
          CYLH := AZYBR.CYLH;
          CXM := AZYBR.CXM;
          CXB := AZYBR.CXB;
          CNL := AZYBR.CNL;
          IDYLB := AZYBR.ISFZL;
          CDYLB := AZYBR.CSFZL;
          IZTJZ := AZYBR.IZTJZCS;
          IZYKS := AZYBR.IZYKS;
          CZYKS := AZYBR.CZYKS;
          IZYBQ := AZYBR.IZYBQ;
          CZYBQ := AZYBR.CZYBQ;
          IZYYS := AZYBR.IZYYS;
          CZYYS := AZYBR.CZYYS;
          CDJH := '';
          CSFXM := FieldByName('CMC').AsString;
          ISL := NSL;
          MDJ := NMDJ;
          CDW := FieldByName('CDW').AsString;
          CSFXMBM := fieldbyname('CBM').ASSTRING;
          ICWBM := FieldByName('ICWBM').AsString;
          IFYBM := FieldByName('IFYBM').AsString;
        //itype 0���� 1����  IBZ 0סԺ 1 ����
          CCWTJ := FieldByName('CCWTJ').AsString;
          CFYTJ := FieldByName('CFYTJ').AsString;
          CZHXMBM := '';
          CZHXMMC := '';
          CZXKSBM := FIZXKS;
          CZXKSMC := FCZXKS;
          CKDKSBM := IntToStr(AZYBR.IZYKS);
          CKDKSMC := AZYBR.CZYKS;
          CYJZD := '';
          Mje := MDJ * ISL;
          FBL := 1;
          MSJ := Mje * FBL;
          DRQ := Rdata;
          CBZ := '';
          CSFR := FCZYMC;
          ITXBJ := 0;
          CTXR := '';
          IYBBJ := 0;
          CSSBH := '';
          CSFRGH := FCZYGH;
          BICUFY := False;
          BTF := False;
          CXSE := '';
          DDYSJ := Rdata;
          IGCYS := AZYBR.IZYYS;
          CGCYS := AZYBR.CZYYS;
          CBRCW := AZYBR.CZYCW;
          CTXM := '';   //������ ��֪���Ƿ���Ҫ
          AZYFYMX.AddItem;
        end;
      end;
    except
      on E: Exception do
      begin
        Aerror := '��֯�շ�����ʧ�ܣ����飡' + e.Message;
        Exit;
      end;
    end;
    Result := True;
  end;
  function ADDFJFTF: Boolean;
  begin
    Result := False;
    try
      if FIBRLX = 0 then
      begin
        with AFYMXTF.AItem, TmpQry, AFYMXTF do
        begin
          CSFD := FCSFD;    //�շѵ���
          CJZD := FCSFD;
          CFPH := '';              //��Ʊ��
          DJZRQ := Rdata;
          CMZH := AMZBR.CMZH;
          CYLH := AMZBR.CYLH;
          CXM := AMZBR.CXM;
          CXB := AMZBR.CXB;
          CNL := AMZBR.CNL;
          IKS := AMZBR.IKSBM;
          CKS := AMZBR.CKSMC;
          IYS := AMZBR.IYSBM;
          CYS := AMZBR.CYSMC;
          IBRDW := 0;
          CBRDW := '';
          ISFZL := AMZBR.ISFZL;
          CSFZL := AMZBR.CSFZL;
        //FBL
          IGRYH := 1;
          IXMYH := 1;
          CYSFD := FieldByName('CSFD').AsString + FieldByName('IIXH').AsString;
          CYJZD := FieldByName('CJZD').AsString;
          IIXH := FieldByName('IIXH').AsInteger;
          IXH := FieldByName('IXH').AsInteger;
          CXMBM := FieldByName('CXMBM').AsString;
          CXMMC := FieldByName('CXMMC').AsString;
          CDW := FieldByName('CDW').AsString;
          MDJ := FieldByName('MDJ').AsCurrency;
          ISL := FieldByName('ISL').AsCurrency *  - 1;
        //����
          MYSJE := FieldByName('MYSJE').AsCurrency *  - 1;
          MSSJE := 0;
          MJZJE := FieldByName('MJZJE').AsCurrency *  - 1;
          MSJJZ := FieldByName('MSJJZ').AsCurrency *  - 1;
          CSSBH := '';
          CSFRGH := fczygh;
          CSFR := fczymc;
          CBZ := '';
          CYBH := '';
          IYKT := 1;
          ISFFS := FieldByName('ISFFS').AsInteger;
          CSFFS := FieldByName('CSFFS').AsString;
          CZXKSBM := FieldByName('CZXKSBM').AsString;
          CZXKSMC := FieldByName('CZXKSMC').AsString;
          CPYM := FieldByName('CPYM').AsString;
          BGRTF := False;
          CZHSFXMBM := FieldByName('CZHSFXMBM').AsString;
          CZHSFXMMC := FieldByName('CZHSFXMMC').AsString;
          BTF := True;
          CDJH := FieldByName('CDJH').AsString;
          CCWTJ := FieldByName('CCWTJ').AsString;
          CFYTJ := FieldByName('CFYTJ').AsString;
          DGH := FieldByName('DGH').AsDateTime;
          DYJZRQ := FieldByName('DJZRQ').AsDateTime;
          DYJZRQ := FieldByName('DJZRQ').AsDateTime;
        end;
        AFYMXTF.AddItem;
      end
      else if FIBRLX = 1 then
      begin
        with AZYFYMX, AZYFYMX.AItem, TmpQry do
        begin
          CZYH := AZYBR.CZYH;
          CYLH := AZYBR.CYLH;
          CXM := AZYBR.CXM;
          CXB := AZYBR.CXB;
          CNL := AZYBR.CNL;
          IDYLB := AZYBR.ISFZL;
          CDYLB := AZYBR.CSFZL;
          IZTJZ := AZYBR.IZTJZCS;
          IZYKS := AZYBR.IZYKS;
          CZYKS := AZYBR.CZYKS;
          IZYBQ := AZYBR.IZYBQ;
          CZYBQ := AZYBR.CZYBQ;
          IZYYS := AZYBR.IZYYS;
          CZYYS := AZYBR.CZYYS;

          CSFXM := fieldbyname('CSFXM').ASSTRING;
          CDJH := fieldbyname('CDJH').ASSTRING;
          ISL := -1 * fieldbyname('ISL').AsCurrency;
          MDJ := fieldbyname('MDJ').AsCurrency;
          CDW := fieldbyname('CDW').AsString;
          CSFXMBM := fieldbyname('CSFXMBM').AsString;
          ICWBM := FieldByName('ICWBM').AsString;
          IFYBM := FieldByName('IFYBM').AsString;
          CCWTJ := fieldbyname('CCWTJ').AsString;
          CFYTJ := fieldbyname('CFYTJ').AsString;
          CZHXMBM := fieldbyname('CZHXMBM').asstring;
          CZHXMMC := fieldbyname('CZHXMMC').asstring;
          CKDKSBM := fieldbyname('CKDKSBM').asstring;
          CKDKSMC := fieldbyname('CKDKSMC').asstring;
          CZXKSBM := fieldbyname('CZXKSBM').AsString;
          CZXKSMC := fieldbyname('CZXKSMC').AsString;
          CYJZD := fieldbyname('CJZD').ASSTRING;
          Mje := MDJ * ISL;
          FBL := fieldbyname('FBL').AsFloat;
          MSJ := Mje * FBL;
          DRQ := Rdata;
          CBZ := '';
          CSFR := FCZYMC;
          ITXBJ := 0;
          CTXR := '';
          IYBBJ := 0;
          CSSBH := '';
          CSFRGH := FCZYGH;
          BICUFY := False;
          BTF := Flag = 0;

          CXSE := '';
          DDYSJ := Rdata;
          IGCYS := AZYBR.IZYYS;
          CGCYS := AZYBR.CZYYS;
          CBRCW := AZYBR.CZYCW;
          DYRQ := fieldbyname('DRQ').AsDateTime;
          CTXM := '';   //������ ��֪���Ƿ���Ҫ
          AZYFYMX.AddItem;
        end;
      end;
    except
      on E: Exception do
      begin
        Aerror := '��֯�˷�����ʧ�ܣ����飡' + e.Message;
        Exit;
      end;
    end;
    Result := True;
  end;

begin
  Result := False;
  TmpQry := TFDQuery.Create(nil);
  try
    //�շ�
    if flag = 1 then
    begin
      if FIBRLX = 0 then
      begin
        CYKTZFFS := GetYXXTCSI('YKTZFFS', '');
        if CYKTZFFS = '' then
        begin
          AERROR := 'δ����һ��֧ͨ����ʽ����[YKTZFFS]���޷�����һ��ͨ�շѣ�';
          exit;
        end;
      end;
      for I := 0 to TmpNode.selectNodes('DATA').length - 1 do
      begin
        CSQL := 'SELECT b.*,CCWTJ=CW.CMC,CFYTJ=fy.CMC FROM ' + SDBLX +
          '..TBZDSFXM b WITH(NOLOCK)  LEFT JOIN ' + SDBLX +
          '..TBZDCWTJ cw ON b.ICWBM=cw.IBM LEFT JOIN ' + SDBLX +
          '..TBZDFYTJ fy ON b.IFYBM=fy.IBM  WHERE b.CBM=' + QuotedStr(TmpNode.selectNodes
          ('DATA').item[I].selectSingleNode('DATA.CBM').text);
        if not ExeSql(TmpQry, CSQL, FALSE) then
          Exit;
        if TmpQry.IsEmpty then
        begin
          AERROR := 'δ�ҵ�����շ���Ŀ��Ϣ�����飡CSQL=' + CSQL;
          Exit;
        end;
        NSL := StrToIntDef(TmpNode.selectNodes('DATA').item[I].selectSingleNode
          ('DATA.NSL').text,1);
        NMDJ := StrToCurrdef(TmpNode.selectNodes('DATA').item[I].selectSingleNode
          ('DATA.MDJ').text, 1);
        FMRZXKSBM := VarToStrDef(TmpNode.selectNodes('DATA').item[I].selectSingleNode
          ('DATA.CZXKSBM').text, '');
        FMRZXKSMC := VarToStrDef(TmpNode.selectNodes('DATA').item[I].selectSingleNode
          ('DATA.CZXKSMC').text, '');
        if not GetCZY(FCCZY) then Exit;
        if FIBRLX = 0 then
          FCSFD := GetSysNumber2('CMZJZD', 1, '00');
        if not ADDFJF then
        begin
          AERROR := '׼��������ϸʧ�ܣ�' + aerror;
          Exit;
        end;
      end;
    end
    else if flag = 0 then
    begin
      LstDJH.Text := StringReplace(LstDJH.Text, '|', #13#10, [rfReplaceAll]);
      for I := 0 to LstDJH.Count - 1 do
      begin
        if CTFTJ <> '' then
          CTFTJ := CTFTJ + ',';
        CTFTJ := CTFTJ + QuotedStr(LstDJH[I]);
      end;
      try
        if FIBRLX = 0 then
          TBFYMXS := GetNkTables('TBMZFYMX', AMZBR.DGH, Rdata)
        else if FIBRLX = 1 then
          TBFYMXS := GetNkTables('TBFYMX', AZYBR.DRYSJ, Rdata);
        for I := 0 to TBFYMXS.Count - 1 do
          CSQL := iif(CSQL = '', 'select * from ' + TBFYMXS[I] +
            ' WITH(nolock) WHERE BTF=0 and CJZD in(' + CTFTJ + ')', CSQL +
            #10#13 + ' UNION ' + #10#13 + 'select * from ' + TBFYMXS[I] +
            ' WITH(nolock) WHERE BTF=0 and CJZD in(' + CTFTJ + ')');
        if not ExeSql(TmpQry, CSQL, false) then
          Exit;
        if TmpQry.IsEmpty then
        begin
          AERROR := 'δ��ѯ������˷����ݣ����飡CSQL=' + CSQL;
          Exit;
        end;
        while not TmpQry.Eof do
        begin
          with TmpQry do
          begin
            if FIBRLX = 0 then 
              FCSFD := GetSysNumber2('CMZJZD', 1, '00');
            if not ADDFJFTF then
            begin
              AERROR := '׼��������ϸʧ�ܣ�' + AERROR;
              Exit;
            end;
            Next;
          end;
        end;
      finally
        FreeAndNil(TBFYMXS);
      end;
    end;
    LstDJH.Clear;
    if FIBRLX = 0 then
    begin
      if flag = 1 then
      begin
        for I := 0 to AMZFYMX.Count - 1 do
          LstDJH.Add(AMZFYMX.Items[I].CJZD);
      end
      else if Flag = 0 then
      begin
        for I := 0 to AFYMXTF.Count - 1 do
          LstDJH.Add(AFYMXTF.Items[I].CJZD);
      end;
    end
    else if FIBRLX = 1 then
    begin
      IID := StrToInt64Def(GetSysNumber2('ZYJZDPH', 1, '00'), -1);
      FCSFD := GetSysNumber2('ZYSFD', AZYFYMX.Count, '00');    //��������
      for I := 0 to AZYFYMX.Count - 1 do
      begin
        AZYFYMX.Items[I].CJZD := Addstr(IntToStr(StrToInt64(FCSFD) + I), '0',
          Length(FCSFD));
        AZYFYMX.Items[I].IID := IID;
        LstDJH.Add(AZYFYMX.Items[I].CJZD);
      end;
    end;

  finally
    freeandnil(TmpQry);
  end;
  Result := True;
end;

function TYXSVR.SaveFJF:Boolean;
begin
  Result := False;
  Try
    if FIBRLX = 1 then
    begin
      if not SaveZYFYMX then
      begin
        AERROR := 'סԺ���ݱ���ʧ�ܣ�' + AERROR;
        Exit;
      end;
    end
    else if FIBRLX = 0 then
    begin
      if not SaveMZFYMX(flag) then
      begin
        AERROR := '�������ݱ���ʧ�ܣ�' + AERROR;
        Exit;
      end;
    end;
  Except
    on e:Exception do
    begin
      AERROR := '���ñ���ʧ�ܣ�'+AERROR+','+e.Message;
      Exit;
    end;
  End;
  Result := True;
end;

function TYXSVR.ExeSql(AQuery: TFDQuery; CSQL: wideString): Integer;
begin
  Result := 0;
  if not CheckDataBase then
    Exit;
  if CSQL = '' then
    raise Exception.Create('û��SQL��䣡���飡');
  AQuery.Connection := DATABASE;
  with AQuery do
  begin
    close;
    Sql.clear;
    Sql.Add(CSQL);
    try
      ExecSQL;
      Result := RowsAffected;
    except
      on E: Exception do
      begin
        Result := -1;
        close;
        AERROR := '������Ϣ:' + E.Message + ';SQL=' + CSQL;
        Exit;
      end;
    end;
  end;
end;

function TYXSVR.ExeSql(AQuery: TFDQuery; CSQL: string; ExecFlag: Boolean;
  FunctionName: string): Boolean;
begin
  Result := False;
  if not CheckDataBase then
    Exit;
  if CSQL = '' then
    raise Exception.Create('('+FunctionName+')'+'û��SQL��䣡���飡');
  AQuery.Connection := DATABASE;
  with AQuery do
  begin
    Close;
    Sql.Clear;
    Sql.Add(CSQL);
    try
      if ExecFlag then
        ExecSQL
      else
        Open;
    except
      on E: Exception do
      begin
        Close;
        AERROR := '('+FunctionName+')'+'������Ϣ:' + E.Message + #13#10 + ' SQL:' + CSQL;
        Exit;
      end;
    end;
  end;
  Result := True;
end;

function TYXSVR.GetUserParam(CNBMC: string; DefValue: string): string;
const FunctionName = 'GetUserParam';
var
  CSQL: string;
  QryTabTemp: TFDQuery;
begin
  Result := DefValue;
  try
    QryTabTemp := TFDQuery.Create(nil);
    CSQL := 'select top 1 Cvalue from ' + SDBLX +
      '..TBUSERPARAM with (nolock) WHERE CNBMC=' + QUOTEDSTR(CNBMC);
    if not ExeSql(QryTabTemp, CSQL, FALSE,FunctionName) then
      Exit;
    if not QryTabTemp.isempty then
      Result := QryTabTemp.FieldByName('Cvalue').asstring;
  finally
    FreeAndNil(QryTabTemp);
    if AERROR <> '' then
      raise Exception.Create('��ȡ��������' + AERROR);
  end;
end;

function TYXSVR.GetUserParam(CNBMC: string; DefValue: Integer): Integer;
var
  CSQL: string;
  QryTabTemp: TFDQuery;
begin
  Result := DefValue;
  try
    QryTabTemp := TFDQuery.Create(nil);
    CSQL := 'select top 1 CVALUE from ' + SDBLX +
      '..TBUSERPARAM with (nolock) WHERE CNBMC=' + QUOTEDSTR(CNBMC);
    if not ExeSql(QryTabTemp, CSQL, FALSE) then
      Exit;
    if not QryTabTemp.IsEmpty then
      Result := QryTabTemp.FieldByName('Cvalue').AsInteger;
  finally
    FreeAndNil(QryTabTemp);
    if AERROR <> '' then
      raise Exception.Create('��ȡ��������' + AERROR);
  end;
end;

function TYXSVR.GetYXXTCSI(CCSMC: string; DefValue: string): string;
var
  CSQL: string;
  QryTabTemp: TFDQuery;
begin
  Result := DefValue;
  try
    QryTabTemp := TFDQuery.Create(nil);
    CSQL := 'select top 1 CVALUE from ' + SDBLX +
      '..TBYXXTCSI with (nolock) WHERE CCSMC=' + QUOTEDSTR(CCSMC);
    if not ExeSql(QryTabTemp, CSQL, FALSE) then
      Exit;
    if not QryTabTemp.IsEmpty then
      Result := QryTabTemp.FieldByName('Cvalue').AsString;
  finally
    FreeAndNil(QryTabTemp);
    if AERROR <> '' then
      raise Exception.Create('��ȡ��������' + AERROR);
  end;
end;

function TYXSVR.GetYXXTCSI(CCSMC: string; DefValue: Integer): Integer;
var
  CSQL: string;
  QryTabTemp: TFDQuery;
begin
  Result := DefValue;
  try
    QryTabTemp := TFDQuery.Create(nil);
    CSQL := 'select top 1 CVALUE from ' + SDBLX +
      '..TBYXXTCSI with (nolock) WHERE CCSMC=' + QUOTEDSTR(CCSMC);
    if not ExeSql(QryTabTemp, CSQL, FALSE) then
      Exit;
    if not QryTabTemp.IsEmpty then
      Result := QryTabTemp.FieldByName('Cvalue').AsInteger;
  finally
    FreeAndNil(QryTabTemp);
    if AERROR <> '' then
      raise Exception.Create('��ȡ��������' + AERROR);
  end;
end;

function TYXSVR.GetNkTables(MBTableName: string; BeginDate, endDate: TDateTime): Tstrings;
const
  FunctionName = 'GetNkTables';
var
  BEGINYEAR, ENDYEAR: INTEGER;
  i, j: integer;
  DbName: string; //���ݿ�����
  CSQL: string;
  QRYTABLES: TFDQuery;
begin
  Result := TstringList.Create;
  try
    BEGINYEAR := strtoint(formatdatetime('yyyy', BeginDate));
    ENDYEAR := strtoint(formatdatetime('yyyy', endDate));
    QRYTABLES := TFDQuery.Create(nil);
    CSQL := 'select CDATABASE from ' + SDBLX +
      '..tbsystables with (nolock) where cmc=' + Quotedstr(MBTableName);
    if not ExeSql(QRYTABLES, CSQL, False, FunctionName) then
      Exit;
    DbName := '';
    if QRYTABLES.IsEmpty then
    begin
      AERROR := 'δ�ҵ���صı����ã����飡' + CSQL;
      Exit;
    end;
    DbName := QRYTABLES.FieldByName('CDATABASE').AsString;
    for i := BEGINYEAR to ENDYEAR do
    begin
      for j := 1 to 12 do
      begin
        if (inttostr(i) + addstr(inttostr(j), '0', 2) >= formatdatetime('yyyymm',
          BeginDate)) and (inttostr(i) + addstr(inttostr(j), '0', 2) <=
          formatdatetime('yyyymm', endDate)) then
        begin
          result.Add(DbName + inttostr(i) + '..' + MBTableName + inttostr(i) +
            addstr(inttostr(j), '0', 2));
        end;
      end;
    end;
  finally
    FreeAndNil(QRYTABLES);
    if AERROR <> '' then
      raise Exception.Create('��ȡ�����' + AERROR);
  end;

end;

function TYXSVR.GetTBName(MBTableName, Invalue: string; DefType: Integer; InDate:
  TDateTime): string;
const
  FunctionName = 'GetTBName';
var
  DbName: string;
  CSQL: string;
  ITYPE: Integer;
  KeyValue: string;
  YY, MM: string;
  QRYTABLES: TFDQuery;
begin
  try
    Result := '';
    QRYTABLES := TFDQuery.Create(nil);
    QRYTABLES.Connection := DATABASE;
    ITYPE := DefType;
    KeyValue := trim(Invalue);
    if ((KeyValue = '') and (not ITYPE in [0, 11])) then
    begin
      AERROR := 'GetTbName("' + MBTableName + '"): ����ؼ��ֵ�ֵΪ�գ�';
      Exit;
    end;
    if InDate <> 0 then
      KeyValue := FormatDateTime('YYYYMM', InDate)
    else if ((KeyValue <> '') and (ITYPE in [1, 2, 3, 4, 5, 6])) then
      KeyValue := Copy(FormatDateTime(('YYYY'),rdata),1,2)+KeyValue;
    YY := Copy(KeyValue,1,4);
    MM := Copy(KeyValue,5,2);
    CSQL := 'SELECT CDATABASE,ITYPE FROM ' + SDBLX +
      '..TBSYSTABLES WITH(NOLOCK) WHERE CMC=' + Quotedstr(MBTableName);
    if not ExeSql(QRYTABLES, CSQL, FALSE, FunctionName) then
      Exit;
    DbName := '';
    if QRYTABLES.IsEmpty then
    begin
      AERROR := 'δ�ҵ���صı����ã����飡' + CSQL;
      Exit;
    end;
    DbName := QRYTABLES.FieldByName('CDATABASE').AsString;
    if DbName = '' then
      Exit;
    ITYPE := QRYTABLES.FieldByName('ITYPE').asinteger;
    /////�ж����ݿ���Ϣ
    case ITYPE of
      0:
        begin ///��ͨ��
          if not DataBaseCheck(DbName) then
            EXIT;
          if Copy(MBTableName, Length(MBTableName), 1) = '+' then
            MBTableName := Copy(MBTableName, 1, Length(MBTableName) - 1);
          if not TableCheck(DbName + '..' + MBTableName) then
            EXIT;
          if UpperCase(DbName) <> 'YXHIS' then
            RESULT := DbName + '..' + MBTableName
          else
            RESULT := MBTableName;

        end;
      1:
        begin ///���
          if not DataBaseCheck(DbName) then
            EXIT;
          if TableCheck(DbName + '..' + MBTableName + YY) then
          begin
            if UpperCase(DbName) <> 'YXHIS' then
              result := DbName + '..' + MBTableName + YY
            else
              result := MBTableName + YY;

          end;
        end;
      2:
        begin ////�±�
          if not DataBaseCheck(DbName) then
            EXIT;
          if TableCheck(DbName + '..' + MBTableName + YY + MM) then
          begin
            if UpperCase(DbName) <> 'YXHIS' then
              result := DbName + '..' + MBTableName + YY + MM
            else
              result := MBTableName + YY + MM;
          end;

        end;
      3:
        begin ///�ձ�
        end;
      4:
        begin ///����±�
          if not DataBaseCheck(DbName + YY) then
            Exit;
          if TableCheck(DbName + YY + '..' + MBTableName + YY + MM) then
          begin
            result := DbName + YY + '..' + MBTableName + YY
              + MM;
          end;
        end;
      5:
        begin ///������
          if not DataBaseCheck(DbName + YY) then
            Exit;
          if TableCheck(DbName + YY + '..' + MBTableName + YY) then
          begin
            result := DbName + YY + '..' + MBTableName + YY;
          end;
        end;

      6:
        begin ///����ձ�
        end;
      7:
        begin ///������
          if not DataBaseCheck(DbName) then
            Exit;
          if TableCheck(DbName + '..' + MBTableName + '_0' + Copy(KeyValue,
            Length(KeyValue), 1)) then
          begin
            result := DbName + '..' + MBTableName + '_0' + Copy(KeyValue, Length
              (KeyValue), 1);
          end;
        end;
      10:
        begin //������
          if not DataBaseCheck(DbName) then
            Exit;
          if TableCheck(DbName + '..' + MBTableName + KeyValue) then
            result := DbName + '..' + MBTableName + KeyValue
          else if TableCheck(DbName + '..' + MBTableName + 'BQ' + KeyValue) then
            result := DbName + '..' + MBTableName + 'BQ' + KeyValue;

        end;
    end;
  finally
    FreeAndNil(QRYTABLES);
    if Result = '' then
      raise Exception.Create('��ȡ��������' + AERROR);
  end;
end;

function TYXSVR.DataBaseCheck(DbName: string): boolean;
const
  FunctionName = 'DataBaseCheck';
var
  CSQL: string;
  QryTabTemp: TFDQuery;
begin
  result := false;
  try
    QryTabTemp := TFDQuery.Create(nil);
    QryTabTemp.Connection := DATABASE;
    CSQL := 'SELECT DBID NUM FROM MASTER..SYSDATABASES WHERE NAME=''' + DbName + '''';
    if not ExeSql(QryTabTemp, CSQL, false, FunctionName) then
    begin
      AERROR := '��ѯ��ṹ�������飡' + CSQL;
      Exit;
    end;
    result := not QryTabTemp.IsEmpty;
    QryTabTemp.Active := False;
    if not Result then
    begin
      AERROR := 'δ�ҵ���ر�ṹ�����飡' + CSQL;
    end;
  finally
    FreeAndNil(QryTabTemp);
  end;
end;

function TYXSVR.TableCheck(Tablename: string): boolean;
const
  FunctionName = 'TableCheck';
var
  FDataBaseName, FTableName: string;
  Index: integer;
  CSQL: string;
  QryTabTemp: TFDQuery;
begin
  Result := false;
  try
    FDataBaseName := 'dbo.';
    FTableName := '';
    QryTabTemp := TFDQuery.Create(nil);
    QryTabTemp.Connection := DATABASE;
    Index := pos('..', Tablename);
    if Index > 0 then
    begin
      FDataBaseName := Copy(Tablename, 1, Index + 1);
      FTableName := Copy(Tablename, Index + 2, (Length(Tablename) - (Index + 1)))
    end
    else
    begin
      Index := pos('.dbo.', Tablename);
      if Index > 0 then
      begin
        FDataBaseName := Copy(Tablename, 1, Index + 4);
        FTableName := Copy(Tablename, Index + 5, (Length(Tablename) - (Index + 1)))
      end
      else
        FTableName := Tablename;
    end;
    CSQL := 'SELECT ID FROM ' + FDataBaseName +
      'SYSOBJECTS WHERE ID = object_id(''' + FDataBaseName + FTableName + ''') ';
    if not ExeSql(QryTabTemp, CSQL, False, FunctionName) then
      Exit;

    if QryTabTemp.IsEmpty then
    begin
      if (Pos('#', FTableName) > 0) then
      begin
        CSQL :=
          'select ID from tempdb.dbo.sysobjects where id = object_id(''tempdb.dbo.' +
          FTableName + ''') ';
        if not ExeSql(QryTabTemp, CSQL, False, FunctionName) then
          Exit;
        if QryTabTemp.IsEmpty then
        begin
          Result := false;
        end
        else
          Result := true;
      end;
    end
    else
      Result := true;
  finally
    FreeAndNil(QryTabTemp);
  end;
end;

function TYXSVR.GetSysNumber2(CBH: string; Diff: Integer; TJ: string): string;
const
  FunctionName = 'GetSysNumber2';
var
  CSQL: string;
  QryNumber: TFDQuery;
begin
  try
    Result := '-1';
    if Diff < 1 then
    begin
      AERROR := '�����������(С��1)����ñ��ʧ�ܣ�';
      Exit;
    end;
    QryNumber := TFDQuery.Create(nil);
    CSQL := 'DECLARE @Value VARCHAR(200)' + #13#10 + 'SET @Value = ' + QuotedStr
      (CBH) + #13#10 + 'EXEC ' + SDBLX + '.DBO.GetSysNumber2 ' + IntToStr(Diff)
      + ',' + QuotedStr(TJ) + ',@Value OUT' + #13#10 + 'SELECT @Value Value ';
    if not ExeSql(QryNumber, CSQL, False) then
      Exit;
    if QryNumber.IsEmpty then
    begin
      AERROR := 'δ��ѯ����ص���ˮ����Ϣ�����飡' + CSQL;
      exit;
    end;
    Result := QryNumber.FieldByName('Value').AsString;
    if Result = '0' then
      Result := '-1';
  finally
    FreeAndNil(QryNumber);
    if Result = '-1' then
      raise Exception.Create('��ˮ�����ɴ������飡' + CSQL);
  end;
end;

function TYXSVR.iif(Expr: Boolean; vTrue, vFalse: string): string;
begin
  if Expr then
    Result := vTrue
  else
    Result := vFalse;
end;

function TYXSVR.iif(Expr: Boolean; vTrue, vFalse: integer): integer;
begin
  if Expr then
    Result := vTrue
  else
    Result := vFalse;
end;

function TYXSVR.iif(Expr, vTrue, vFalse: Boolean): Boolean;
begin
  if Expr then
    Result := vTrue
  else
    Result := vFalse;
end;

function TYXSVR.iif(Expr: Boolean; vTrue, vFalse: TDateTime): TDateTime;
begin
  if Expr then
    Result := vTrue
  else
    Result := vFalse;
end;

function TYXSVR.Addstr(Ostr: string; Astr: string; Lnum: integer): string;
//�ַ������  ���� Addstr ( '1','0',4);  result = '0001'

var
  i: integer;
begin
  result := Ostr;
  for i := 1 to Lnum - Length(Ostr) do
  begin
    result := Astr + result;
  end;
end;

function TYXSVR.BoolToStr(B: Boolean): string;
begin
  if B then
    Result := '1'
  else
    Result := '0';
end;

function TYXSVR.GetNextEle(inElemList: IXMLDOMNodeList): IXMLDOMElement;
var
  Node: IXMLDOMNode;
begin
  Result := nil;
  Node := inElemList.nextNode;
  while Assigned(Node) do
  begin
    if Node.nodeType = NODE_ELEMENT then
    begin
      Result := Node as IXMLDOMElement;
      Exit;
    end;
    Node := inElemList.nextNode;
  end;
end;

function TYXSVR.GetFirstEle(inElemList: IXMLDOMNodeList): IXMLDOMElement;
begin
  Result := nil;
  inElemList.Reset;
  Result := GetNextEle(inElemList);
end;

function TYXSVR.LoadXMLText(AXML: IXMLDOMDocument2; AText: WideString): Boolean;
const
  FunctionName = 'LoadXMLText';
var
  S, Tmp: string;
begin
  Result := False;
  try
    Tmp := AText;
    if Pos('?>', Tmp) = 0 then
      Tmp := '<?xml version="1.0" encoding="gb2312" standalone="yes"?>' + Tmp
    else
    begin
      S := Copy(Tmp, 1, Pos('?>', Tmp) + 1);
      if S <> '<?xml version="1.0" encoding="gb2312" standalone="yes"?>' then
        Tmp := '<?xml version="1.0" encoding="gb2312" standalone="yes"?>' + Copy(AText,
          Length(S) + 1, Length(AText) - Length(S));
    end;
    if not AXML.LoadXML(Tmp) then
    begin
      with AXML.parseError do
      begin
        AERROR := '�����ļ�����,' + Reason + ' at ' + IntToStr(Line) + ',' + IntToStr(LinePos);
        Exit;
      end;
    end;
  except
    on e:Exception do
    begin
      AERROR := '��ϸ��Ϣ��'+E.Message;
      Exit;
    end;
  end;
  Result := True;
end;

function TYXSVR.GetRdata: TDateTime;
var
  QryTime: TFDQuery;
  CSQL: string;
begin
  Result := Now;
  try
    QryTime := TFDQuery.Create(nil);
    CSQL := 'SELECT GetDate() Rdata ';
    if not ExeSql(QryTime, CSQL, False) then
      Exit;
    Result := QryTime.FieldByName('Rdata').AsDateTime;
  finally
    FreeAndNil(QryTime);
    if AERROR <> '' then
      raise Exception.Create(AERROR);
  end;
end;

procedure TYXSVR.GetMode(CSQDH: string; out BH, CLX: string);
var
  CBH, CJCJY: string;
begin
  CJCJY := 'JY';
  CBH := CSQDH;
  if UpperCase(Copy(CSQDH, 1, 2)) = 'JC' then
  begin
    System.Delete(CSQDH, 1, 2);
    CBH := CSQDH;
    CJCJY := 'JC';
  end
  else if Pos(UpperCase(Copy(CSQDH, 1, 4)), UpperCase((GetUserParam('PACS_FQLX',
    '')))) > 0 then
  begin
    System.Delete(CSQDH, 1, 4);
    CBH := CSQDH;
    CJCJY := 'JC';
  end;
  if UpperCase(Copy(CSQDH, 1, 2)) = 'JY' then
  begin
    System.Delete(CSQDH, 1, 2);
    CBH := CSQDH;
    CJCJY := 'JY';
  end;
  BH := CBH;
  CLX := CJCJY;
end;

procedure TYXSVR.SetTBInfo;
var
  CSQL: string;
  QryTmp: TFDQuery;
begin
  if FAMODE = 'JC' then
  begin
    if FIBRLX = 1 then
    begin
      TBXXWZX := GetTBName('TBZYJCSQDXXWZX', FCBRH);
      TBXXWGD := Stringreplace(TBXXWZX, 'WZX', 'WGD', [rfReplaceAll, rfIgnoreCase]);
      TBMXWZX := Stringreplace(TBXXWZX, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBMXWGD := Stringreplace(TBXXWGD, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBXMWZX := Stringreplace(TBXXWZX, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBXMWGD := Stringreplace(TBXXWGD, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBBGXX := Stringreplace(TBXXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      TBBGMX := Stringreplace(TBMXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      if FBQYLYZ then
        TBYZYJWZX := GetTBName('TBZYYZYJXXWZX', FCBRH);
    end
    else if FIBRLX = 0 then
    begin
      TBXXWZX := GetTBName('TBMZJCSQDXXWZX', FCBRH);
      TBXXWGD := GetTBName('TBMZJCSQDXX', FCBRH, 4);
      TBMXWZX := Stringreplace(TBXXWZX, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBMXWGD := Stringreplace(TBXXWGD, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBXMWZX := Stringreplace(TBXXWZX, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBXMWGD := Stringreplace(TBXXWGD, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBBGXX := Stringreplace(TBXXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      TBBGMX := Stringreplace(TBMXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
    end;
  end
  else if FAMODE = 'JY' then
  begin
    if FIBRLX = 1 then
    begin
      TBXXWZX := GetTBName('TBZYJYSQDXXWZX', FCBRH);
      TBXXWGD := Stringreplace(TBXXWZX, 'WZX', 'WGD', [rfReplaceAll, rfIgnoreCase]);
      TBMXWZX := Stringreplace(TBXXWZX, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBMXWGD := Stringreplace(TBXXWGD, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBXMWZX := Stringreplace(TBXXWZX, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBXMWGD := Stringreplace(TBXXWGD, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBBGXX := Stringreplace(TBXXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      TBBGMX := Stringreplace(TBMXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      TBBGBGMX := Stringreplace(TBMXWGD, 'SQD', 'BGDBG', [rfReplaceAll, rfIgnoreCase]);
      if FBQYLYZ then
        TBYZYJWZX := GetTBName('TBZYYZYJXXWZX', FCBRH);
    end
    else if FIBRLX = 0 then
    begin
      TBXXWZX := GetTBName('TBMZJYSQDXXWZX', FCBRH);
      TBXXWGD := GetTBName('TBMZJYSQDXX', FCBRH, 4);
      TBMXWZX := Stringreplace(TBXXWZX, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBMXWGD := Stringreplace(TBXXWGD, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]);
      TBXMWZX := Stringreplace(TBXXWZX, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBXMWGD := Stringreplace(TBXXWGD, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]);
      TBBGXX := Stringreplace(TBXXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      TBBGMX := Stringreplace(TBMXWGD, 'SQD', 'BGD', [rfReplaceAll, rfIgnoreCase]);
      TBBGBGMX := Stringreplace(TBMXWGD, 'SQD', 'BGDBG', [rfReplaceAll, rfIgnoreCase]);
    end;
  end;
  if (FIBRLX = 1) then
  begin
    QryTmp := TFDQuery.Create(nil);
    try
      CSQL := 'SELECT TOP 1 IZYBQ FROM ' + SDBLX +
        '..VTBZYBR WITH(NOLOCK) WHERE CZYH=' + QuotedStr(FCBRH);
      CSQL := CSQL + #13#10 + 'UNION' + #13#10 + 'SELECT TOP 1 IZYBQ FROM ' +
        SDBLX + '..TBZYBRBLGD WITH(NOLOCK) WHERE CZYH=' + QuotedStr(FCBRH);
      if not ExeSql(QryTmp, CSQL, False) then
        Exit;
      if (QryTmp.IsEmpty) then
      begin
        AERROR := 'δ��ѯ��������Ϣ�����飡' + CSQL;
        Exit;
      end;
      FBQ := QryTmp.FieldByName('IZYBQ').AsString;
      TBYZBYZYLBQ := GetTBName('TBYZBYZYLBQ', FBQ);
    finally
      FreeAndNil(QryTmp);
      if AERROR <> '' then
        raise Exception.Create(AERROR);
    end;
  end;
end;

function TYXSVR.CheckSQD(AQry: TFDQuery): Boolean;
var
  CSQL: string;
  CSSTR, CWSTR: string;
begin
  Result := False;
  CSSTR :=
    'select CBH,CBRH,CBRID,CBRXM,CBRXB,CBRNL,DSJSJ,CJLRBM,CJLRMC,CYZXXM,CBGDBH,' + 'CMBBH,ISFZT,IZXZT,IBGZT,CSQZXDWBM,CSQZXDWMC,XMLNR,BQZ,DQZ from ';
  CWSTR := ' WITH(NOLOCK) WHERE CBH=' + quotedstr(FCBH) + ' and CBRH=' + quotedstr(FCBRH);
  CSQL := CSSTR + TBXXWZX + CWSTR;
  CSQL := CSQL + #13#10 + 'UNION ALL' + #13#10 + CSSTR + TBXXWGD + CWSTR;
  if not ExeSql(AQry, CSQL, False) then
    Exit;
  if AQry.IsEmpty then
  begin
    AERROR := 'δ�ҵ����뵥��Ϣ��' + CSQL;
    Exit;
  end;
  Result := True;
end;

function TYXSVR.ReadCard(CYKT, CDBLX: string): Boolean;
const
  FunctionName = 'ReadCard';
var
  CCZY: string;
begin
  Result := false;
  if CDBLX <> '' then
    SDBLX := SDBLX + CDBLX;
  try
    ReadCardH := '0';
    CCZY := GetUserParam('YJJKReadCardCZY', '');
    if CCZY = '' then
    begin
      AERROR := 'δ���ýӿڶ�������Ա��';
      Exit;
    end;
    if not GetCZY(CCZY) then
      Exit;
    if CheckCardNo(CYKT) <> 1 then
      Exit
    else
      ReadCardH := FCYLH;
  except
    on e: Exception do
    begin
      Aerror := Aerror + ',' + e.Message;
    end;
  end;
  Result := True;
end;

function TYXSVR.MakeSQD(ILX, IBRLX: Integer; const CBRH: string; MRCMBBH,
  MRCZTBM, CKDKSBM, CKDKSMC, CDBLX, CST, CRY: string): Boolean;

  procedure CheckData(Invalue: string);
//���ò����ܷ��´����뵥 --�洢����-DBO.ProCheckSQDMake
//��Σ����˺�
//����ֵ��1���ܣ�0������
  var
    CSQL: string;
    QryCheck: TFDQuery;
    Value: string;
  begin
    try
      Value := '0';
      QryCheck := TFDQuery.Create(nil);
      CSQL := 'DECLARE @Value VARCHAR(10)' + #13#10 + 'EXEC @Value=' + SDBLX +
        '.DBO.ProCheckSQDMake ' + quotedstr(Invalue) + #13#10 + 'SELECT @Value Value ';
      if not ExeSql(QryCheck, CSQL, False) then
        Exit;
      if QryCheck.IsEmpty then
        Exit;
      Value := QryCheck.FieldByName('Value').AsString;
    finally
      FreeAndNil(QryCheck);
      if Value <> '1' then
        raise Exception.Create('�ò��˵�ǰ���и����뵥����ֹ�ظ��´' + CSQL);
    end;
  end;

const
  FunctionName = 'MakeSQD';
var
  CSQL: string;
  CYLH, CBRID, CXM, CXB, CNL, IZYBQ, CZYBQ, IZYKS, CZYKS, IZYYS, CZYYS: string;
  CYZH, CBH, CMBBH, CKZXXM, CYZXXM, CBGDBH, ISQZXDW, CSQZXDW, CCW, DRYSJ, DCSSJ: string;
  TBYZXX, TbSQXX, TbSQXM, TbSQMX, CYZNR, CZXKSMC, IKSFZT: string;
  CDZ, CDH, CSFZH, CSFXMZL: string;
  CZTBM, CINNERID: TStringList;
  CXXSQL, CDATA2: string;
  Mje: Currency;
  i, j, ixh: integer;
  BQZ: Boolean;
  CZXKSBM: string;
  QryCX: TFDQuery;
begin
  Result := False;
  if CDBLX <> '' then
    SDBLX := SDBLX + CDBLX;
  if CBRH = '' then
  begin
    AERROR := '����סԺ��Ϊ�գ����飡';
    exit;
  end;
  if not IBRLX in [0, 1] then
  begin
    AERROR := '�������ʹ������飡';
    exit;
  end;
  if GetUserParam('YJJKMAKESQDXZ', '0') = '1' then
    CheckData(CBRH);
  QryCX := TFDQuery.Create(nil);
  try
    if IBRLX = 0 then
      CSQL :=
        'SELECT A.CYLH,A.CBRID,A.CXM,A.CXB,A.CNL,'''' IZYBQ,'''' CZYBQ,A.IKSBM IZYKS,A.CKSMC CZYKS,A.IYSBM IZYYS' +
        ',A.CYSMC CZYYS,'''' CZYCW,A.DGH DRYSJ,A.DCSNY,A.CDZ,B.CLXDH,A.CSFZH FROM ' +
        GetTbName('TBMZGHMX', CBRH, 4) + ' A ' + 'WITH(nolock) LEFT JOIN ' +
        GetTbName('TBBRJBXX') + ' B WITH(NOLOCK) ON A.CBRID=B.CBRID WHERE CMZH='
        + Quotedstr(CBRH)
    else if IBRLX = 1 then
      CSQL :=
        'SELECT A.CYLH,A.CBRID,A.CXM,A.CXB,A.CNL,A.IZYBQ,A.CZYBQ,A.IZYKS,A.CZYKS,A.IZYYS,A.CZYYS,A.CZYCW,A.DRYSJ' +
        ',A.DCSNY,B.CLGZDW CDZ,B.CDH CLXDH,B.CSFZH FROM ' + SDBLX +
        '..VTBZYBR A WITH(nolock) LEFT JOIN ' + SDBLX +
        '..TBSYXX B WITH(NOLOCK) ON A.CZYH=B.CZYH WHERE A.CZYH=' + Quotedstr(CBRH);
    if not ExeSql(QryCX, CSQL, False) then
      exit;
    if QryCX.IsEmpty then
    begin
      AERROR := 'δ��ѯ��[' + CBRH + ']��صĲ�����Ϣ�����飡' + CSQL;
      exit;
    end;

    with QryCX do
    begin
      CYLH := FieldByName('CYLH').AsString;
      if CYLH = '' then
        CYLH := '0';
      CBRID := FieldByName('CBRID').AsString;
      CXM := FieldByName('CXM').AsString;
      CXB := FieldByName('CXB').AsString;
      CNL := FieldByName('CNL').AsString;
      IZYBQ := FieldByName('IZYBQ').AsString;
      CZYBQ := FieldByName('CZYBQ').AsString;
      IZYKS := FieldByName('IZYKS').AsString;
      CZYKS := FieldByName('CZYKS').AsString;
      IZYYS := FieldByName('IZYYS').AsString;
      CZYYS := FieldByName('CZYYS').AsString;
      CCW := FieldByName('CZYCW').AsString;
      DRYSJ := FieldByName('DRYSJ').AsString;
      DCSSJ := FieldByName('DCSNY').AsString;
      CDZ := FieldByName('CDZ').AsString;
      CSFZH := FieldByName('CSFZH').AsString;
      CDH := FieldByName('CLXDH').AsString;
    end;

    ISQZXDW := IZYKS;
    CSQZXDW := CZYKS;
    if IBRLX = 1 then
    begin
      if GetUserParam('ISQDSQDWBMXZ', '') = '1' then
      begin
        ISQZXDW := IZYBQ;
        CSQZXDW := CZYBQ;
      end;
    end;
    if CKDKSBM <> '' then
    begin
      ISQZXDW := CKDKSBM;
      CSQZXDW := CKDKSMC;
    end;
    CMBBH := MRCMBBH;
    if CMBBH = '' then
      CMBBH := GetUserParam('RYZDXDJYSQDMBBH', '');
    if CMBBH = '' then
    begin
      AERROR := 'ģ����Ϊ�գ�';
      exit;
    end;

    CZTBM := TStringList.Create;
    CZTBM.Delimiter := '|';
    CZTBM.DelimitedText := MRCZTBM;
    if CZTBM.DelimitedText = '' then
      CZTBM.DelimitedText := GetUserParam('RYZDXDJYSQDZTBH', '');
    if CZTBM.DelimitedText = '' then
    begin
      AERROR := '�����Ŀ���Ϊ�գ�';
      exit;
    end;
    BQZ := GetUserParam('ZS_SQDXDQZ', '0') <> '0';
    if IBRLX = 0 then
      BQZ := False;
    CBH := GetSysNumber2('0024', 1, '00');
    CYZH := GetSysNumber2('0110', 1, '00');
    if IBRLX = 0 then //0������1��סԺ
    begin
      if ILX = 0 then      //0����飬1������
        TbSQXX := GetTbName('TBMZJCSQDXXWZX', CBRH)
      else
        TbSQXX := GetTbName('TBMZJYSQDXXWZX', CBRH);
      TBYZXX := GetTbName('TBMZYLYZWZX', CBRH);
      IKSFZT := '3';
      CSFXMZL := ' ISFXMZL<>1 ';
    end
    else
    begin
      if ILX = 0 then
        TbSQXX := GetTbName('TBZYJCSQDXXWZX', CBRH)
      else
        TbSQXX := GetTbName('TBZYJYSQDXXWZX', CBRH);
      TBYZXX := GetTbName('TBZYYZYJXXWZX', CBRH);
      IKSFZT := '2';
      CSFXMZL := ' ISFXMZL<>0 ';
    end;
    TbSQMX := Stringreplace(TbSQXX, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]); //GetTbName('TBMZJCSQDMXWZX',CBRH);
    TbSQXM := Stringreplace(TbSQXX, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]); //GetTbName('TBMZJCSQDXMWZX',CBRH);
    CINNERID := TStringList.Create;
    CSQL := 'SELECT CJSBT,CINNERID,CELEBM,CSFXMMC FROM ' + SDBLX +
      '..TBXMFMBMX with(nolock) WHERE CMBBH=' + quotedstr(CMBBH) +
      ' and (celebm <> ''NUL.0'')';
    if not ExeSql(QryCX, CSQL, False) then
      Exit;
    if QryCX.IsEmpty then
    begin
      AERROR := 'δ�ҵ�TBXMFMBMX���Ӧģ�壺CMBBH:' + CMBBH;
      exit;
    end;
    CXXSQL := '';
    Mje := 0;
    ixh := 0;
    QryCX.First;
    //��ϸ��
    for j := 0 to QryCX.RecordCount - 1 do
    begin
      CDATA2 := '';
      if Pos('����', QryCX.fieldbyname('CJSBT').AsString) > 0 then
        CDATA2 := CXM
      else if (QryCX.fieldbyname('CJSBT').AsString = '�Ա�') then
        CDATA2 := CXB
      else if (QryCX.fieldbyname('CJSBT').AsString = '����') then
        CDATA2 := CNL
      else if iif(IBRLX = 0, (QryCX.fieldbyname('CJSBT').AsString = '�����'), (QryCX.fieldbyname
        ('CJSBT').AsString = 'סԺ��')) then
        CDATA2 := CBRH
      else if (IBRLX = 1) and (Pos('סԺ����', QryCX.fieldbyname('CJSBT').AsString) > 0) then
        CDATA2 := CZYKS
      else if (IBRLX = 1) and (QryCX.fieldbyname('CJSBT').AsString = '��λ') then
        CDATA2 := CCW
      else if Pos('��ǰ����Ա', QryCX.fieldbyname('CJSBT').AsString) > 0 then
        CDATA2 := CZYYS
      else if (QryCX.fieldbyname('CJSBT').AsString = '����ʱ��') then
        CDATA2 := FormatDateTime('YYYY-MM-DD HH:NN:SS', rdata)
      else if iif(IBRLX = 0, QryCX.fieldbyname('CJSBT').AsString = '�Һ�ʱ��', QryCX.fieldbyname
        ('CJSBT').AsString = '��Ժʱ��') then
        CDATA2 := DRYSJ
      else if (QryCX.fieldbyname('CJSBT').AsString = '���뵥���') or ((QryCX.fieldbyname
        ('CJSBT').AsString = '���뵥��')) then
        CDATA2 := CBH
      else if (IBRLX = 1) and (Pos('סԺ����', QryCX.fieldbyname('CJSBT').AsString) > 0) then
        CDATA2 := CZYBQ
      else if (QryCX.fieldbyname('CJSBT').AsString = '����ҽ��') then
        CDATA2 := CZYYS
      else if (QryCX.fieldbyname('CJSBT').AsString = '����ʱ��') then
        CDATA2 := DCSSJ
      else if (Pos('��ַ', QryCX.fieldbyname('CJSBT').AsString) > 0) or (Pos('סַ',
        QryCX.fieldbyname('CJSBT').AsString) > 0) then
        CDATA2 := CDZ
      else if (Pos('���֤', QryCX.fieldbyname('CJSBT').AsString) > 0) then
        CDATA2 := CSFZH
      else if (Pos('����', QryCX.fieldbyname('CJSBT').AsString) > 0) then
        CDATA2 := CZYKS
      else if (Pos('�绰', QryCX.fieldbyname('CJSBT').AsString) > 0) then
        CDATA2 := CDH;
      CXXSQL := CXXSQL + #13#10 + ' INSERT INTO ' + TbSQMX +
        ' (CBH,CINNERID,CXMBM,CDATA1,CDATA2) values(' + quotedstr(CBH) + ',' +
        quotedstr(QryCX.fieldbyname('CINNERID').AsString) + ',' + quotedstr(QryCX.fieldbyname
        ('CELEBM').AsString) + ',' + quotedstr(QryCX.fieldbyname('CSFXMMC').AsString)
        + ',' + Quotedstr(CDATA2) + ')';
      QryCX.Next;
    end;

    //��Ŀ��
    for i := 0 to CZTBM.Count - 1 do
    begin
      CSQL := 'SELECT CSFXMMC,CINNERID,CBGDMBBH,CKZXKSBM FROM ' + SDBLX +
        '..TBXMFMBMX WITH(NOLOCK) WHERE CELEBM=''SQD.26'' AND CMBBH=' +
        QUOTEDSTR(CMBBH) + ' AND CSFXMBM=' + QUOTEDSTR(CZTBM[i]);
      if not ExeSql(QryCX, CSQL, False) then
        Exit;
      if QryCX.IsEmpty then
      begin
        AERROR := 'δ�ҵ�TBXMFMBMX����ģ�塾' + CMBBH + '����Ӧ�ļ����Ŀ��' + CZTBM[i] + '����Ϣ�����飡' + CSQL;
        exit;
      end;
      QryCX.First;
      for j := 0 to QryCX.RecordCount - 1 do
      begin
        CYZNR := CYZNR + ' ' + QryCX.FIELDBYNAME('CSFXMMC').ASSTRING;
        CINNERID.Add(CZTBM[i] + '=' + QryCX.FIELDBYNAME('CINNERID').ASSTRING);
        CKZXXM := CKZXXM + QryCX.FIELDBYNAME('CINNERID').ASSTRING + '=' + QryCX.FIELDBYNAME
          ('CSFXMMC').ASSTRING + '|';
        CYZXXM := CYZXXM + QryCX.FIELDBYNAME('CINNERID').ASSTRING + '=' + QryCX.FIELDBYNAME
          ('CBGDMBBH').ASSTRING + ':0|';
        CBGDBH := CBGDBH + QryCX.FIELDBYNAME('CINNERID').ASSTRING + '=|';
        CZXKSBM := CZXKSBM + QryCX.FIELDBYNAME('CINNERID').ASSTRING + '=' +
          QryCX.FIELDBYNAME('CKZXKSBM').ASSTRING + '|';
        QryCX.Next;
      end;
      CSQL := 'SELECT CSFXMBM,ICOUNT,MDJ,MJE FROM ' + SDBLX +
        '..TBZDZTMX WITH(NOLOCK) WHERE ' + CSFXMZL + ' AND CZTBM=' + QUOTEDSTR(CZTBM[i]);
      if not ExeSql(QryCX, CSQL, False) then
        Exit;
      if QryCX.IsEmpty then
      begin
        AERROR := 'δ�ҵ�TBZDZTMX���м����Ŀ��' + CZTBM[i] + '����Ӧ���շ���Ŀ��Ϣ�����飡' + CSQL;
        exit;
      end;
      QryCX.First;
      for j := 0 to QryCX.RecordCount - 1 do
      begin
        //SXMJG.Add(QRYTEMP.FIELDBYNAME('CSFXMBM').ASSTRING+'='+QRYTEMP.FIELDBYNAME('MDJ').ASSTRING);
        CXXSQL := CXXSQL + #13#10 + ' INSERT INTO ' + TbSQXM +
          ' (CBH,CINNERID,CZTBM,IXH,CSFXMBM,MDJ,NSL,MCOSTS,MZFJ,ISTATUS)' +
          ' values (' + quotedstr(CBH) + ',' + quotedstr(CINNERID.VALUES[CZTBM[i]])
          + ',' + quotedstr(CZTBM[i]) + ',' + quotedstr(IntToStr(ixh + j + 1)) +
          ',' + quotedstr(QryCX.fieldbyname('CSFXMBM').AsString) + ',' +
          quotedstr(QryCX.fieldbyname('MDJ').AsString) + ',' + quotedstr(QryCX.fieldbyname
          ('ICOUNT').AsString) + ',' + quotedstr(QryCX.fieldbyname('MJE').AsString)
          + ',' + quotedstr(QryCX.fieldbyname('MJE').AsString) + ',0)';
        Mje := Mje + QryCX.fieldbyname('MJE').ascurrency;
        QryCX.Next;
      end;
      ixh := ixh + QryCX.RecordCount;
      CXXSQL := CXXSQL + #13#10 + ' UPDATE ' + TbSQMX +
        ' SET CDATA2=1 WHERE CBH=' + quotedstr(CBH) + 'AND CINNERID=' +
        quotedstr(CINNERID.VALUES[CZTBM[i]]) + 'AND CXMBM=''SQD.26''';
    end;

    //��Ϣ��
    CXXSQL := CXXSQL + #13#10 + ' INSERT INTO ' + TbSQXX +
      ' (CBH,CMBBH,CBRH,CBRID,CBRXM,CBRXB,CBRNL,DJLRQ,' + iif(IBRLX = 0, 'CYLH,',
      '') + 'DSJSJ,CJLRBM,CJLRMC,ISTATUS,CSQZXDWBM,CSQZXDWMC,MCOSTS,MCOSTSZF,CKZXXM,CYZXXM,'
      + 'CBGDBH,BQZ,DQZ,IHJZT,IZXZT,ISFZT,IBGZT,IKSFZT,IJZZT,' + CST +
      ') VALUES (' + quotedstr(CBH) + ',' + quotedstr(CMBBH) + ',' + quotedstr(CBRH)
      + ',' + quotedstr(CBRID) + ',' + quotedstr(CXM) + ',' + quotedstr(CXB) +
      ',' + quotedstr(CNL) + ',' + quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS',
      rdata)) + ',' + iif(IBRLX = 0, QuotedStr(CYLH) + ',', '') + quotedstr(DRYSJ)
      + ',' + quotedstr(IZYYS) + ',' + quotedstr(CZYYS) + ',1,' + quotedstr(ISQZXDW)
      + ',' + quotedstr(CSQZXDW) + ',' + quotedstr(CurrToStr(Mje)) + ',' +
      quotedstr(CurrToStr(Mje)) + ',' + quotedstr(CKZXXM) + ',' + quotedstr(CYZXXM)
      + ',' + quotedstr(CBGDBH) + ',' + iif(BQZ, '1', '0') + ',' + iif(BQZ,
      quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', rdata)), quotedstr('')) +
      ',1,0,0,0,' + QUOTEDSTR(IKSFZT) + ',0,' + Quotedstr(CRY) + ')';

    if IBRLX = 1 then
      CXXSQL := CXXSQL + #13#10 + ' Insert into ' + TBYZXX + '(IBQBM,CBQMC,' +
        'CZYH,CRYBH,CYLH,IYZLX,CXM,CXB,CNL,CYZH,DXD,CYZNR,CQRGH,CQRHS,CZXKSBM,' +
        'CZXKSMC,CSQDH,ISFZT,IZXZT,IBGZT,MJE,CSQDWBM,CSQDWMC,CMBBH,CSFXMBM,BCX,CDJH,IJZZT,CLJBH,CZXPH' +
        ',CXDYS,CXDYSBM,CTXR' + ' ) Values ( ' + QuoTedStr(IZYBQ) + ',' +
        QuoTedStr(CZYBQ) + ',' + QuoTedStr(CBRH) + ',' + QuoTedStr('') + ',' +
        QuoTedStr(CYLH) + ',' + IntToStr(2) + ',' + QuoTedStr(CXM) + ',' +
        QuoTedStr(CXB) + ',' + QuoTedStr(CNL) + ',' + QuoTedStr('SQ' + CBH) +
        ',' + QuoTedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', rdata)) + ',' +
        QuoTedStr(CYZNR) + ',' + QuoTedStr(IZYYS) + ',' + QuoTedStr(CZYYS) + ','
        + QuotedStr(CZXKSBM) + ',' + QuoTedStr('�����') + ',' + QuotedStr(CBH) +
        ',' + IntToStr(0) + ',' + IntToStr(0) + ',' + IntToStr(0) + ',' +
        CurrToStr(Mje) + ',' + QuoTedStr(ISQZXDW) + ',' + QuotedStr(CSQZXDW) +
        ',' + QuoTedStr(CMBBH) + ',' + QuoTedStr('') + ',' + BoolToStr(False) +
        ',' + QuotedStr('') + ',' + QuotedStr('') + ',' + QuoTedStr('') + ',' +
        quotedstr('') + ',' + QuoTedStr(CZYYS) + ',' + QuoTedStr(IZYYS) + ',' +
        quotedstr('') + ' )';
    try
      if IBRLX = 1 then
        //ҽ��վ�鿴���鱨�浥������ihasdata13�ֶ�
        CXXSQL := CXXSQL + #13#10 + ' UPDATE ' + GetTbName('TBZYBRINDEX+', '', 0)
          + ' SET ihasdata13=1 WHERE czyh=' + QUOTEDSTR(CBRH);

      if InTransaction(2) then
        Rollback(2);
      StartTransaction(2);
      if not ExeSql(QryCX, CXXSQL, True) then
      begin
        AERROR := '���뵥��Ϣд��ʧ��:' + AERROR;
        Exit;
      end;
      Commit(2);
    except
      on E: Exception do
      begin
        AERROR := 'SQLִ��ʧ��:' + E.Message;
        if InTransaction(2) then
          Rollback(2);
        Exit;
      end;
    end;
  finally
    FreeAndNil(CZTBM);
    FreeAndNil(CINNERID);
    FreeAndNil(QryCX);
  end;
  MAKESQDH := CBH;
  Result := True;
end;

function TYXSVR.DelSQD(ILX, IBRLX: Integer; const CBRH, CSQDH: string; CDBLX:
  string): Boolean;
const
  FunctionName = 'DeleteSQD';
var
  CSQL: string;
  tbsqxx, tbsqmx, tbsqxm, TBYZXX: string;
  QryTemp: TFDQuery;
begin
  Result := False;
  QryTemp := TFDQuery.create(nil);
  try
    if CDBLX <> '' then
      SDBLX := SDBLX + CDBLX;
    if CBRH = '' then
    begin
      AERROR := '���˺�Ϊ�գ����飡';
      exit;
    end;
    if not IBRLX in [0, 1] then
    begin
      AERROR := '�������ʹ������飡';
      exit;
    end;
    if IBRLX = 0 then
      CSQL := 'SELECT  *  FROM ' + GetTbName('TBMZGHMX', CBRH, 4) +
        '  WITH(nolock) WHERE CMZH=' + Quotedstr(CBRH)
    else if IBRLX = 1 then
      CSQL := 'SELECT *  FROM ' + SDBLX + '..VTBZYBR WITH(nolock) WHERE CZYH=' +
        Quotedstr(CBRH);
    if not ExeSql(QryTemp, CSQL, False) then
      exit;
    if QryTemp.IsEmpty then
    begin
      AERROR := 'δ��ѯ��[' + CBRH + ']��صĲ�����Ϣ�����飡' + CSQL;
      exit;
    end;
    if IBRLX = 0 then //0������1��סԺ
    begin
      if ILX = 0 then      //0����飬1������
        tbsqxx := GetTbName('TBMZJCSQDXXWZX', CBRH)
      else
        tbsqxx := GetTbName('TBMZJYSQDXXWZX', CBRH);
    end
    else
    begin
      if ILX = 0 then
        tbsqxx := GetTbName('TBZYJCSQDXXWZX', CBRH)
      else
        tbsqxx := GetTbName('TBZYJYSQDXXWZX', CBRH);
      TBYZXX := GetTbName('TBZYYZYJXXWZX', CBRH);
    end;
    tbsqmx := Stringreplace(tbsqxx, 'XX', 'MX', [rfReplaceAll, rfIgnoreCase]); //GetTbName('TBMZJCSQDMXWZX',CBRH);
    tbsqxm := Stringreplace(tbsqxx, 'XX', 'XM', [rfReplaceAll, rfIgnoreCase]); //GetTbName('TBMZJCSQDXMWZX',CBRH);
    CSQL := 'SELECT * FROM ' + tbsqxx + ' WITH(NOLOCK) WHERE CBH=' + Quotedstr(CSQDH);
    if not ExeSql(QryTemp, CSQL, False) then
      exit;
    if QryTemp.IsEmpty then
    begin
      AERROR := 'δ��ѯ����ص����뵥��Ϣ�����飡' + CSQL;
      exit;
    end;
    if not (QryTemp.FieldByName('ISFZT').AsInteger in [0, 3]) then
    begin
      AERROR := '���뵥���շѣ����������������˷ѣ�';
      exit;
    end;
    CSQL := '';
    CSQL := 'DELETE ' + tbsqxx + ' WHERE CBH=' + Quotedstr(CSQDH);
    CSQL := CSQL + #13#10 + 'DELETE ' + tbsqxm + ' WHERE CBH=' + Quotedstr(CSQDH);
    CSQL := CSQL + #13#10 + 'DELETE ' + tbsqmx + ' WHERE CBH=' + Quotedstr(CSQDH);
    if IBRLX = 1 then
      CSQL := CSQL + #13#10 + 'DELETE ' + TBYZXX + ' WHERE CYZH=' + Quotedstr('SQ'
        + CSQDH);
    if not ExeSql(QryTemp, CSQL, True) then
      exit;
  finally
    FreeAndNil(QryTemp);
  end;
  Result := True;
end;


function TYXSVR.WriteRegInfo(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, CDBLX:
  string): Boolean;
const
  FunctionName = 'WriteRegInfo';
var
  CSQL: string;
  QryTemp: TFDQuery;
begin
  Result := False;
  FCBRH := CBRH;
  FIBRLX := IBRLX;
  GetMode(CSQDH, FCBH, FAmode);
  SetTBInfo;
  try
    if CDBLX <> '' then
      SDBLX := SDBLX + CDBLX;
    QryTemp := TFDQuery.Create(nil);
    if not CheckSQD(QryTemp) then
      exit;
    if ILX = 1 then
    begin
      //�Ӹ��Ǽ�ʱ��ý��Զ��ƻ�������ɾ���������ݣ���Ȼ�����Խ��Խ����ͼԽ��Խ��
      CSQL :=
        ' IF NOT EXISTS(SELECT * FROM SYSCOLUMNS WHERE NAME=''DDJRQ'' AND ID=OBJECT_ID(''TBREGSQDINFO'')) ' +
        ' ALTER TABLE ' + SDBLX + '..TBREGSQDINFO ADD DDJRQ DATETIME ';
      CSQL := CSQL + #10#13 +
        ' IF NOT EXISTS(SELECT * FROM SYSCOLUMNS WHERE NAME=''CZTBM'' AND ID=OBJECT_ID(''TBREGSQDINFO''))' +
        ' ALTER TABLE ' + SDBLX + '..TBREGSQDINFO ADD CZTBM VARCHAR(100) NULL ';
      if not ExeSql(QryTemp, CSQL, True) then
      begin
        AERROR := '���뵥�Ǽ���Ϣ�����ʧ��:' + AERROR;
        Exit;
      end;
      CSQL := 'DELETE FROM ' + SDBLX + '..TBREGSQDINFO WHERE CBRH=' + QuotedStr(CBRH)
        + ' AND CSQDH=' + QuotedStr(FCBH) + ' AND CZTBM=' + Quotedstr(CZTBM) +
        #13#10 + ' INSERT INTO ' + SDBLX +
        '..TBREGSQDINFO(CBRH,CSQDH,DDJRQ,CZTBM) ' + ' VALUES(' + QuotedStr(CBRH)
        + ',' + QuotedStr(FCBH) + ',' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS',
        rdata)) + ',' + QUOTEDSTR(CZTBM) + ')';
    end
    else
    begin
      CSQL := 'DELETE FROM ' + SDBLX + '..TBREGSQDINFO WHERE CBRH=' + QuotedStr(CBRH)
        + ' AND CSQDH=' + QuotedStr(FCBH) + ' AND CZTBM=' + Quotedstr(CZTBM);
    end;
    try
      if InTransaction(2) then
        Rollback(2);
      StartTransaction(2);
      if not ExeSql(QryTemp, CSQL, True) then
      begin
        AERROR := '���뵥�Ǽ���Ϣ����ʧ��:' + AERROR;
        Exit;
      end;
      Commit(2);
    except
      on E: Exception do
      begin
        AERROR := 'SQLִ��ʧ��:' + E.Message;
        if InTransaction(2) then
          Rollback(2);
        Exit;
      end;
    end;
  finally
    FreeAndNil(QryTemp);
  end;
  Result := True;
end;

function TYXSVR.DoCharge(ILX, IBRLX: Integer; CZY, CBRH, CSQDH, CMRZXKSBM, CDBLX:
  string): Boolean;
const
  FunctionName = 'DoCharge';
var
  CSQL, CSQLXM, CBH: string;
  I, j, k: integer;
  FISFZT, FIZXZT, IYZSFZT: Integer;
  CSQDLIST, CINNERIDLIST, CYZXXMLIST, CBGDBHLIST: TStringList;
  BNeedTally: Boolean;
  CBRID, CZTBM, TBYZYJWZX: string;
  SCMODE, SCSQD: string;
  QRYTEMP: TFDQuery;
  CKDKSBM, CKDKSMC: string;
  BQZ: Boolean;
  IFYCount: Integer;
  CYLK: string;
begin
  Result := false;
  if CDBLX <> '' then
    SDBLX := SDBLX + CDBLX;
  QRYTEMP := TFDQuery.Create(nil);
  try
    CSQDLIST := TStringList.Create;
    CSQDLIST.Delimiter := '|';
    CSQDLIST.DelimitedText := CSQDH;
    Flag := ILX;
    FIBRLX := IBRLX;
    FCYLH := '';
    CYLK := '';
    if Pos('|', CBRH) > 0 then
    begin
      FCBRH := Copy(CBRH, 1, Pos('|', CBRH) - 1);
      CYLK := Copy(CBRH, Pos('|', CBRH) + 1, Length(CBRH));
    end
    else
      FCBRH := CBRH;
    FBQYLYZ := GetUserParam('IYJKSZXBQYLYZ', '0') = '1';
    SetTBInfo;
    FMRZXKSBM := CMRZXKSBM;
    FBTFCSDCSF := False;
    if not GetCZY(CZY) then
      Exit;
    if not InitClass(ILX, IBRLX) then
      Exit;
    FSQDZXKSCLFS := GetUserParam('SQDZXKSCLFS', '0');
    FBFJF := GetUserParam('YJJKSQDCCSQFJF', '0') = '1';
    FBSFZX := GetUserParam('YJJKSQDSFZX', '0') = '1';
    FBZTDCSF := GetYXXTCSI('IZTDCSF', 0) = 1;
    FBYKTJZ := GetYXXTCSI('IYKT_QF', 0) = 1;
    if IBRLX = 1 then
    begin
      if AZYBR.BDD then
      begin
        AERROR := '�����Ѿ���Ժ����������ˣ�';
        exit;
      end;
      if not CheckLock(1) then
        Exit;  //��ⲡ����
      if not Lock(1) then
        Exit;  //��Ӳ�����
    end
    else if (IBRLX = 0) then
    begin
      if CYLK = ''  then
      begin
        AERROR := 'δ���뿨�ţ����飡' ;
        Exit;
      end;
      if CheckCardNo(CYLK) <> 1 then
      begin
        AERROR := '��������' + AERROR;
        Exit;
      end;
      CSQL := 'SELECT CBRID FROM ' + SDBLX +
        '..TBICXX WITH(NOLOCK) WHERE CICID=' + quotedstr(FCYLH);
      if not ExeSql(QRYTEMP, CSQL, False, FunctionName) then
        Exit;
      if QRYTEMP.IsEmpty then
      begin
        AERROR := 'TBICXX��δ�ҵ���Ӧ����[' + FCYLH + ']�����飡' + CSQL;
        Exit;
      end;
      CBRID := QRYTEMP.fieldbyname('CBRID').AsString;
      if not GetMZHYE then
      begin
        AERROR := '��ȡ��������';
        Exit;
      end;
      if CBRID <> '' then
      begin
        if AMZBR.CBRID <> CBRID then
        begin
          AERROR := '��ҽ�ƿ����ǵ�ǰ�������������飡';
          Exit;
        end;
      end;
    end;

    CYZXXMLIST := TstringList.create;
    CBGDBHLIST := TStringList.create;
    CZTBMLIST := TStringList.Create;
    QTZTLIST := TStringList.Create;
    WTFZTLIST := TStringList.Create;
    if CSQDLIST.Count > 1 then
      CZTBM := '*';
    for j := 0 to CSQDLIST.Count - 1 do
    begin
      try
        CYZXXMLIST.Clear;
        CBGDBHLIST.Clear;
        CZTBMLIST.Clear;
        QTZTLIST.Clear;
        WTFZTLIST.Clear;
        CBH := CSQDLIST[j];
        CZTBM := '';
        if Pos('=', CBH) > 0 then
        begin
          CZTBM := Copy(CBH, Pos('=', CBH) + 1, length(CBH) - Pos('=', CBH));
          CBH := Copy(CBH, 1, Pos('=', CBH) - 1);
          CZTBM := StringReplace(CZTBM, ',', '|', [rfReplaceAll, rfIgnoreCase]);
        end
        else if Pos('=', CBH) <= 0 then
        begin
          AERROR := '�봫����ȷ�����뵥����Σ�';
          Exit;
        end;
        GetMode(CBH, FCBH, FAmode);
        if SCMODE <> '' then
        begin
          if SCMODE <> FAmode then
          begin
            AERROR := '������뵥��������뵥������ͬʱ������';
            Exit;
          end;
        end;
        SCMODE := FAmode;
        if SCSQD <> '' then
        begin
          if Pos(FCBH, SCSQD) > 0 then
          begin
            AERROR := '��������뵥�������Ϸ���ͬһ�����У����뵥ֻ�ܳ���һ�Σ������Ŀ��ϲ�Ϊͬһ���뵥������Ŀ��';
            Exit;
          end;
        end;
        SCSQD := SCSQD + ',' + FCBH;
        if not CheckSQD(QRYTEMP) then
          Exit;
        FISFZT := QRYTEMP.fieldbyname('ISFZT').Asinteger;
        FIZXZT := QRYTEMP.fieldbyname('IZXZT').Asinteger;
        CKDKSBM := QRYTEMP.fieldbyname('CSQZXDWBM').AsString;
        CKDKSMC := QRYTEMP.fieldbyname('CSQZXDWMC').AsString;
        CYZXXMLIST.Delimiter := '|';
        CYZXXMLIST.DelimitedText := QRYTEMP.fieldbyname('CYZXXM').AsString;
        CBGDBHLIST.Delimiter := '|';
        CBGDBHLIST.DelimitedText := QRYTEMP.fieldbyname('CBGDBH').AsString;
        BQZ := True;
        if IBRLX = 1 then
          BQZ := QRYTEMP.fieldbyname('BQZ').AsBoolean;
        BNeedTally := ((ILX = 0) and (FISFZT <> 0) and (FISFZT <> 3)) or ((ILX =
          1) and (FISFZT <> 1));
        BNeedTally := BNeedTally and ((IBRLX = 1) or ((IBRLX = 0) and (FCYLH <> '')));
        if (ILX = 0) and (IBRLX = 1) and (GetYXXTCSI('IYJBGQXZX', '0') = '1') then
        begin
          BNeedTally := False; //ȡ��ִ�в����κ��˷�)
        end;
        if (ILX = 0) and (IBRLX = 0) and (GetYXXTCSI('IYJBGMZQXZX', '0') = '1') then
        begin
          BNeedTally := False; //ȡ��ִ�в����κ��˷�)
        end;
        if CSQDLIST.Count > 1 then
        begin
          if (FISFZT = 1) and (ILX = 1) then
          begin
            //AERROR := '���뵥���շѣ������˴��շѣ�';
            Continue;
          end;
          if (FISFZT = 0) and (ILX = 0) then
          begin
            //AERROR := '���뵥���˷ѣ������˴��˷ѣ�';
            Continue;
          end;
        end;
        if (FISFZT = 1) and (ILX = 1) then
        begin
          AERROR := '���뵥���շѣ���ֹ�ظ��շѣ�';
          Result := True;
          Exit;
        end;
        if (FISFZT = 0) and (ILX = 0) then
        begin
          AERROR := '���뵥���˷ѣ���ֹ�ظ��˷ѣ�';
          Result := True;
          Exit;
        end;
        if (FIZXZT = 3) and (ILX = 1) then
        begin
          AERROR := '���뵥�ѽ��в�ִ�в�������ֹ�շѣ�';
          Exit;
        end;
        if ((FIZXZT = 4) or (FISFZT = 3)) and (ILX = 1) then
        begin
          AERROR := '���뵥ҽ����ȡ������ֹ�շѣ�';
          Exit;
        end;
        if (FIZXZT = 1) and (ILX = 0) and (not FBSFZX) then
        begin
          AERROR := '���뵥��ִ�У��˷Ѳ�����Ч��';
          Exit;
        end;
        if (IBRLX = 0) and (FCYLH = '') and (BNeedTally) then
        begin
          AERROR := 'δ����ҽ�ƿ��ţ���ֹ�շѣ��뵽�շ����շѣ�';
          Exit;
        end;
        if (not BQZ) then
        begin
          AERROR := '���뵥�ѳ�������ֹ���˷ѣ�';
          Exit;
        end;
        if CZTBM = '' then
        begin
          AERROR := 'δ��������Ŀ:' + CZTBM;
          Exit;
        end;
        if CZTBM = '*' then
        begin
          CSQLXM := 'SELECT DISTINCT CZTBM FROM ' + TBXMWZX +
            ' with(nolock) WHERE CBH=' + Quotedstr(FCBH);
          if not ExeSql(QRYTEMP, CSQLXM, False, FunctionName) then
            Exit;
          if QRYTEMP.IsEmpty then
          begin
            AERROR := 'δ�ҵ���ǰ���뵥��Ӧ�����Ŀ:' + CSQLXM;
            Exit;
          end;
          QRYTEMP.First;
          for I := 0 to QRYTEMP.RecordCount - 1 do
          begin
            CZTBMLIST.Add(QRYTEMP.fieldbyname('CZTBM').AsString);
            QRYTEMP.Next;
          end;
          //CSQLXM := 'SELECT DISTINCT CSFXMBM FROM (SELECT * FROM '+TbXMName+' WHERE CBH='+Quotedstr(CBH)+' ) A ';
        end
        else
        begin
          CSQLXM := 'SELECT DISTINCT CZTBM FROM ' + TBXMWZX +
            ' with(nolock) WHERE CBH=' + Quotedstr(FCBH);
          if not ExeSql(QRYTEMP, CSQLXM, False, FunctionName) then
            Exit;
          if QRYTEMP.IsEmpty then
          begin
            AERROR := 'δ�ҵ���ǰ���뵥��Ӧ�����Ŀ:' + CSQLXM;
            Exit;
          end;
          CZTBMLIST.Delimiter := '|';
          CZTBMLIST.DelimitedText := CZTBM;
        end;
        CSQLXM := '';
        CINNERIDLIST := Tstringlist.create;
        for I := 0 to CZTBMLIST.Count - 1 do
        begin
          CSQL := 'SELECT CINNERID FROM ' + TBXMWZX +
            ' with(nolock) WHERE  cbh=' + QUOTEDSTR(FCBH) + ' and CZTBM=' +
            quotedstr(CZTBMLIST[I]);
          if not ExeSql(QRYTEMP, CSQL, False, FunctionName) then
            Exit;
          if QRYTEMP.IsEmpty then
          begin
            AERROR := 'δ�ҵ���ǰ��Ӧ���뵥[' + FCBH + ']��Ӧ�����Ŀ:' + CZTBMLIST[I] + ',SQL=' + CSQL;
            Exit;
          end;
          if CSQLXM = '' then
            CSQLXM := 'SELECT CINNERID FROM ' + TBXMWZX +
              ' with(nolock) WHERE cbh=' + QUOTEDSTR(FCBH) + ' and CZTBM=' +
              quotedstr(CZTBMLIST[I]);
          if CSQLXM <> '' then
            CSQLXM := CSQLXM + #13#10 + ' union ' + #13#10 +
              'SELECT CINNERID FROM ' + TBXMWZX + ' with(nolock) WHERE cbh=' +
              QUOTEDSTR(FCBH) + ' and CZTBM=' + quotedstr(CZTBMLIST[I]);
        end;
        if not ExeSql(QRYTEMP, CSQLXM, False, FunctionName) then
          Exit;
        if QRYTEMP.IsEmpty then
        begin
          AERROR := 'δ�ҵ���ǰ��Ӧ���뵥CINNERID:' + CSQLXM;
          Exit;
        end;
        QRYTEMP.First;
        for I := 0 to QRYTEMP.RecordCount - 1 do
        begin
          CINNERIDLIST.Add(QRYTEMP.fieldbyname('CINNERID').asstring);
          QRYTEMP.Next;
        end;
        if (ILX = 0) then
        begin
          if CINNERIDLIST.Count <> 0 then
          begin
            for I := 0 to CINNERIDLIST.Count - 1 do
            begin
              if CBGDBHLIST.Values[CINNERIDLIST[I]] <> '' then
              begin
                AERROR := '��Ŀ' + CINNERIDLIST[I] + '���б��棡����ȡ�����棡';
                Exit;
              end;
              if not FBSFZX then
              begin
                for k := 0 to CYZXXMLIST.count - 1 do
                begin
                  if Pos(CINNERIDLIST[I], CYZXXMLIST[k]) > 0 then
                  begin
                    if Pos(':1', CYZXXMLIST[k]) > 0 then
                    begin
                      AERROR := '��Ŀ' + CYZXXMLIST[k] + '��ִ�У���ֹ�˷ѣ�';
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        if BNeedTally then
        begin
          if IBRLX = 1 then
          begin
            if not SetZYFYMX(CZTBMLIST) then
            begin
              AERROR := '׼��סԺ��������ʧ�ܣ�' + AERROR;
              Exit;
            end;
          end
          else if IBRLX = 0 then
          begin
            if ILX = 1 then   //�շ�
            begin
              if not SetMZFYMX(CZTBMLIST) then
              begin
                AERROR := '׼�������������ʧ�ܣ�' + AERROR;
                Exit;
              end;
            end
            else if ILX = 0 then    //�˷�
            begin
              if not SetMZFYMXTF(CZTBMLIST) then
              begin
                AERROR := '׼�������˷�����ʧ�ܣ�' + AERROR;
                Exit;
              end;
              if (WTFZTLIST.Count <> 0) and (QTZTLIST.Count <> CZTBMLIST.Count) then
              begin
                if not SetMZFYMX(WTFZTLIST) then
                begin
                  AERROR := '׼������δ������ʧ�ܣ�' + AERROR;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      finally

      end;
    end;
    begin
      if InTransaction(2) then
        Rollback(2);
      StartTransaction(2);
      try
        if IBRLX = 1 then
        begin
          if not SaveZYFYMX then
          begin
            AERROR := 'סԺ���ݱ���ʧ�ܣ�' + AERROR;
            Exit;
          end;
        end
        else if IBRLX = 0 then
        begin
          if not SaveMZFYMX(ILX) then
          begin
            AERROR := '�������ݱ���ʧ�ܣ�' + AERROR;
            Exit;
          end;
          if (ILX = 0) then
          begin
            if AMZFYMX.Count <> 0 then
            begin
              if not GetMZHYE then
              begin
                AERROR := '��ȡ��������' + AERROR;
                Exit;
              end;
              if not SaveMZFYMX(1) then
              begin
                AERROR := '����δ�����ݱ���ʧ�ܣ�' + AERROR;
                Exit;
              end;
            end;
          end;
        end;
        if IBRLX = 0 then
        begin
          if ILX = 0 then
            IFYCount := AFYMXTF.Count
          else
            IFYCount := AMZFYMX.Count;
        end
        else
          IFYCount := AZYFYMX.Count;
        if IFYCount > 0 then
        begin
          CSQL := '';
          for I := 0 to CSQDLIST.Count - 1 do
          begin
            CBH := CSQDLIST[I];
            if Pos('=', CBH) > 0 then
            begin
              CBH := Copy(CBH, 1, Pos('=', CBH) - 1);
              GetMode(CBH, FCBH, FAmode);
            end;
            CSQL := 'SELECT ISTATUS FROM ' + TBXMWZX +
              ' with(nolock) WHERE CBH=' + QUOTEDSTR(FCBH);
            if not ExeSql(QRYTEMP, CSQL, False) then
              Exit;
            if QRYTEMP.IsEmpty then
            begin
              AERROR := 'δ��ѯ�����뵥��ϸ���ݣ����飡' + CSQL;
              Exit;
            end;
            IYZSFZT := 2;
            QRYTEMP.first;
            for j := 0 to QRYTEMP.RecordCount - 1 do
            begin
              if flag = 1 then
              begin
                if (QRYTEMP.FieldByName('ISTATUS').AsString <> '2') then
                begin
                  CSQL := 'UPDATE ' + TBXXWZX + ' SET ISFZT=2 WHERE CBH=' +
                    QUOTEDSTR(FCBH);
                  Break;
                end
                else
                begin
                  IYZSFZT := 1;
                  CSQL := 'UPDATE ' + TBXXWZX + ' SET ISFZT=1 WHERE CBH=' +
                    QUOTEDSTR(FCBH);
                end;
              end
              else if flag = 0 then
              begin
                if (QRYTEMP.FieldByName('ISTATUS').AsString <> '0') then
                begin
                  CSQL := 'UPDATE ' + TBXXWZX + ' SET ISFZT=2 WHERE CBH=' +
                    QUOTEDSTR(FCBH);
                  Break;
                end
                else
                begin
                  IYZSFZT := 0;
                  CSQL := 'UPDATE ' + TBXXWZX + ' SET ISFZT=0 WHERE CBH=' +
                    QUOTEDSTR(FCBH);
                end;
              end;
              QRYTEMP.next;
            end;
            if IBRLX = 1 then
            begin
              if (FBQYLYZ) then
                CSQL := CSQL + #13#10 + 'UPDATE ' + TBYZYJWZX + ' SET ISFZT=' +
                  Inttostr(IYZSFZT) + ' WHERE CYZH=' + Quotedstr('SQ' + FCBH);
              if IYZSFZT = 2 then
                IYZSFZT := 4;
              if TBYZBYZYLBQ <> '' then
                CSQL := CSQL + #13#10 + 'UPDATE ' + TBYZBYZYLBQ + ' SET IFYZT='
                  + Inttostr(IYZSFZT) + ' WHERE CZYH=' + Quotedstr(FCBRH) +
                  ' AND CSQDBH=' + Quotedstr(FCBH);
            end;

            if CSQL <> '' then
              if not ExeSql(QRYTEMP, CSQL, True) then
              begin
                AERROR := '�����շ�״̬ʧ�ܣ�' + AERROR;
                Exit;
              end;
          end;
        end;
        Commit(2);
      except
        if InTransaction(2) then
          Rollback(2);
        Exit;
      end;
    end;
    if (FBSFZX) then
    begin
      if not DoPerform(ILX, IBRLX, CBRH, CSQDH) then
      begin
        AERROR := '����ִ��״̬ʧ�ܣ�' + AERROR;
        Exit;
      end;
    end;
  finally
    UnLock(1);
    DestroyClass;
    FreeAndNil(CSQDLIST);
    FreeAndNil(CZTBMLIST);
    FreeAndNil(QTZTLIST);
    FreeAndNil(WTFZTLIST);
    FreeAndNil(CINNERIDLIST);
    FreeAndNil(CYZXXMLIST);
    FreeAndNil(CBGDBHLIST);
    FreeAndNil(QRYTEMP);
  end;
  Result := True;
end;

function TYXSVR.SetZYFYMX(TmpLIST: TStringlist): Boolean;

  function CheckDCSF(CDCDZTBM, CCSFXMBM: string): Boolean;
  var
    i: Integer;
    Qrytemp: TFDQuery;
    CSQL: string;
  begin
    result := False;
    Qrytemp := TFDQuery.Create(nil);
    try
      CSQL := 'SELECT DISTINCT IDCSF FROM ' + SDBLX +
        '..VTBZDZTMX_Z WHERE CZTBM=' + Quotedstr(CDCDZTBM) + ' AND CSFXMBM=' +
        Quotedstr(CCSFXMBM);
      if not ExeSql(Qrytemp, CSQL, False) then
        Exit;
      if Qrytemp.IsEmpty then
        exit;
      Qrytemp.First;
      for i := 0 to Qrytemp.RecordCount - 1 do
      begin
        if Qrytemp.FieldByName('IDCSF').AsInteger < 1 then
          Exit;
        Qrytemp.Next;
      end;
    finally
      FreeAndNil(Qrytemp);
    end;
    Result := True;
  end;

  function AddFYMX(AQry: TFDQuery; ILB: Integer): Boolean;   //ILB:0�շ���Ŀ��1�����Ϸѣ�2�����ӷ�
  const
    FunctionName = 'AddFYMX';
  var
    i: integer;
    SLBSF, SDCSF: TStringList;
    IGCP: Integer;
    IXH: string;
  begin
    Result := False;
    try
      SLBSF := TStringList.Create;
      SDCSF := TStringList.Create;
      if ILB = 1 then
        SLBSF.Clear;
      if ILB = 0 then
        SDCSF.Clear;
      IGCP := GetIGCP;
      with AQry do
      begin
        First;
        for i := 0 to RecordCount - 1 do
        begin
          if flag = 1 then
          begin
            if ILB = 1 then
            begin
              if SLBSF.indexof(fieldbyname('CBM').ASSTRING + '|' + fieldbyname('ILBSF').ASSTRING)
                <> -1 then
              begin
                Next;
                Continue;
              end;
              SLBSF.Add(fieldbyname('CBM').ASSTRING + '|' + fieldbyname('ILBSF').ASSTRING);
            end;
            if (ILB = 0) and (FBZTDCSF) then
            begin
              if fieldbyname('IDCSF').AsInteger <> 0 then
              begin
                if SDCSF.indexof(fieldbyname('CBM').ASSTRING) <> -1 then
                begin
                  CDCSF := CDCSF + '|' + FCBH + '=' + fieldbyname('CBM').ASSTRING
                    + '^' + fieldbyname('IXH').ASSTRING + '|';
                  Next;
                  Continue;
                end;
                SDCSF.Add(fieldbyname('CSFXMBM').ASSTRING);
              end;
            end;
          end
          else
          begin
            if FieldByName('BTF').AsBoolean then
            begin
              if CDCSF <> '' then
                CDCSF := CDCSF + ',';
              CDCSF := CDCSF + QuotedStr(fieldbyname('CJZD').asstring);
              Next;
              Continue;
            end;
            if (ILB = 0) and (FBZTDCSF) then
            begin
              if CheckDCSF(fieldbyname('CZHXMBM').AsString, fieldbyname('CSFXMBM').AsString)
                then
              begin
                IXH := Copy(fieldbyname('CDJH').ASSTRING, Pos('|', fieldbyname('CDJH').ASSTRING)
                  + 1, length(fieldbyname('CDJH').ASSTRING) - Pos('|',
                  fieldbyname('CDJH').ASSTRING));
                if CDCSF <> '' then
                  CDCSF := CDCSF + ',';
                CDCSF := CDCSF + '|' + FCBH + '=' + fieldbyname('CSFXMBM').AsString
                  + '^' + IXH + '|';
              end;
            end;
          end;
          with AZYFYMX, AZYFYMX.AItem do
          begin
            CZYH := AZYBR.CZYH;
            CYLH := CYLH;
            CXM := AZYBR.CXM;
            CXB := AZYBR.CXB;
            CNL := AZYBR.CNL;
            IDYLB := AZYBR.ISFZL;
            CDYLB := AZYBR.CSFZL;

            IZTJZ := AZYBR.IZTJZCS;
            IZYKS := AZYBR.IZYKS;
            CZYKS := AZYBR.CZYKS;
            IZYBQ := AZYBR.IZYBQ;
            CZYBQ := AZYBR.CZYBQ;
            IZYYS := AZYBR.IZYYS;
            CZYYS := AZYBR.CZYYS;
            if flag = 1 then
            begin
              CDJH := 'SQD' + iif(FAMODE = 'JC', '420', '400') + '=' + Fcbh +
                '|' + fieldbyname('IXH').asstring;
              CSFXM := FieldByName('CMC').AsString;
              ISL := fieldbyname('ISQDSL').AsCurrency;
              if ILB = 0 then
              begin
                MDJ := fieldbyname('MSQDDJ').AsCurrency;
                if fieldbyname('BTJ').ASBOOLEAN then
                  MDJ := fieldbyname('MDJ').AsCurrency;
                if MDJ = 0 then
                  MDJ := fieldbyname('MZTDJ').AsCurrency;
              end
              else if ILB = 1 then
                MDJ := fieldbyname('MDJ').AsCurrency;
              CDW := FieldByName('CDW').AsString;
              CSFXMBM := fieldbyname('CBM').ASSTRING;
              ICWBM := FieldByName('ICWBM').AsString;
              IFYBM := FieldByName('IFYBM').AsString;
            //itype 0���� 1����  IBZ 0סԺ 1 ����
              CCWTJ := FieldByName('CCWTJ').AsString;
              CFYTJ := FieldByName('CFYTJ').AsString;
              CZHXMBM := fieldbyname('CZTBM').asstring;
              CZHXMMC := fieldbyname('CZTMC').asstring;
              CKDKSBM := CKDKSBM;
              CKDKSMC := CKDKSMC;
              if FSQDZXKSCLFS = '0' then
              begin
                CZXKSBM := FIZXKS;
                CZXKSMC := FCZXKS;
              end
              else if FSQDZXKSCLFS = '1' then
              begin
                CZXKSBM := FieldByName('CZXKSBMZT').AsString;
                CZXKSMC := FieldByName('CZXKSMCZT').AsString;
              end;
              CYJZD := '';
            end
            else
            begin
              CSFXM := fieldbyname('CSFXM').ASSTRING;
              CDJH := fieldbyname('CDJH').ASSTRING;
              ISL := -1 * fieldbyname('ISL').AsCurrency;
              MDJ := fieldbyname('MDJ').AsCurrency;
              CDW := fieldbyname('CDW').AsString;
              CSFXMBM := fieldbyname('CSFXMBM').AsString;
              ICWBM := FieldByName('ICWBM').AsString;
              IFYBM := FieldByName('IFYBM').AsString;
              CCWTJ := fieldbyname('CCWTJ').AsString;
              CFYTJ := fieldbyname('CFYTJ').AsString;
              CZHXMBM := fieldbyname('CZHXMBM').asstring;
              CZHXMMC := fieldbyname('CZHXMMC').asstring;
              CKDKSBM := fieldbyname('CKDKSBM').asstring;
              CKDKSMC := fieldbyname('CKDKSMC').asstring;
              CZXKSBM := fieldbyname('CZXKSBM').AsString;
              CZXKSMC := fieldbyname('CZXKSMC').AsString;
              CYJZD := fieldbyname('CJZD').ASSTRING;
            end;
            Mje := MDJ * ISL;
            FBL := fieldbyname('FBL').AsFloat;
            MSJ := Mje * FBL;
            DRQ := Rdata;
            CBZ := '';
            CSFR := FCZYMC;
            ITXBJ := 0;
            CTXR := '';
            IYBBJ := 0;
            CSSBH := '';
            CSFRGH := FCZYGH;
            BICUFY := False;
            BTF := Flag = 0;

            CXSE := '';
            DDYSJ := Rdata;
            IGCYS := AZYBR.IZYYS;
            CGCYS := AZYBR.CZYYS;
            CBRCW := AZYBR.CZYCW;
            if Flag = 0 then
              DYRQ := fieldbyname('DRQ').AsDateTime;
            CTXM := '';   //������ ��֪���Ƿ���Ҫ
            if (IGCP = 1) then
            begin
              MSJ := 0;
              Mje := 0;
              CBZ := 'GCP';
            end;
            AZYFYMX.AddItem;
            if flag = 0 then
              DYJZRQ := fieldbyname('DRQ').AsDateTime;
            if (ILB = 1) and (flag = 1) then
              CGLSQL := CGLSQL + #13#10'insert into ' + TBXMWZX +
                '(CBH,CINNERID,CZTBM,IXH,CSFXMBM,MDJ,NSL,MCOSTS,MZFJ,CDJH,ISTATUS)' +
                ' values(' + quotedstr(FCBH) + ',' + quotedstr(fieldbyname('CINNERID').asstring)
                + ',' + quotedstr(CZHXMBM) + ',' + Quotedstr(fieldbyname('IXH').asstring)
                + ',' + quotedstr(CSFXMBM) + ',' + floattostr(MDJ) + ',' +
                floattostr(ISL) + ',' + floattostr(MSJ) + ',' + floattostr(MSJ)
                + ',' + quotedstr('') + ',0)';
          end;
          Next;
        end;
      end;
    finally
      if SDCSF <> nil then
        FreeAndNil(SDCSF);
      if SLBSF <> nil then
        FreeAndNil(SLBSF);
    end;
    Result := True;
  end;

const
  FunctionName = 'SetZYFYMX';
var
  IID: Integer;
  CJZD, CDJH: string;
  I: Integer;
  CSFXMBM, CZTBM, CTFTJ: string;
  CSQL, CSQLXM: string;
    //FJFLIST:TStringList;
  TBFYMXS: TStrings;
  QryTemp: TFDQuery;
begin
  Result := False;

  IID := StrToInt64Def(GetSysNumber2('ZYJZDPH', 1, '00'), -1);
  QryTemp := TFDQuery.Create(nil);
  TBFYMXS := nil;
  try
    if flag = 1 then
    begin
      for I := 0 to TmpLIST.Count - 1 do
      begin
        CSQL := 'SELECT CDJH,ISTATUS FROM ' + TBXMWZX +
          ' WITH(NOLOCK) WHERE cbh=' + QuotedStr(FCBH) + ' AND CZTBM=' +
          QUOTEDSTR(TmpLIST[I]);
        if not ExeSql(QryTemp, CSQL, False, FunctionName) then
          Exit;
        if QryTemp.IsEmpty then
        begin
          AERROR := '��Ч���շѼ����Ŀ[' + TmpLIST[I] + ']��' + CSQL;
          Exit;
        end;
        if (QryTemp.FieldByName('CDJH').AsString <> '') and (QryTemp.FieldByName
          ('ISTATUS').AsString = '2') then
        begin
          //('�����Ŀ['+TmpLIST[I]+']���չ��ѣ������˴��շѣ�');
          Continue;
        end;
        if CSQLXM = '' then
        begin
          CSQLXM := 'SELECT CSFXMBM FROM TBZDZTMX WITH(NOLOCK) WHERE CZTBM=' +
            QUOTEDSTR(TmpLIST[I]);
          CZTBM := quotedstr(TmpLIST[I]);
        end
        else if CSQLXM <> '' then
        begin
          CSQLXM := CSQLXM + #13#10 + ' union ' + #13#10 +
            'SELECT CSFXMBM FROM TBZDZTMX WITH(NOLOCK) WHERE CZTBM=' + QUOTEDSTR
            (TmpLIST[I]);
          CZTBM := CZTBM + ',' + quotedstr(TmpLIST[I]);
        end;
      end;
      if CZTBM = '' then
      begin
        AERROR := '��ǰ����Ҫ�շ���Ŀ��';
        result := True;
        Exit;
      end;
      CDCSFZT := CZTBM;
      if not ExeSql(QryTemp, CSQLXM, False, FunctionName) then
        Exit;
      if QryTemp.IsEmpty then
      begin
        AERROR := 'δ�ҵ���ǰ��Ӧ�����Ŀ��ϸ:' + CSQLXM;
        Exit;
      end;
      QryTemp.First;
      for I := 0 to QryTemp.RecordCount - 1 do
      begin
        CSFXMBM := CSFXMBM + iif(CSFXMBM = '', '', ',') + QuotedStr(QryTemp.fieldbyname
          ('CSFXMBM').asstring);
        QryTemp.Next;
      end;
      CSQL := 'select fbl' + IntToStr(AZYBR.ISFZL) +
        ' FBL,b.*,c.CZTBM,C.IXH, c.csfxmbm,convert(varchar(200),'''')  CXMMC,C.CINNERID,C.NSL ISL,B.CBMWP' +
        ',(select TOP 1 CMC from ' + SDBLX +
        '..VTBZDZTHZ_Z with(nolock) where CBM=c.cztbm and CSFXMBM=c.csfxmbm) CZTMC' +
        ',(select TOP 1 CZXKSBM from ' + SDBLX +
        '..TBZDZTHZ with(nolock) where CBM=c.cztbm and CSFXMBM=c.csfxmbm) CZXKSBMZT' +
        ',(select TOP 1 CZXKSMC from ' + SDBLX +
        '..TBZDZTHZ with(nolock) where CBM=c.cztbm and CSFXMBM=c.csfxmbm) CZXKSMCZT' +
        IIF(FBZTDCSF, ',(select TOP 1 IDCSF from ' + SDBLX +
        '..VTBZDZTMX_Z with(nolock) where CZTBM=c.cztbm and CSFXMBM=c.csfxmbm) IDCSF',
        '') + ',(select TOP 1 BTJ from ' + SDBLX +
        '..VTBZDZTMX_Z with(nolock) where CZTBM=c.cztbm and CSFXMBM=c.csfxmbm) BTJ' +
        ',(select TOP 1 MDJ from ' + SDBLX +
        '..VTBZDZTMX_Z with(nolock) where CZTBM=c.cztbm and CSFXMBM=c.csfxmbm) MZTDJ,C.MDJ MSQDDJ,C.NSL ISQDSL' +
        ',CCWTJ=CW.CMC,CFYTJ=fy.CMC  ' + ' from ' + TBXMWZX +
        ' c with(nolock), ' + SDBLX + '..tbzdsfxm b with(nolock) ' +
        ' LEFT JOIN ' + SDBLX + '..TBZDCWTJ cw ON b.ICWBM=cw.IBM LEFT JOIN ' +
        SDBLX + '..TBZDFYTJ fy ON b.IFYBM=fy.IBM  ' + ' where b.CBM in (' +
        CSFXMBM + ')' + ' and C.CZTBM IN (' + CZTBM + ') AND c.cbh=' + QuotedStr
        (FCBH) + ' and c.csfxmbm=b.cbm';

    end    //�˷�׼��
    else if flag = 0 then
    begin
      for I := 0 to TmpLIST.Count - 1 do
      begin
        CZTBM := CZTBM + iif(CZTBM = '', '', ',') + QuotedStr(TmpLIST[I]);
      end;
      CDCSFZT := CZTBM;
      CSQL := 'SELECT CDJH FROM ' + TBXMWZX + ' WITH(NOLOCK) WHERE CZTBM in(' +
        CZTBM + ') AND ISTATUS = 2 AND ISNULL(CDJH,'''') <>'''' AND  CBH=' +
        Quotedstr(FCBH);
      if not ExeSql(QryTemp, CSQL, False, FunctionName) then
        Exit;
      if QryTemp.IsEmpty then
      begin
        AERROR := 'δ�ҵ���Ӧ���뵥���ݣ�' + CSQL;
        exit;
      end;
      QryTemp.First;
      for I := 0 to QryTemp.RecordCount - 1 do
      begin
        if CTFTJ <> '' then
          CTFTJ := CTFTJ + ',';
        CTFTJ := CTFTJ + QuotedStr(QryTemp.fieldbyname('CDJH').asstring);
        QryTemp.Next;
      end;
      IID := StrToInt64Def(GetSysNumber2('ZYJZDPH', 1, '00'), -1);
      CSQL := '';
      TBFYMXS := GetNkTables('TBFYMX', AZYBR.DRYSJ, Rdata);
      for I := 0 to TBFYMXS.Count - 1 do
        CSQL := iif(CSQL = '', 'select a.*,b.IFYBM,b.ICWBM from ' + TBFYMXS[I] +
          ' a WITH(nolock)' + ',' + SDBLX +
          '..TBZDSFXM B WITH(nolock) WHERE CJZD in(' + CTFTJ +
          ') AND A.CSFXMBM=B.CBM', CSQL + #10#13 + ' UNION ' + #10#13 +
          'select a.*,b.IFYBM,b.ICWBM from ' + TBFYMXS[I] + ' a WITH(nolock),' +
          SDBLX + '..TBZDSFXM B WITH(nolock) WHERE CJZD in(' + CTFTJ +
          ') AND A.CSFXMBM=B.CBM');
    end;
    if not ExeSql(QryTemp, CSQL, False, FunctionName) then
      Exit;
    if QryTemp.IsEmpty then
    begin
      AERROR := 'δ�ҵ���Ӧ���շ����ݣ�CSQL=' + CSQL;
      exit;
    end;
    if FCZYMC = '' then
    begin
      AERROR := '��ȡ�շѲ���ԱΪ�գ�';
      Exit;
    end;
    if not AddFYMX(QryTemp, 0) then
    begin
      AERROR := '��֯������ϸʧ�ܣ�' + AERROR;
      exit;
    end;
    //���Ϸ�
    if flag = 1 then
    begin
      CSQL :=
        'select distinct 1 fbl, gl.CSFXMMC CMC,gl.CSFXMBM CBM,gl.ILBSF,gl.MDJ,GL.NSL ISQDSL' +
        ',GL.IXH+1000 IXH,GL.CZTBM,C.CZXKSBM CZXKSBMZT,C.CZXKSMC CZXKSMCZT ,C.CMC CZTMC,XM.CINNERID ' +
        ',E.CMC CFYTJ,F.CMC CCWTJ ' + ' from ' + TBXMWZX + ' xm with(nolock),' +
        SDBLX + '..Tbzdzhxmglclfmx gl with(nolock)' + ' ,' + SDBLX +
        '..TBZDZTHZ C WITH(NOLOCK),' + SDBLX + '..TBZDSFXM D WITH(NOLOCK),' +
        SDBLX + '..TBZDFYTJ E WITH(NOLOCK),' + SDBLX +
        '..TBZDCWTJ F WITH(NOLOCK) ' + ' where  E.IBM=D.IFYBM AND F.IBM=D.ICWBM and D.CBM=GL.CSFXMBM  and C.CBM=GL.CZTBM AND '
        + ' xm.CZTBM=gl.CZTBM and  xm.CZTBM IN (' + CZTBM + ') and xm.CBH=' +
        QuotedStr(FCBH);
      if not ExeSql(QryTemp, CSQL, False, FunctionName) then
        Exit;
      if not QryTemp.IsEmpty then
      begin
        if not AddFYMX(QryTemp, 1) then
        begin
          AERROR := '����������֯������ϸʧ�ܣ�' + AERROR;
          exit;
        end;
      end;
      //���ӷ�
      //����ֵ���շѱ���1,����@ִ�п��ұ���@ִ�п�������|�շѱ���2,����@ִ�п��ұ���@ִ�п�������
      {if FBFJF then
      begin
        CSQL := ' DECLARE	@return_value int,@RetMessage varchar(2000)'
              + #13#10 + ' EXEC @return_value = [dbo].[usp_GetTubeCount] '
              + #13#10 + ' @ChargeItemList=N' + QuotedStr('ZY|'+cbh) + ', '
              + #13#10 + ' @RetMessage= @RetMessage OUTPUT '
              + #13#10 + ' SELECT @RetMessage AS N''@RetMessage'' ';
        if not ExeSql(QRYTEMP1 ,CSQL, False,FunctionName) then  Exit;
        if not QRYTEMP1.IsEmpty then
        begin
          try
            FJFLIST := TStringList.Create;
            FJFLIST.Delimiter := '|';
            FJFLIST.DelimitedText := QRYTEMP1.fieldbyname('@RetMessage').asstring;
            for i := 0 to FJFLIST.Count-1 do
            begin
              with AFYMX.AItem do
              begin
                ASFXM.ResetValue;
                ASFXM.CBM :=GetFJFHCJX(FJFLIST[i],1);
                ASFXM.CBM'].IsCondition :=TRUE;
                ASFXM.BENABLE :=TRUE;
                ASFXM.BENABLE'].IsCondition :=TRUE;
                if not ASFXM.ReadEmpty() then exit;
                if ASFXM.EmptyData then
                begin
                  AERROR :='δ�ҵ����շ���Ŀ��' + FJFLIST[I] + '��';
                  WriteYXLog(AERROR,FunctionName);
                  exit;
                end;
                CZYH :=AZYBR.CZYH;
                CYLH :=AZYBR.CYLH;
                CXM :=AZYBR.CXM;
                CXB :=AZYBR.CXB;
                CNL :=AZYBR.CNL;
                IDYLB :=AZYBR.ISFZL;
                CDYLB :=AZYBR.CSFZL;
                CSFXM :=ASFXM.CMC;
                IZTJZ :=AZYBR.IZTJZCS;
                IZYKS :=AZYBR.IZYKS;
                CZYKS :=AZYBR.CZYKS;
                IZYBQ :=AZYBR.IZYBQ;
                CZYBQ :=AZYBR.CZYBQ;
                IZYYS :=AZYBR.IZYYS;
                CZYYS :=AZYBR.CZYYS;
                MJE :=ASFXM.MDJ * strtocurr(GetFJFHCJX(FJFLIST[i],2));
                MSJ :=ASFXM.MDJ * strtocurr(GetFJFHCJX(FJFLIST[i],2));
                CDJH :='';
                DRQ :=rdata;
                CBZ :='';
                CDW :=ASFXM.CDW;
                ISL :=strtocurr(GetFJFHCJX(FJFLIST[i],2));
                MDJ :=ASFXM.MDJ;
                CSFXMBM :=GetFJFHCJX(FJFLIST[i],1);
                CSFR :=CZYMC;
                FBL :=1;
                ITXBJ :=0;
                CTXR:='';
                IYBBJ:=0;
                CZXKSBM :=GetFJFHCJX(FJFLIST[i],3);
                CSSBH :='';
                CSFRGH :=CZYGH;
                BICUFY:=False;
                ICWBM :=ASFXM.ICWBM;
                IFYBM :=ASFXM.IFYBM;
                //itype 0���� 1����  IBZ 0סԺ 1 ����
                CCWTJ :=GetTJMC(ASFXM.ICWBM,0,0);
                CFYTJ :=GetTJMC(ASFXM.IFYBM,1,0);
                BTF:=false;
                CZXKSMC :=GetFJFHCJX(FJFLIST[i],4);
                CZHXMBM := '';
                CZHXMMC :='';
                CKDKSBM :=CKDKSBM;
                CKDKSMC :=CKDKSMC;
                CXSE :='';
                DDYSJ :=rdata;
                IGCYS :=AZYBR.IZYYS;
                CGCYS :=AZYBR.CZYYS;
                CBRCW :=AZYBR.CZYCW;
                CTXM:='';   //������ ��֪���Ƿ���Ҫ
                AFYMX.AddItem;
              end;
            end;
          finally
            FreeAndNil(FJFLIST);
          end;
        end;
      end; }
    end;
    CJZD := GetSysNumber2('ZYSFD', AZYFYMX.Count, '00');    //��������
    CSQL := '';
    //�����ñ����˵�
    for I := 0 to AZYFYMX.Count - 1 do
    begin
      AZYFYMX.Items[I].CJZD := Addstr(IntToStr(StrToInt64(CJZD) + I), '0', Length(CJZD));
      AZYFYMX.Items[I].IID := IID;
      //�����շ�ʱ������������ϸ�еļ����Ŀ
      if (FBZTDCSF) and (flag = 0) then
      begin
        CSQL := 'SELECT TOP 1 A.*,B.CMC FROM ' + TBXMWZX + ' A,' + SDBLX +
          '..VTBZDZTHZ_Z B WHERE A.CZTBM=B.CBM AND CZTBM IN (' + CDCSFZT +
          ') AND CDJH=' + Quotedstr(AZYFYMX.Items[I].CYJZD) + ' AND CBH=' +
          Quotedstr(FCBH);
        if not ExeSql(QryTemp, CSQL, False) then
          Exit;
        if not QryTemp.IsEmpty then
        begin
          AZYFYMX.Items[I].CZHXMBM := QryTemp.fieldbyname('CZTBM').asstring;
          AZYFYMX.Items[I].CZHXMMC := QryTemp.fieldbyname('CMC').asstring;
          CDJH := Copy(AZYFYMX.Items[I].CDJH, 1, Pos('|', AZYFYMX.Items[I].CDJH) - 1);
          AZYFYMX.Items[I].CDJH := CDJH + '|' + QryTemp.fieldbyname('IXH').asstring;
        end;
      end;
    end;
  finally
    FreeAndNil(QryTemp);
    if Assigned(TBFYMXS) then
      FreeAndNil(TBFYMXS);
  end;
  Result := True;
end;

function TYXSVR.SaveZYFYMX: Boolean;
const
  FunctionName = 'SaveZYFYMX';
var
  TBFYMX: string;  //�޸�ԭ����
  ACSQL, ABQSQL, CSQL, CUPSQL, CXMSQL: string;
  I, j: Integer;
  CSQDH: string;
  IXH: string;
  TBFYMXS: TStrings;
  QRYTEMP: TFDQuery;
begin
  Result := false;
  if AZYFYMX.Count = 0 then
  begin
    AERROR := '����Ҫ�շ���ϸ�����飡';
    Result := True;
    Exit;
  end;
  TBFYMXS := nil;
  QRYTEMP := TFDQuery.Create(nil);
  try
    if CGLSQL <> '' then
    begin
      if not ExeSql(QRYTEMP, CGLSQL, True) then
      begin
        AERROR := '������Ϸ���ϸ����' + AERROR + CGLSQL;
        Exit;
      end;
    end;
    ACSQL := '';
    if flag = 0 then
      TBFYMXS := GetNkTables('TBFYMX', AZYBR.DRYSJ, Rdata);
    TBFYMX := GetTBName('TBFYMX', FormatDateTime('YYMMDD', rdata), 4);

    for I := 0 to AZYFYMX.Count - 1 do
    begin
      with AZYFYMX.Items[I], AZYFYMX do
      begin
        if CZHXMBM <> '' then
        begin
          CSQDH := Copy(CDJH, Pos('=', CDJH) + 1, Length(CDJH));
          CSQDH := Copy(CSQDH, 1, Pos('|', CSQDH) - 1);
          IXH := Copy(CDJH, Pos('|', CDJH) + 1, length(CDJH) - Pos('|', CDJH));
          if flag = 1 then
          begin
            CSQL := 'UPDATE ' + TBXMWZX + ' SET ISTATUS=2,CDJH=' + QUOTEDSTR(CJZD)
              + ' WHERE IXH=' + IXH + ' AND  ISTATUS<>2 AND CSFXMBM=' +
              QUOTEDSTR(CSFXMBM) + ' AND CBH=' + QUOTEDSTR(CSQDH) +
              ' AND CZTBM=' + QUOTEDSTR(CZHXMBM);
            //�����շѣ�������ͬ����ĿΪͬһ�����ݺţ���ʱ������IXH��Ϊwehre����
            if (FBZTDCSF) and (CDCSF <> '') and (Pos('|' + CSQDH + '=' + CSFXMBM
              + '^', CDCSF) > 0) and (Pos('|' + CSQDH + '=' + CSFXMBM + '^' +
              IXH + '|', CDCSF) < 1) then
            begin
              CSQL := 'UPDATE ' + TBXMWZX + ' SET ISTATUS=2,CDJH=' + QUOTEDSTR(CJZD)
                + ' WHERE ISTATUS<>2 AND CSFXMBM=' + QUOTEDSTR(CSFXMBM) +
                ' AND CBH=' + QUOTEDSTR(CSQDH) + ' AND CZTBM in (' + CDCSFZT + ')';
            end;
          end
          else if flag = 0 then
          begin
            CSQL := 'UPDATE ' + TBXMWZX + ' SET ISTATUS=0,CDJH='''' WHERE IXH='
              + IXH + ' AND ISTATUS=2 AND CSFXMBM=' + QUOTEDSTR(CSFXMBM) +
              ' AND CBH=' + QUOTEDSTR(CSQDH) + ' AND CZTBM=' + QUOTEDSTR(CZHXMBM);
              //�����շѣ�������ͬ����ĿΪͬһ�����ݺţ���ʱ������IXH��Ϊwehre����
            if (FBZTDCSF) and (CDCSF <> '') and (Pos('|' + CSQDH + '=' + CSFXMBM
              + '^', CDCSF) > 0) then
            begin
              CSQL := 'UPDATE ' + TBXMWZX +
                ' SET ISTATUS=0,CDJH='''' WHERE ISTATUS=2 AND CSFXMBM=' +
                QUOTEDSTR(CSFXMBM) + ' AND CBH=' + QUOTEDSTR(CSQDH) +
                ' AND CZTBM in (' + CDCSFZT + ')';
            end;
          end;
          if ExeSql(QRYTEMP, CSQL) < 1 then
          begin
            if flag = 1 then
              AERROR := '���뵥���շѣ���ֹ�ظ��շѣ�' + CSQL
            else if flag = 0 then
              AERROR := '���뵥���˷ѣ���ֹ�ظ��˷ѣ�' + CSQL;
            Exit;
          end;
        end;
        ACSQL := ACSQL + #13#10 + ' INSERT INTO ' + TBFYMX +
          ' (IID,CJZD,CZYH,CYLH,CXM,CXB,CNL,IDYLB,CDYLB,CSFXM,IZTJZ,IZYKS,CZYKS,'+
          '  IZYBQ,CZYBQ,IZYYS,CZYYS,MJE,MSJ,DRQ,CBZ,CDW,ISL,MDJ,CSFXMBM,CSFR,FBL,ITXBJ,' +
          '  CTXR,CQMYS,CJZBJ,CDJH,IYBBJ,CZXKSBM,CSSBH,CSFRGH,BICUFY,CYJZD,CCWTJ,CFYTJ,ILB,'+
          '  BTF,CZXKSMC,CZHXMBM,CZHXMMC,CKDKSBM,CKDKSMC,CXSE,DDYSJ,CZXRBM,' +
          '  CZXRMC,CLJBH,IGCYS,CGCYS,CBRCW,CZRHSBM,CZRHSMC,CBJFYBZ,CTXM,BMZFY';
        if BSH then
          ACSQL := ACSQL + ',BSH';
        if CTFYY <> '' then
          ACSQL := ACSQL + ',CTFYY';
        if CYWFYBZ <> '' then
          ACSQL := ACSQL + ',CYWFYBZ';
        if CSBXX <> '' then
          ACSQL := ACSQL + ',CSBXX';
        if CSYMD <> '' then
          ACSQL := ACSQL + ',CSYMD';
        ACSQL := ACSQL + ')VALUES(' + Inttostr(IID) + ',' + QuotedStr(CJZD) +
          ',' + QuotedStr(CZYH) + ',' + QuotedStr(CYLH) + ',' + QuotedStr(CXM) +
          ',' + QuotedStr(CXB) + ',' + QuotedStr(CNL) + ',' + Inttostr(IDYLB) +
          ',' + QuotedStr(CDYLB) + ',' + QuotedStr(CSFXM) + ',' + IntToStr(IZTJZ)
          + ',' + IntToStr(IZYKS) + ',' + QuotedStr(CZYKS) + ',' + IntToStr(IZYBQ)
          + ',' + QuotedStr(CZYBQ) + ',' + IntToStr(IZYYS) + ',' + QuotedStr(CZYYS)
          + ',' + QuotedStr(CurrToStr(Mje)) + ',' + QuotedStr(CurrToStr(MSJ)) +
          ',' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', DRQ)) + ',' +
          QuotedStr(CBZ) + ',' + QuotedStr(CDW) + ',' + FloatToStr(ISL) + ',' +
          QuotedStr(CurrToStr(MDJ)) + ',' + QuotedStr(CSFXMBM) + ',' + QuotedStr
          (CSFR) + ',' + FloatToStr(FBL) + ',' + IntToStr(ITXBJ) + ',' +
          QuotedStr(CTXR) + ',' + QuotedStr(CQMYS) + ',' + QuotedStr(CJZBJ) +
          ',' + QuotedStr(CDJH) + ',' + IntToStr(IYBBJ) + ',' + QuotedStr(CZXKSBM)
          + ',' + QuotedStr(CSSBH) + ',' + QuotedStr(CSFRGH) + ',' + BOOLTOSTR(BICUFY)
          + ',' + QuotedStr(CYJZD) + ',' + QuotedStr(CCWTJ) + ',' + QuotedStr(CFYTJ)
          + ',' + IntToStr(ILB) + ',' + booltostr(BTF) + ',' + QuotedStr(CZXKSMC)
          + ',' + QuotedStr(CZHXMBM) + ',' + QuotedStr(CZHXMMC) + ',' +
          QuotedStr(CKDKSBM) + ',' + QuotedStr(CKDKSMC) + ',' + QuotedStr(CXSE)
          + ',' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', DDYSJ)) + ','
          + QuotedStr(CZXRBM) + ',' + QuotedStr(CZXRMC) + ',' + QuotedStr(CLJBH)
          + ',' + IntToStr(IGCYS) + ',' + QuotedStr(CGCYS) + ',' + QuotedStr(CBRCW)
          + ',' + QuotedStr(CZRHSBM) + ',' + QuotedStr(CZRHSMC) + ',' +
          QuotedStr(CBJFYBZ) + ',' + QuotedStr(CTXM) + ',' + booltostr(BMZFY);
        if BSH then
          ACSQL := ACSQL + ',' + booltostr(BSH);
        if CTFYY <> '' then
          ACSQL := ACSQL + ',' + QuotedStr(CTFYY);
        if CYWFYBZ <> '' then
          ACSQL := ACSQL + ',' + QuotedStr(CYWFYBZ);
        if CSBXX <> '' then
          ACSQL := ACSQL + ',' + QuotedStr(CSBXX);
        if CSYMD <> '' then
          ACSQL := ACSQL + ',' + QuotedStr(CSYMD);
        ACSQL := ACSQL + ')';

        ACSQL := ACSQL + #13#10 + ' UPDATE TBZYBRFYBQ' + IntToStr(AZYBR.IZYBQ) +
          ' SET MLLFY=MLLFY+' + quotedstr(CurrToStr(Mje)) + ',MSJFY=MSJFY+' +
          quotedstr(CurrToStr(MSJ)) + ',MSJZFFY=MSJZFFY+' + quotedstr(CurrToStr(MSJ))
          + ',MZHDQJE=MZHDQJE-' + quotedstr(CurrToStr(MSJ)) + ',MYS' + (ICWBM) +
          '=MYS' + (ICWBM) + '+' + quotedstr(CurrToStr(Mje)) + ',MFY' + (ICWBM)
          + '=MFY' + (ICWBM) + '+' + quotedstr(CurrToStr(MSJ)) + ' WHERE CZYH='
          + Quotedstr(FCBRH);
        if Flag = 0 then
        begin
          for j := 0 to TBFYMXS.Count - 1 do
            ACSQL := ACSQL + #13#10' update ' + TBFYMXS[j] +
              ' set BTF=1 WHERE CJZD =' + QUOTEDSTR(CYJZD);
          if strtointdef(IXH, 0) > 1000 then
            ACSQL := ACSQL + #13#10 + 'delete ' + TBXMWZX + ' where cbh=' +
              QUOTEDSTR(CSQDH) + ' and CZTBM=' + quotedstr(CZHXMBM) + ' and ixh=' + IXH
        end;
      end;
    end;
    if ACSQL <> '' then
    begin
      if not ExeSql(QRYTEMP, ACSQL, True) then
      begin
        AERROR := 'סԺ������ϸ����ʧ��:' + AERROR;
        Exit;
      end;
    end;
    if (FBZTDCSF) and (Flag = 0) and (CDCSF <> '') and (Pos('|', CDCSF) < 1) then
    begin
      CXMSQL := 'UPDATE ' + TBXMWZX +
        ' SET ISTATUS=0,CDJH='''' WHERE  ISTATUS=2 AND  CBH=' + QUOTEDSTR(CSQDH)
        + ' AND CDJH IN (' + CDCSF + ')';
      if not ExeSql(QRYTEMP, CXMSQL, True) then
      begin
        AERROR := '�����뵥�����շ���Ŀ����:' + AERROR;
        Exit;
      end;
    end;
  finally
    if Assigned(TBFYMXS) then
      FreeAndNil(TBFYMXS);
    FreeAndNil(QRYTEMP);
  end;
  Result := True;
end;

function TYXSVR.SetMZFYMX(TmpLIST: TStringlist): Boolean;

  function AddFYMX(DateSet: TFDQuery; ILB: Integer): Boolean;   //ILB:0�շ���Ŀ��1�����Ϸѣ�2�����ӷ�
  const
    FunctionName = 'SetMZFYMX';
  var
    i: integer;
    SLBSF, SDCSF: TStringList;
    IGCP: Integer;
    CYKTZFFS: string;
  begin
    Result := False;
    try
      SLBSF := TStringList.Create;
      SDCSF := TStringList.Create;
      if ILB = 1 then
        SLBSF.Clear;
      if ILB = 0 then
        SDCSF.Clear;
      IGCP := GetIGCP;
      CYKTZFFS := GetYXXTCSI('YKTZFFS', '');
      if CYKTZFFS = '' then
      begin
        AERROR := 'δ����һ��֧ͨ����ʽ����[YKTZFFS]���޷�����һ��ͨ�շѣ�';
        exit;
      end;
      with DateSet do
      begin
        First;
        for i := 0 to RecordCount - 1 do
        begin
          if ILB = 1 then
          begin
            if SLBSF.indexof(fieldbyname('CBM').ASSTRING + '|' + fieldbyname('ILBSF').ASSTRING)
              <> -1 then
            begin
              Next;
              Continue;
            end;
            SLBSF.Add(DateSet.fieldbyname('CBM').ASSTRING + '|' + DateSet.fieldbyname
              ('ILBSF').ASSTRING);
          end;
          if (ILB = 0) and (FBZTDCSF) then
          begin
            if fieldbyname('IDCSF').AsInteger <> 0 then
            begin
              if iif(flag = 1, (SDCSF.indexof(fieldbyname('CBM').ASSTRING) <> -1),
                (fieldbyname('CDJH').ASSTRING = '')) then
              begin
                if flag = 0 then
                  FBTFCSDCSF := True;
                CDCSF := CDCSF + '|' + FCBH + '=' + fieldbyname('CBM').ASSTRING
                  + '^' + fieldbyname('IXH').ASSTRING + '|';
                Next;
                Continue;
              end;
              SDCSF.Add(fieldbyname('CSFXMBM').ASSTRING);
            end;
          end;
          with AMZFYMX.AItem, AMZFYMX do
          begin
            CSFD := FCSFD;    //�շѵ���
            CJZD := CSFD;    //�շѵ���
            CFPH := '';              //��Ʊ��
            DJZRQ := rdata;
            CMZH := AMZBR.CMZH;
            CYLH := AMZBR.CYLH;
            CXM := AMZBR.CXM;
            CXB := AMZBR.CXB;
            CNL := AMZBR.CNL;
            IKS := AMZBR.IKSBM;
            CKS := AMZBR.CKSMC;
            IYS := AMZBR.IYSBM;
            CYS := AMZBR.CYSMC;

            IBRDW := 0;
            CBRDW := '';

            ISFZL := AMZBR.ISFZL;
            CSFZL := AMZBR.CSFZL;

          //FBL
            IGRYH := 1;
            IXMYH := FieldByName('FBL').AsFloat;

            IIXH := FieldByName('IXH').AsInteger;
            IXH := FieldByName('IXH').AsInteger;
            CXMBM := FieldByName('CBM').AsString;
            CXMMC := FieldByName('CMC').AsString;
            CDW := FieldByName('CDW').AsString;
            CDJH := FCBH + '|' + FieldByName('CINNERID').AsString + '^' +
              FieldByName('IXH').AsString;
            ISL := fieldbyname('ISQDSL').AsCurrency;
            if ILB = 0 then
            begin
              MDJ := fieldbyname('MSQDDJ').AsCurrency;
              if fieldbyname('BTJ').ASBOOLEAN then
                MDJ := fieldbyname('MDJ').AsCurrency;
              if MDJ = 0 then
                MDJ := fieldbyname('MZTDJ').AsCurrency;
            end
            else if ILB = 1 then
              MDJ := fieldbyname('MDJ').AsCurrency;
          //����
            MYSJE := MDJ * ISL;
            MSSJE := 0;
            MJZJE := MYSJE * IXMYH;
            MSJJZ := MJZJE;

            CSSBH := '';
            CSFRGH := Fczygh;
            CSFR := Fczymc;
            CBZ := '';
            CYBH := '';
            if FAMODE = 'JC' then
              CFYLX := 'JC'
            else
              CFYLX := 'JY';
            if FSQDZXKSCLFS = '0' then
            begin
              CZXKSBM := FIZXKS;
              CZXKSMC := FCZXKS;
            end
            else if FSQDZXKSCLFS = '1' then
            begin
              CZXKSBM := FieldByName('CZXKSBMZT').AsString;
              CZXKSMC := FieldByName('CZXKSMCZT').AsString;
            end;
            CPYM := AMZBR.CPYM;
            IYKT := 1;
            ISFFS := StrToIntDef(COPY(CYKTZFFS, 1, Pos('|', CYKTZFFS) - 1), 0);
            CSFFS := COPY(CYKTZFFS, Pos('|', CYKTZFFS) + 1, length(CYKTZFFS));
            BGRTF := False;
            CZHSFXMBM := FieldByName('CZTBM').AsString;
            CZHSFXMMC := FieldByName('CZTMC').AsString;
            BTF := False;
            CCWTJ := FieldByName('CCWTJ').AsString;
            CFYTJ := FieldByName('CFYTJ').AsString;
            DGH := AMZBR.DGH;
            DYJZRQ := 0;
            if IGCP = 1 then
            begin
              MSSJE := 0;
              MSJJZ := 0;
              MJZJE := 0;
              CBZ := 'GCP';
            end;
            if (flag = 0) and (ILB = 0) then
            begin
              CYJZD := FieldByName('CDJH').AsString + FieldByName('IXH').AsString;
              CYSFD := CYJZD;
            end;
            AMZFYMX.AddItem;
            if ILB = 1 then
              CGLSQL := CGLSQL + #13#10 + 'insert into ' + TBXMWZX +
                '(CBH,CINNERID,CZTBM,IXH,CSFXMBM,MDJ,NSL,MCOSTS,MZFJ,CDJH,ISTATUS)' +
                ' values(' + quotedstr(FCBH) + ',' + quotedstr(fieldbyname('CINNERID').asstring)
                + ',' + quotedstr(CZHSFXMBM) + ',' + Quotedstr(fieldbyname('IXH').asstring)
                + ',' + quotedstr(CXMBM) + ',' + quotedstr(CURRtostr(MDJ)) + ','
                + floattostr(ISL) + ',' + quotedstr(CURRtostr(MSJJZ)) + ',' +
                quotedstr(CURRtostr(MSJJZ)) + ',' + quotedstr('') + ',0)';
          end;
          Next;
        end;
      end;
    finally
      FreeAndNil(SDCSF);
      FreeAndNil(SLBSF);
    end;
    Result := True;
  end;

const
  FunctionName = 'SetFYMX';
var
  I: integer;
  BETJCBL, CETDJ: string; //��ͯ�ӳɼӼ�
  SqlString, csql: string;  //sql j�ű�
  CSFXMBM, CZTBM: string;
  CSQLXM: string;
  QRYTEMP: TFDQuery;
begin
  //AMZBR
  Result := false;
  QRYTEMP := TFDQuery.Create(nil);
  try
    for I := 0 to TmpLIST.Count - 1 do
    begin
      csql := 'SELECT CDJH,ISTATUS FROM ' + TBXMWZX +
        '  WITH(NOLOCK) WHERE cbh=' + QuotedStr(FCBH) + ' AND CZTBM=' +
        QUOTEDSTR(TmpLIST[I]);
      if not ExeSql(QRYTEMP, csql, False, FunctionName) then
        Exit;
      if QRYTEMP.IsEmpty then
      begin
          //AERROR := '��Ч���շѼ����Ŀ['+TmpLIST[I]+']��'+CSQL;
        Continue;
      end;
      if (QRYTEMP.FieldByName('CDJH').AsString <> '') and (QRYTEMP.FieldByName('ISTATUS').AsString
        = '2') and (flag = 1) then
      begin
          //'�����Ŀ['+TmpLIST[I]+']���չ��ѣ������˴��շѣ�',FunctionName);
        Continue;
      end;
      if (QRYTEMP.FieldByName('CDJH').AsString = '') and (QRYTEMP.FieldByName('ISTATUS').AsString
        <> '2') and (flag = 0) then
      begin

      end;
      if CSQLXM = '' then
      begin
        CSQLXM := 'SELECT CSFXMBM FROM ' + SDBLX +
          '..TBZDZTMX WITH(NOLOCK) WHERE CZTBM=' + QUOTEDSTR(TmpLIST[I]);
        CZTBM := QuotedStr(TmpLIST[I]);
      end
      else if CSQLXM <> '' then
      begin
        CSQLXM := CSQLXM + #13#10 + ' union ' + #13#10 + 'SELECT CSFXMBM FROM '
          + SDBLX + '..TBZDZTMX  WITH(NOLOCK) WHERE CZTBM=' + QUOTEDSTR(TmpLIST[I]);
        CZTBM := CZTBM + ',' + QuotedStr(TmpLIST[I]);
      end;
    end;
    CDCSFZT := CZTBM;
    if CZTBM = '' then
    begin
      AERROR := '��ǰ����Ҫ�շ���Ŀ��';
      result := True;
      Exit;
    end;
    if not ExeSql(QRYTEMP, CSQLXM, False, FunctionName) then
      Exit;
    if QRYTEMP.IsEmpty then
    begin
      AERROR := 'δ�ҵ���ǰ��Ӧ�����Ŀ��ϸ:' + CSQLXM;
      Exit;
    end;
    QRYTEMP.First;
    for I := 0 to QRYTEMP.RecordCount - 1 do
    begin
      CSFXMBM := CSFXMBM + iif(CSFXMBM = '', '', ',') + QuotedStr(QRYTEMP.fieldbyname
        ('CSFXMBM').asstring);
      QRYTEMP.Next;
    end;
     { for i:=0 to TmpLIST.Count -1 do
      begin
        CSFXMBM := CSFXMBM + iif(CSFXMBM = '', '', ',') + QuotedStr(TmpLIST[i]);
      end;  }
    BETJCBL := GetYXXTCSI('IUSEETJCBLFS', ''); // ��ͯ��
    if BETJCBL = '2' then  //ʹ�ö�ͯ�ӳɵ���
      CETDJ := ',(select MDJ from ' + SDBLX + '..TBZDETSFXMDZ where CBM=b.cbm) METJCDJ ';

    FCSFD := GetSysNumber2('CMZJZD', 1, '00');
    SqlString := 'select fbl' + IntToStr(AMZBR.ISFZL) +
      ' FBL,b.*,c.CZTBM,C.IXH,c.Cinnerid,C.CDJH, c.csfxmbm,convert(varchar(200),'''') CXMMC,C.NSL ISL,B.CBMWP' +
      ',(select TOP 1 CMC from ' + SDBLX +
      '..VTBZDZTHZ_M with(nolock) where CBM=c.cztbm and CSFXMBM=c.csfxmbm) CZTMC' +
      ',(select TOP 1 CZXKSBM from ' + SDBLX +
      '..TBZDZTHZ with(nolock) where CBM=c.cztbm and CSFXMBM=c.csfxmbm) CZXKSBMZT' +
      ',(select TOP 1 CZXKSMC from ' + SDBLX +
      '..TBZDZTHZ with(nolock) where CBM=c.cztbm and CSFXMBM=c.csfxmbm) CZXKSMCZT' +
      ',(select TOP 1 BTJ from ' + SDBLX +
      '..VTBZDZTMX_M with(nolock) where CZTBM=c.cztbm and CSFXMBM=c.csfxmbm) BTJ' +
      ',(select TOP 1 MDJ from ' + SDBLX +
      '..VTBZDZTMX_M with(nolock) where CZTBM=c.cztbm and CSFXMBM=c.csfxmbm) MZTDJ,C.MDJ MSQDDJ,C.NSL ISQDSL ' +
      iif(FBZTDCSF, ',(select TOP 1 IDCSF from ' + SDBLX +
      '..VTBZDZTMX_M with(nolock) where CZTBM=c.cztbm and CSFXMBM=c.csfxmbm) IDCSF',
      '') + CETDJ + ',CCWTJ=CW.CMC,CFYTJ=fy.CMC  ' + '  from ' + TBXMWZX +
      ' c with(nolock), ' + SDBLX + '..tbzdsfxmmz b with(nolock) ' +
      ' LEFT JOIN ' + SDBLX + '..TBZDCWTJMZ cw ON b.ICWBM=cw.IBM LEFT JOIN ' +
      SDBLX + '..TBZDFYTJMZ fy ON b.IFYBM=fy.IBM  ' + ' where b.CBM in (' +
      CSFXMBM + ')' + ' AND C.CZTBM IN (' + CZTBM + ') and c.cbh=' + quotedstr(FCBH)
      + ' and c.csfxmbm=b.cbm';
    if not ExeSql(QRYTEMP, SqlString, False) then
      Exit;
    if QRYTEMP.IsEmpty then
    begin
      AERROR := 'δ�ҵ���Ӧ���շ���Ŀ���ݣ�CSQL=' + csql;
      exit;
    end;
      //QRYTEMP.DisableControls;

    if not AddFYMX(QRYTEMP, 0) then
    begin
      AERROR := '��֯������ϸʧ�ܣ�' + AERROR;
      exit;
    end;
    try
        //���Ϸ�
      csql :=
        'select distinct  1 fbl,  gl.CSFXMMC CMC,gl.CSFXMBM CBM,gl.ILBSF,gl.MDJ,GL.NSL ISQDSL' +
        ' ,GL.IXH+1000 IXH,GL.CZTBM,C.CZXKSBM CZXKSBMZT,C.CZXKSMC CZXKSMCZT ,C.CMC CZTMC,XM.CINNERID ' +
        ' ,D.CDW,D.ICWBM,D.IFYBM, E.CMC CFYTJ,F.CMC CCWTJ' + ' from ' + TBXMWZX
        + ' xm with(nolock),' + SDBLX + '..Tbzdzhxmglclfmx gl with(nolock)' +
        ' ,' + SDBLX + '..TBZDZTHZ C WITH(NOLOCK),' + SDBLX +
        '..TBZDSFXMMZ D WITH(NOLOCK),' + SDBLX + '..TBZDFYTJMZ E WITH(NOLOCK),'
        + SDBLX + '..TBZDCWTJMZ F WITH(NOLOCK) ' +
        ' where E.IBM=D.IFYBM AND F.IBM=D.ICWBM AND C.CBM=GL.CZTBM AND D.CBM=GL.CSFXMBM ' +
        ' AND xm.CZTBM=gl.CZTBM and  xm.CZTBM IN (' + CZTBM + ') and xm.CBH=' +
        QuotedStr(FCBH);

      if not ExeSql(QRYTEMP, csql, False, FunctionName) then
        Exit;
      if not QRYTEMP.IsEmpty then
      begin
        if not AddFYMX(QRYTEMP, 1) then
        begin
          AERROR := '����������֯������ϸʧ�ܣ�' + AERROR;
          exit;
        end;
      end;
        //���ӷ�
        //����ֵ���շѱ���1,����@ִ�п��ұ���@ִ�п�������|�շѱ���2,����@ִ�п��ұ���@ִ�п�������
        {if BFJF then
        begin
        CSQL := ' DECLARE	@return_value int,@RetMessage varchar(2000)'
              + #13#10 + ' EXEC @return_value = [dbo].[usp_GetTubeCount] '
              + #13#10 + ' @ChargeItemList=N' + QuotedStr('MZ|'+cbh) + ', '
              + #13#10 + ' @RetMessage= @RetMessage OUTPUT '
              + #13#10 + ' SELECT @RetMessage AS N''@RetMessage'' ';
        if not ExeSql(QRYTEMP ,CSQL, False,FunctionName) then  Exit;
        if not QRYTEMP.IsEmpty then
        begin
          try
            FJFLIST := TStringList.Create;
            FJFLIST.Delimiter := '|';
            FJFLIST.DelimitedText := QRYTEMP.fieldbyname('@RetMessage').asstring;
            FJSFD := GetYJMZSfd;
            for i := 0 to FJFLIST.Count-1 do
            begin
                with AFYMX.AItem do
                begin
                  ASFXM.ResetValue;
                  ASFXM.CBM :=GetFJFHCJX(FJFLIST[i],1);
                  ASFXM.CBM'].IsCondition :=TRUE;
                  ASFXM.BENABLE :=TRUE;
                  ASFXM.BENABLE'].IsCondition :=TRUE;
                  if not ASFXM.ReadEmpty() then exit;
                  if ASFXM.EmptyData then
                  begin
                    AERROR :='δ�ҵ����շ���Ŀ��' + FJFLIST[I] + '��';
                    WriteYXLog(AERROR,FunctionName);
                    exit;
                  end;
                  CSFD:=FJSFD;    //�շѵ���
                  CJZD:=CSFD;    //�շѵ���
                  CFPH:='';              //��Ʊ��
                  DJZRQ:=rdata;
                  CMZH :=AMZBR.CMZH;
                  CYLH :=AMZBR.CYLH;
                  CXM :=AMZBR.CXM;
                  CXB :=AMZBR.CXB;
                  CNL :=AMZBR.CNL;
                  IKS:=AMZBR.IKSBM;
                  CKS:=AMZBR.CKSMC;
                  IYS:=AMZBR.IYSBM;
                  CYS:=AMZBR.CYSMC;

                  IBRDW:=0;
                  CBRDW :='';

                  ISFZL:=AMZBR.ISFZL;
                  CSFZL :=AMZBR.CSFZL;

                  //FBL
                  IGRYH:=1;
                  IXMYH:=1;

                  IIXH :=i+1;
                  IXH :=i+1;
                  CXMBM:=GetFJFHCJX(FJFLIST[i],1);
                  CXMMC:=ASFXM.CMC;;
                  CDW:=ASFXM.CDW;

                  MDJ:=ASFXM.MDJ;
                  ISL:=strtocurr(GetFJFHCJX(FJFLIST[i],2));
                  //����
                  MYSJE:=ASFXM.MDJ*strtocurr(GetFJFHCJX(FJFLIST[i],2));
                  MSSJE:=0;
                  MJZJE:=MYSJE;
                  MSJJZ:=MYSJE;

                  CSSBH :='';
                  CSFRGH :=czygh;
                  CSFR :=czymc;
                  CBZ:='';
                  CYBH:='';
                  CZXKSBM:=CZXKSBM;
                  CZXKSMC:=CZXKSMC;
                  CPYM:=AMZBR.CPYM;
                  IYKT:=1;
                  ISFFS:=COPY(CYKTZFFS,1,Pos('|',CYKTZFFS)-1);
                  CSFFS:=COPY(CYKTZFFS,Pos('|',CYKTZFFS)+1,length(CYKTZFFS));
                  BGRTF:=0;
                  CZHSFXMBM:='';
                  CZHSFXMMC:='';
                  BTF:=0;
                  CFYLX:='';
                  CDJH:='';
                  ICWBM:=ASFXM.ICWBM;
                  IFYBM:=ASFXM.IFYBM;
                  CCWTJ :=GetTJMC(ASFXM.ICWBM,0,1);
                  CFYTJ :=GetTJMC(ASFXM.IFYBM,1,1);
                  DGH:=AMZBR.DGH;
                  AFYMX.AddItem;
                end;
            end;
          finally
            FreeAndNil(FJFLIST);
          end;
        end;
        end; }
    finally
        //QRYTEMP.EnableControls;
    end;
  finally
    FreeAndNil(QRYTEMP);
  end;
  Result := True;
end;

function TYXSVR.SetMZFYMXTF(TmpLIST: TStringlisT): Boolean; //�����Ҫ�˼����Ŀ

  function SetTFMX(DateSet: TFDQuery): boolean;
  begin
    Result := false;
    with AFYMXTF.AItem, DateSet, AFYMXTF do
    begin
      CSFD := FieldByName('CSFD').AsString;    //�շѵ���
      CJZD := CSFD;
      CFPH := '';              //��Ʊ��
      DJZRQ := rdata;
      CMZH := AMZBR.CMZH;
      CYLH := AMZBR.CYLH;
      CXM := AMZBR.CXM;
      CXB := AMZBR.CXB;
      CNL := AMZBR.CNL;
      IKS := AMZBR.IKSBM;
      CKS := AMZBR.CKSMC;
      IYS := AMZBR.IYSBM;
      CYS := AMZBR.CYSMC;

      IBRDW := 0;
      CBRDW := '';

      ISFZL := AMZBR.ISFZL;
      CSFZL := AMZBR.CSFZL;

    //FBL
      IGRYH := 1;
      IXMYH := 1;

      CYSFD := FieldByName('CSFD').AsString + FieldByName('IIXH').AsString;
      CYJZD := FieldByName('CJZD').AsString;
      IIXH := FieldByName('IIXH').AsInteger;
      IXH := FieldByName('IXH').AsInteger;
      CXMBM := FieldByName('CXMBM').AsString;
      CXMMC := FieldByName('CXMMC').AsString;
      CDW := FieldByName('CDW').AsString;

      MDJ := FieldByName('MDJ').AsCurrency;
      ISL := FieldByName('ISL').AsCurrency *  - 1;
    //����
      MYSJE := FieldByName('MYSJE').AsCurrency *  - 1;
      MSSJE := 0;
      MJZJE := FieldByName('MJZJE').AsCurrency *  - 1;
      MSJJZ := FieldByName('MSJJZ').AsCurrency *  - 1;

      CSSBH := '';
      CSFRGH := fczygh;
      CSFR := fczymc;
      CBZ := '';
      CYBH := '';
      IYKT := 1;
      ISFFS := FieldByName('ISFFS').AsInteger;
      CSFFS := FieldByName('CSFFS').AsString;
      CZXKSBM := FieldByName('CZXKSBM').AsString;
      CZXKSMC := FieldByName('CZXKSMC').AsString;
      CPYM := FieldByName('CPYM').AsString;

      BGRTF := False;
      CZHSFXMBM := FieldByName('CZHSFXMBM').AsString;
      CZHSFXMMC := FieldByName('CZHSFXMMC').AsString;
      BTF := True;
      if fAMODE = 'JC' then
        CFYLX := 'JC'
      else
        CFYLX := 'JY';

      CDJH := FieldByName('CDJH').AsString;
      CCWTJ := FieldByName('CCWTJ').AsString;
      CFYTJ := FieldByName('CFYTJ').AsString;

      DGH := FieldByName('DGH').AsDateTime;
      DYJZRQ := FieldByName('DJZRQ').AsDateTime;
      DYJZRQ := FieldByName('DJZRQ').AsDateTime;

    end;
    AFYMXTF.AddItem;
    Result := True;
  end;

const
  FunctionName = 'SetMZFYMXTF';
var
  csql: string;
  i: Integer;
  CTFTJ: string;
  TBFYMXS: TStrings;
  QRYTEMP: TFDQuery;
  CSFD: string;
begin
  Result := false;
  QRYTEMP := TFDQuery.Create(nil);
  try
    csql := 'SELECT CDJH,CZTBM FROM ' + tbxmwzx +
      ' WITH(NOLOCK) WHERE ISTATUS = 2 AND  CBH=' + Quotedstr(FCBH);
    if not ExeSql(QRYTEMP, csql, False, FunctionName) then
      Exit;
    if QRYTEMP.IsEmpty then
    begin
      AERROR := 'δ�ҵ���Ӧ���뵥���ݣ�' + csql;
      exit;
    end;
    QRYTEMP.First;
    for i := 0 to QRYTEMP.RecordCount - 1 do
    begin
      if CTFTJ <> '' then
        CTFTJ := CTFTJ + ',';
      CTFTJ := CTFTJ + QuotedStr(QRYTEMP.fieldbyname('CDJH').asstring);
      if QTZTLIST.IndexOf(QRYTEMP.fieldbyname('CZTBM').asstring) = -1 then
        QTZTLIST.Add(QRYTEMP.fieldbyname('CZTBM').asstring);
      QRYTEMP.Next;
    end;
    for i := 0 to QTZTLIST.Count - 1 do
    begin
      if TmpLIST.IndexOf(QTZTLIST[i]) = -1 then
        WTFZTLIST.Add(QTZTLIST[i]);
    end;
   { if QTZTLIST.Count = TmpLIST.count then
      ISFZT := 1
    esle
      ISFZT := 2;  }
    CSFD := GetSysNumber2('CMZJZD', 1, '00');
    csql := '';
    try
      TBFYMXS := GetNkTables('TBMZFYMX', AMZBR.DGH, rdata);
      for i := 0 to TBFYMXS.Count - 1 do
        csql := iif(csql = '', 'select * from ' + TBFYMXS[i] +
          ' WITH(nolock) WHERE CSFD in(' + CTFTJ + ')', csql + #10#13 +
          ' UNION ' + #10#13 + 'select * from ' + TBFYMXS[i] +
          ' WITH(nolock) WHERE CSFD in(' + CTFTJ + ')');
    finally
      FreeAndNil(TBFYMXS);
    end;
    if csql = '' then
    begin
      AERROR := '�˷Ѳ�ѯ���ݴ���:δ�ҵ���Ӧ�Ľű���' + csql;
      exit;
    end;
    if not ExeSql(QRYTEMP, csql, false) then
    begin
      AERROR := '�˷Ѳ�ѯ���ݴ���:' + AERROR;
      Exit;
    end;
    if QRYTEMP.isEmpty then
    begin
      AERROR := 'δ�ҵ��˷���Ӧ���ݣ�' + csql;
      Exit;
    end;

    while not QRYTEMP.Eof do
    begin
      if QRYTEMP.FieldByName('BTF').AsBoolean then
      begin
        AERROR := QRYTEMP.FieldByName('CJZD').AsString + ':' + QRYTEMP.FieldByName
          ('CXMBM').AsString + '�Ѿ����˲����ظ���';
        Exit;
      end;
      if QRYTEMP.FieldByName('IYKT').AsInteger <> 1 then
      begin
        AERROR := '��һ��ͨ�շѻ���һ��ͨ�ѽ��㣡�뵽���ﴰ���˷ѣ�';
        Exit;
      end;
      SetTFMX(QRYTEMP);
      QRYTEMP.Next;
    end;
  finally
    FreeAndNil(QRYTEMP);
  end;
  Result := true;

end;

function TYXSVR.SaveMZFYMX(ILX: Integer): Boolean;
const
  FunctionName = 'SaveMZFYMX';
var
  TBFYMX: string;  //�޸�ԭ����
  ACSQL, CSQL, CUPSQL, CTFSQL, CSQLTmp, CSQDH: string;
  I, J: Integer;
  IXH: string;
  mje: Currency;
  AFYMXTMP: TMZFYMX;
  TBFYMXS: TStrings;
  TDCSF: TStringList;
  CXMBM, CSDCSF: string;
  QRYTEMP: TFDQuery;
begin
  Result := false;
  mje := 0;
  CSQL := '';
  ACSQL := '';
  QRYTEMP := TFDQuery.Create(nil);
  try
    if ILX = 1 then
    begin
      if not FBYKTJZ then
      begin
        for I := 0 to AMZFYMX.Count - 1 do
        begin
          mje := mje + AMZFYMX.Items[I].MSJJZ;
        end;
        if (MZHYE - mje < 0) then
        begin
          AERROR := '�˻����㣡,���ֵ��' + #13#10 + '�˻���' + currtostr(MZHYE) +
            #13#10 + '��Ҫ֧����' + currtostr(mje) + #13#10 + '';
          Exit;
        end;
      end;
      if CGLSQL <> '' then
      begin
        if not ExeSql(QRYTEMP, CGLSQL, True) then
        begin
          AERROR := '������Ϸ���ϸ����:' + AERROR;
          Exit;
        end;
      end;
      TBFYMX := GetTBName('TBMZFYMX', FormatDateTime('YYMMDD', rdata), 4);
      AFYMXTMP := AMZFYMX;
    end
    else
    begin
      TBFYMXS := GetNkTables('TBMZFYMX', AMZBR.DGH, rdata);
      TBFYMX := GetTBName('TBMZFYMXTF', FormatDateTime('YYMMDD', rdata), 4);
      AFYMXTMP := AFYMXTF;
    end;
    if AFYMXTMP.Count = 0 then
    begin
      //Result := True;
      //AERROR :='����Ҫ�շ���ϸ�����飡';
      Result := True;
      Exit;
    end;
    for I := 0 to AFYMXTMP.Count - 1 do
    begin
      with AFYMXTMP.Items[I], AFYMXTMP do
      begin
        if CZHSFXMBM <> '' then
        begin
          CSQDH := Copy(CDJH, 1, Pos('|', CDJH) - 1);
          IXH := StrToInt(copy(CDJH, Pos('^', CDJH) + 1, length(CDJH) - Pos('^', CDJH)));
          if ILX = 1 then
          begin
            CSQLTmp := 'UPDATE ' + TBXMWZX + ' SET ISTATUS=2,CDJH=' + QUOTEDSTR(CSFD)
              + ' WHERE IXH=' + IntToStr(IXH) + ' AND CSFXMBM=' + QUOTEDSTR(CXMBM)
              + ' AND ISTATUS<>2 AND CBH=' + QUOTEDSTR(CSQDH) + ' AND CZTBM=' +
              QUOTEDSTR(CZHSFXMBM);
              //�����շѣ�������ͬ����ĿΪistatus=2
            if (BZTDCSF) and (CDCSF <> '') and (Pos('|' + CSQDH + '=' + CXMBM +
              '^', CDCSF) > 0) and (iif(flag = 1, Pos('|' + CSQDH + '=' + CXMBM
              + '^' + inttostr(IXH) + '|', CDCSF) < 1, Pos('|' + CSQDH + '=' +
              CXMBM + '^' + inttostr(IXH) + '|', CDCSF) > 0)) then
            begin

              CSQLTmp := CSQLTmp + #13#10 + 'UPDATE ' + TBXMWZX +
                ' SET ISTATUS=2 WHERE ISTATUS<>2 AND ISNULL(CDJH,'''')=''''  AND CSFXMBM=' +
                QUOTEDSTR(CXMBM) + ' AND CZTBM in (' + CDCSFZT + ')' +
                ' AND CBH=' + QUOTEDSTR(CSQDH);
            end;
          end
          else
          begin
            CSQLTmp := 'UPDATE ' + TBXMWZX +
              ' SET ISTATUS=0,CDJH='''' WHERE IXH=' + inttostr(IXH) +
              ' and CSFXMBM=' + QUOTEDSTR(CXMBM) + ' AND  ISTATUS=2 AND CBH=' +
              QUOTEDSTR(CSQDH) + ' AND CZTBM=' + QUOTEDSTR(CZHSFXMBM);
              //�����շѣ�������ͬ����ĿΪͬһ�����ݺţ���ʱ������IXH��Ϊwehre����
            if (BZTDCSF) then
            begin
              CSQLTmp := CSQLTmp + #13#10 + 'UPDATE ' + TBXMWZX +
                ' SET ISTATUS=0,CDJH='''' WHERE  CBH=' + QUOTEDSTR(CSQDH);
            end;
          end;
          if ExeSql(QRYTEMP, CSQLTmp) < 1 then
          begin
            if ILX = 1 then
            begin
              AERROR := '���뵥���շѣ���ֹ�ظ��շѣ�' + CSQLTmp;
              Exit;
            end;
          end;
        end;
        ACSQL := ACSQL + #13#10 + ' INSERT INTO ' + TBFYMX +
          ' (CSFD,IXH,CMZH,CFPH,CYLH,CXM,CXB,CNL,IBRDW,CBRDW,ISFZL,CSFZL,ISFFS,CSFFS,IGRYH,IXMYH,' +
          'CXMBM,CXMMC,CDW,ISL,MDJ,IKS,CKS,IYS,CYS,CSFRGH,CSFR,MYSJE,MSSJE,MJZJE,MSJJZ,DJZRQ,CBZ,' +
          'CYBH,CZXKSBM,CZXKSMC,CPYM,CSHRMC,DSHRQ,BSH,BGRTF,CZHSFXMBM,CZHSFXMMC,CFYLX,CDJH,BTF,BLC,'+
          'CTFCZYGH,CTFCZYXM,IIXH,CJZD,CJZRGH,CJZR,CSSBH,MYBZF,MYHZF,CZXRBM,CZXRMC,CFYBM,IYKT,' +
          'DYKTJS,DGH,CYSFD,DYJZRQ,CFYTJ,CCWTJ,CYJZD,MYHJE,CXJKH,IXZJYPKBX,CHJR,MZFZYBJE';
        if BKSFZT then
          ACSQL := ACSQL + ',BKSFZT';
        if CDYID <> '' then
          ACSQL := ACSQL + ',CDYID';
        if CZHXMBM <> '' then
          ACSQL := ACSQL + ',CZHXMBM';
        if CZHXMMC <> '' then
          ACSQL := ACSQL + ',CZHXMMC';
        if CSBXX <> '' then
          ACSQL := ACSQL + ',CSBXX';
        ACSQL := ACSQL + ') VALUES (' + Quotedstr(CSFD) + ',' + INTTOSTR(IXH) +
          ',' + Quotedstr(CMZH) + ',' + Quotedstr(CFPH) + ',' + Quotedstr(CYLH)
          + ',' + Quotedstr(CXM) + ',' + Quotedstr(CXB) + ',' + Quotedstr(CNL) +
          ',0,'''',' + INTTOSTR(ISFZL) + ',' + Quotedstr(CSFZL) + ',' + INTTOSTR
          (ISFFS) + ',' + Quotedstr(CSFFS) + ',' + FloatToStr(IGRYH) + ',' +
          FloatToStr(IXMYH) + ',' + Quotedstr(CXMBM) + ',' + Quotedstr(CXMMC) +
          ',' + Quotedstr(CDW) + ',' + FloatToStr(ISL) + ',' + Quotedstr(CurrToStr
          (MDJ)) + ',' + INTTOSTR(IKS) + ',' + Quotedstr(CKS) + ',' + INTTOSTR(IYS)
          + ',' + Quotedstr(CYS) + ',' + Quotedstr(CSFRGH) + ',' + Quotedstr(CSFR)
          + ',' + Quotedstr(CurrToStr(MYSJE)) + ',' + Quotedstr(CurrToStr(MSSJE))
          + ',' + Quotedstr(CurrToStr(MJZJE)) + ',' + Quotedstr(CurrToStr(MSJJZ))
          + ',' + Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', DJZRQ)) + ','
          + Quotedstr(CBZ) + ',' + Quotedstr(CYBH) + ',' + Quotedstr(CZXKSBM) +
          ',' + Quotedstr(CZXKSMC) + ',' + Quotedstr(CPYM) + ',' + Quotedstr(CSHRMC)
          + ',' + Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', DSHRQ)) + ','
          + booltostr(BSH) + ',' + booltostr(BGRTF) + ',' + Quotedstr(CZHSFXMBM)
          + ',' + Quotedstr(CZHSFXMMC) + ',' + Quotedstr(CFYLX) + ',' +
          Quotedstr(CDJH) + ',' + booltostr(BTF) + ',' + booltostr(BLC) + ',' +
          Quotedstr(CTFCZYGH) + ',' + Quotedstr(CTFCZYXM) + ',' + INTTOSTR(IIXH)
          + ',' + Quotedstr(CJZD) + ',' + Quotedstr(CJZRGH) + ',' + Quotedstr(CJZR)
          + ',' + Quotedstr(CSSBH) + ',' + Quotedstr(CurrToStr(MYBZF)) + ',' +
          Quotedstr(CurrToStr(MYHZF)) + ',' + Quotedstr(CZXRBM) + ',' +
          Quotedstr(CZXRMC) + ',' + Quotedstr(CFYBM) + ',' + INTTOSTR(IYKT) +
          ',' + Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', DYKTJS)) + ',' +
          Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', DGH)) + ',' +
          Quotedstr(CYSFD) + ',' + Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS',
          DYJZRQ)) + ',' + Quotedstr(CFYTJ) + ',' + Quotedstr(CCWTJ) + ',' +
          Quotedstr(CYJZD) + ',' + Quotedstr(CurrToStr(MYHJE)) + ',' + Quotedstr
          (CXJKH) + ',' + INTTOSTR(IXZJYPKBX) + ',' + Quotedstr(CHJR) + ',' +
          Quotedstr(CurrToStr(MZFZYBJE));
        if BKSFZT then
          ACSQL := ACSQL + ',' + booltostr(BKSFZT);
        if CDYID <> '' then
          ACSQL := ACSQL + ',' + Quotedstr(CDYID);
        if CZHXMBM <> '' then
          ACSQL := ACSQL + ',' + Quotedstr(CZHXMBM);
        if CZHXMMC <> '' then
          ACSQL := ACSQL + ',' + Quotedstr(CZHXMMC);
        if CSBXX <> '' then
          ACSQL := ACSQL + ',' + Quotedstr(CSBXX);
        ACSQL := ACSQL + ')';
        if (ILX = 0) then
        begin
          for J := 0 to TBFYMXS.Count - 1 do
          begin
            ACSQL := ACSQL + #13#10' update ' + TBFYMXS[J] +
              ' set BTF=1 WHERE CSFD =' + QUOTEDSTR(CSFD) + ' and IXH=' +
              IntToStr(IXH) + ' and CXMBM=' + QUOTEDSTR(CXMBM);
            if IXH > 1000 then
              ACSQL := ACSQL + #13#10 + 'delete ' + TBXMWZX + ' where cbh=' +
                QUOTEDSTR(CSQDH) + ' and CZTBM=' + quotedstr(CZHSFXMBM) +
                ' and ixh=' + IntToStr(IXH);
          end;
        end;
      end;
    end;
   { if ACSQL <> '' then
    begin
      if not ExeSql(QRYTEMP,ACSQL,True) then
      begin
        AERROR := '���������ϸ����ʧ��:'+AERROR;
        Exit;
      end;
    end;  }
    CSQLTmp := '';
    IXH := '';
    CXMBM := '';
    //�˷�����ʱ�������շѼ����Ŀ��������±�� IXHΪ�������շ���Ŀ�����
    if FBTFCSDCSF then
    begin
      if CDCSF <> '' then
      begin
        try
          TDCSF := TStringList.Create;
          TDCSF.Text := StringReplace(CDCSF, '|', #13#10, [rfReplaceAll]);
          for I := 0 to TDCSF.Count - 1 do
          begin
            CXMBM := '';
            CSDCSF := TDCSF[I];
            CXMBM := Copy(CSDCSF, Pos('=', CSDCSF) + 1, (Pos('^', CSDCSF)) - (Pos
              ('=', CSDCSF) + 1));
            if CXMBM = '' then
              Continue;
            IXH := Copy(CSDCSF, Pos('^', CSDCSF) + 1, length(CSDCSF) - Pos('^', CSDCSF));
            ACSQL := ACSQL + #13#10 + 'UPDATE ' + TBXMWZX +
              ' SET ISTATUS=2 WHERE ISTATUS<>2 AND CSFXMBM=' + QUOTEDSTR(CXMBM)
              + ' AND CZTBM in (' + CDCSFZT + ') AND IXH=' + IXH + ' AND CBH=' +
              QUOTEDSTR(CSQDH);
          end;
        finally
          FreeAndNil(TDCSF);
        end;
      end;
    end;
    if ACSQL <> '' then
    begin
      if not ExeSql(QRYTEMP, ACSQL, True) then
      begin
        AERROR := '���������ϸ����ʧ��:' + AERROR;
        Exit;
      end;
    end;
    if not SaveYKTFYMX(AFYMXTMP) then
    begin
      AERROR := AERROR + '����һ��ͨ������ϸ�շ�ʧ��';
      Exit;
    end;
  finally
    FreeAndNil(TBFYMXS);
    FreeAndNil(QRYTEMP);
  end;
  Result := True;
end;

function TYXSVR.SaveYKTFYMX(AMZFYMX: TMZFYMX): Boolean;
type
  TKeyBit = (kb128, kb192, kb256);
  function EncryptString(Value: string; Key: string; KeyBit: TKeyBit = kb128): string;
    function StrToHex(Value: string): string;
    var
      I: Integer;
    begin
      Result := '';
      for I := 1 to Length(Value) do
        Result := Result + IntToHex(Ord(Value[I]), 2);
    end;

  var
    SS, DS: TStringStream;
    Size: Int64;
    AESKey128: TAESKey128;
    AESKey192: TAESKey192;
    AESKey256: TAESKey256;
  begin
    Result := '';
    SS := TStringStream.Create(Value);
    DS := TStringStream.Create('');
    try
      Size := SS.Size;
      DS.WriteBuffer(Size, SizeOf(Size));
    {  --  128 λ�ܳ���󳤶�Ϊ 16 ���ַ� --  }
      if KeyBit = kb128 then
      begin
        FillChar(AESKey128, SizeOf(AESKey128), 0);
        Move(PAnsiChar(Key)^, AESKey128, Min(SizeOf(AESKey128), Length(Key)));
        EncryptAESStreamECB(SS, 0, AESKey128, DS);
      end;
    {  --  192 λ�ܳ���󳤶�Ϊ 24 ���ַ� --  }
      if KeyBit = kb192 then
      begin
        FillChar(AESKey192, SizeOf(AESKey192), 0);
        Move(PAnsiChar(Key)^, AESKey192, Min(SizeOf(AESKey192), Length(Key)));
        EncryptAESStreamECB(SS, 0, AESKey192, DS);
      end;
    {  --  256 λ�ܳ���󳤶�Ϊ 32 ���ַ� --  }
      if KeyBit = kb256 then
      begin
        FillChar(AESKey256, SizeOf(AESKey256), 0);
        Move(PAnsiChar(Key)^, AESKey256, Min(SizeOf(AESKey256), Length(Key)));
        EncryptAESStreamECB(SS, 0, AESKey256, DS);
      end;
      Result := StrToHex(DS.DataString);
    finally
      FreeAndNil(SS);
      FreeAndNil(DS);
    end;
  end;
  function GetYKTFQFYMX(CKH: string): string;
  const
    FunctionName = 'GetYKTFQFYMX';
  begin
    Result := 'YXYKT..TBYKTFYMX';
    if CKH = '' then
    begin
      AERROR := '�޿��ţ����飡';
      Exit;
    end;
  //ʹ��һ�����÷�����ģʽ(��ҽ�ƿ���β������,��³����)
    if GetYXXTCSI('IYKTFYFQB', 0) = 1 then
    begin
      Result := 'YXYKT....TBYKTFYMX' + '0' + Copy(CKH, Length(CKH), 1);
    end;
  end;

const
  FunctionName = 'SaveYKTFYMX';
var
  I: Integer;
  ASQL, AUPSQL: string;
  ATBMZFYMX: string;
  MJZJETmp: Currency;
  AMZHYE: Currency;
  TBYKTNAME: string;
  QryTemp: TFDQuery;
  CMoneyEncrypt: string;
begin
  Result := False;
  QryTemp := TFDQuery.Create(nil);
  try
    ASQL := '';
    AUPSQL := '';
    MJZJETmp := 0;
    AMZHYE := MZHYE;
    TBYKTNAME := GetYKTFQFYMX(FCYLH);
    ATBMZFYMX := GetTBName('TBMZFYMX', FormatDateTime('YYMMDD', rdata), 4);
    with AMZFYMX do
    begin
      for I := 0 to Count - 1 do
      begin
        ASQL := ' insert into ' + TBYKTNAME +
          '(CXH,CMZH,CCKH,CXMBM,CXMMC,ISL,MDJ,DJZRQ,CDJH,CFYLX,BTF,MBCJZQYE,MBCJZHYE' +
          ',CGH,CTbName,CSFD,MJZJE,MSSJE,FBL,CJSDH,CJZD)values(' + inttostr(items
          [I].IXH) + ',' + quotedstr(AMZFYMX.CMZH) + ',' + quotedstr(AMZFYMX.CYLH)
          + ',' + quotedstr(items[I].CXMBM) + ',' + quotedstr(items[I].CXMMC) +
          ',' + FloatToStr(items[I].ISL) + ',' + quotedstr(CurrToStr(items[I].MDJ))
          + ',' + Quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', items[I].DJZRQ))
          + ',' + quotedstr(items[I].CSFD) + ',' + quotedstr(items[I].CFYLX) +
          ',' + inttostr(iif(items[I].BTF, -1, 0)) + ',' + CurrToStr(AMZHYE) +
          ',' + Quotedstr(CurrToStr(AMZHYE - items[I].MJZJE)) + ',' + quotedstr(items
          [I].CJZRGH) + ',' + quotedstr(ATBMZFYMX) + ',' + quotedstr(items[I].CSFD)
          + ',' + Quotedstr(CurrToStr(items[I].MJZJE)) + ',' + Quotedstr(CurrToStr
          (items[I].MSSJE)) + ',' + floattostr(items[I].IXMYH) + ',' + quotedstr
          ('') + ',' + quotedstr(items[I].CSFD) + ')';
        MJZJETmp := MJZJETmp + Items[I].MJZJE;
        AMZHYE := AMZHYE - items[I].MJZJE;
        if items[I].BTF then
        begin
          ASQL := ASQL + #13#10 + ' UPDATE ' + TBYKTNAME +
            ' SET BTF=1 WHERE CDJH=' + Quotedstr(items[I].CSFD) + ' and ISL>=0 ';
        end;
       { if not ExeSql(QRYTEMP,ASQL,True,functionname) then
        begin
          AERROR := '����һ��ͨ������ϸʧ�ܣ�'+Aerror;
          Exit;
        end;  }
      end;
      //if not SaveJZ(MJZJE) then Exit;
    end;
    CMoneyEncrypt := EncryptString(CurrToStrF(MJZJETmp + MJZJE, ffFixed, 3),
      'YX' + FCYLH); //������
    //��������
    ASQL := ASQL + #13#10 + 'update ' + SDBLX +
      '..TBICXX set MJZJE=IsNULL(MJZJE,0)+' + CurrToStr(MJZJETmp) + ',CMJZJM=' +
      QuotedStr(CMoneyEncrypt) + ' where CICID=' + QuotedStr(FCYLH);
    if ASQL <> '' then
    begin
      if not ExeSql(QryTemp, ASQL, True, FunctionName) then
      begin
        AERROR := '����һ��ͨ������ϸʧ�ܣ�' + AERROR;
        Exit;
      end;
    end;
  finally
    FreeAndNil(QryTemp);
  end;
  Result := True;
end;

function TYXSVR.DoPerForm(ILX, IBRLX: Integer; CBRH, CSQDH, CDBLX: string): Boolean;
const
  FunctionName = 'DoPerForm';
var
  CSQL, TmpCSQL: string;
  AMODE, CBH: string;
  CMBBH, CYZXXM0, CYZXXM1: string;
  CZTBMList, CBGDBHLIST: TStringList;
  I, j: integer;
  ISFZT, IZXZT: Integer;
  CSQDLIST: TStringList;
  SCMODE, SCSQD, CZTBM: string;
  BZXR, BQZ: Boolean;
  QRYTEMP, QRYTEMP1: TFDQuery;
begin
  Result := false;
  if CDBLX <> '' then
    SDBLX := SDBLX + CDBLX;
  try
    QRYTEMP := TFDQuery.Create(nil);
    QRYTEMP1 := TFDQuery.Create(nil);
    CSQDLIST := TStringList.Create;
    CSQDLIST.Delimiter := '|';
    CSQDLIST.DelimitedText := CSQDH;
    CZTBMList := TStringList.Create;
    CBGDBHLIST := TStringList.Create;
    if CSQDLIST.Count > 1 then
      CZTBM := '*';
    FBQYLYZ := GetUserParam('IYJKSZXBQYLYZ', '0') = '1';
    if Pos('|', CBRH) > 0 then
      FCBRH := COPY(CBRH, 1, Pos('|', CBRH) - 1)
    else
      FCBRH := CBRH;
    FIBRLX := IBRLX;
    SetTBInfo;
    CSQL := '';
    for j := 0 to CSQDLIST.Count - 1 do
    begin
      CBGDBHLIST.Clear;
      CBH := CSQDLIST[j];
      if Pos('=', CBH) > 0 then
      begin
        CZTBM := Copy(CBH, Pos('=', CBH) + 1, length(CBH) - Pos('=', CBH));
        CBH := Copy(CBH, 1, Pos('=', CBH) - 1);
        CZTBM := StringReplace(CZTBM, ',', '|', [rfReplaceAll, rfIgnoreCase]);
      end
      else if Pos('=', CBH) <= 0 then
      begin
        AERROR := '�봫����ȷ�����뵥����Σ�';
        Exit;
      end;
      GetMode(CBH, FCBH, FAmode);
      AMODE := FAmode;
      if SCMODE <> '' then
      begin
        if SCMODE <> AMODE then
        begin
          AERROR := '������뵥��������뵥������ͬʱ������';
          Exit;
        end;
      end;
      SCMODE := AMODE;
      if SCSQD <> '' then
      begin
        if Pos(FCBH, SCSQD) > 0 then
        begin
          AERROR := '��������뵥�������Ϸ���ͬһ�����У����뵥ֻ�ܳ���һ�Σ������Ŀ��ϲ�Ϊͬһ���뵥������Ŀ��';
          Exit;
        end;
      end;
      SCSQD := SCSQD + ',' + FCBH;
      FBSFKZ := GetUserParam('IYJKSSFKZ', '0') = '1';
      if not CheckSQD(QRYTEMP) then
        Exit;
      ISFZT := QRYTEMP.fieldbyname('ISFZT').Asinteger;
      CMBBH := QRYTEMP.fieldbyname('CMBBH').ASSTRING;
      IZXZT := QRYTEMP.fieldbyname('IZXZT').Asinteger;
      CBGDBHLIST.Delimiter := '|';
      CBGDBHLIST.DelimitedText := QRYTEMP.fieldbyname('CBGDBH').AsString;
      BQZ := True;
      if IBRLX = 1 then
        BQZ := QRYTEMP.fieldbyname('BQZ').AsBoolean;
      if (not FBSFKZ) or (IBRLX = 0) then
      begin
        if (ISFZT = 0) and (ILX = 1) then
        begin
          AERROR := '���뵥δ�շѣ���ִֹ�У�';
          Exit;
        end;
        if (ISFZT = 3) and (ILX = 1) then
        begin
          AERROR := '���뵥���˷ѣ���ִֹ�У�';
          Exit;
        end;
      end;
      if (IZXZT = 3) and (ILX = 1) then
      begin
        AERROR := '���뵥�ѽ��в�ִ�в�������ִֹ�У�';
        Exit;
      end;
      if (IZXZT = 4) and (ILX = 1) then
      begin
        AERROR := '���뵥ҽ����ȡ������ִֹ�У�';
        Exit;
      end;
      if CSQDLIST.Count > 1 then
      begin
        if (IZXZT = 1) and (ILX = 1) then
        begin
          AERROR := '���뵥��ִ�У������˴�ִ�У�';
          Continue;
        end;
        if (IZXZT = 0) and (ILX = 0) then
        begin
          AERROR := '���뵥δִ�У������˴�ȡ����';
          Continue;
        end;
      end;
      if (IZXZT = 1) and (ILX = 1) then
      begin
        AERROR := '���뵥��ִ�У���ֹ�ظ�ִ�У�';
        Result := True;
        Exit;
      end;
      if (IZXZT = 0) and (ILX = 0) then
      begin
        AERROR := '���뵥δִ�У���ֹ�ظ�ȡ����';
        Result := True;
        Exit;
      end;
      if not BQZ then
      begin
        AERROR := '���뵥�ѳ�������ִֹ�У�';
        Exit;
      end;
      if CZTBM = '' then
      begin
        AERROR := 'δ��������Ŀ�����飡';
        Exit;
      end;
      if (CZTBM = '*') then
      begin
        TmpCSQL := 'SELECT CINNERID,cztbm,cstatus,csfxmbm FROM ' + TBXMWZX +
          ' with(nolock) where cbh=' + quotedstr(FCBH);
        if not ExeSql(QRYTEMP, TmpCSQL, False) then
          Exit;
        if QRYTEMP.IsEmpty then
        begin
          AERROR := 'δ�ҵ���Ӧ���뵥��Ŀ���ݣ�' + TmpCSQL;
          Exit;
        end;
        QRYTEMP.First;
        for I := 0 to QRYTEMP.RecordCount - 1 do
        begin
          if ILX = 0 then
          begin
            if CBGDBHLIST.Values[QRYTEMP.FieldByName('CINNERID').asstring] <> '' then
            begin
              AERROR := '��ǰ���뵥��Ŀ[' + QRYTEMP.FieldByName('CINNERID').asstring +
                ']���б��棡����ȡ�����棡';
              Exit;
            end;
          end;
          if ILX = 1 then
          begin
            if (QRYTEMP.fieldbyname('ISTATUS').asinteger <> 2) then
            begin
              AERROR := '��ǰ���뵥��Ŀ[' + QRYTEMP.fieldbyname('CZTBM').ASSTRING + ':'
                + QRYTEMP.fieldbyname('CSFXMBM').ASSTRING + ']δ�շѣ���ִֹ�У�';
              Exit;
            end;
          end;
          QRYTEMP.Next;
        end;
        if ILX = 1 then
          CSQL := CSQL + #13#10 + ' UPDATE ' + TBXXWZX +
            ' SET IZXZT = 1 , CYZXXM=REPLACE(CYZXXM,'':0'','':1''),CZXR=' +
            Quotedstr(FCZYMC) + ',CZXRBM=' + Quotedstr(FCZYGH) +
            ',DZXRQ=GetDate()  WHERE CBH=' + quotedstr(FCBH) + ' and cbrh=' +
            quotedstr(FCBRH)
        else if ILX = 0 then
          CSQL := CSQL + #13#10 + ' UPDATE ' + TBXXWZX +
            ' SET IZXZT = 0 , CYZXXM=REPLACE(CYZXXM,'':1'','':0'')  WHERE CBH=' +
            quotedstr(FCBH) + ' and cbrh=' + quotedstr(FCBRH);
        if (FBQYLYZ) and (IBRLX = 1) then
          CSQL := CSQL + #13#10 + ' UPDATE ' + TBYZYJWZX + ' SET IZXZT=' +
            inttostr(ILX) + ',DZX=' + iif(ILX = 1, 'GetDate() ', '''''') +
            ' where CYZH=' + QuotedStr('SQ' + FCBH);
      end
      else
      begin
        CZTBMList.Delimiter := '|';
        CZTBMList.DelimitedText := CZTBM;
        for I := 0 to CZTBMList.Count - 1 do
        begin
          TmpCSQL := 'SELECT distinct CINNERID FROM ' + TBXMWZX +
            ' WITH(NOLOCK) where cbh=' + quotedstr(FCBH) + ' and CZTBM=' +
            quotedstr(CZTBMList[I]);
          if not ExeSql(QRYTEMP1, TmpCSQL, False) then
            Exit;
          if QRYTEMP1.IsEmpty then
          begin
            AERROR := '���뵥δ�ҵ���Ӧ�ļ����Ŀ:' + CZTBMList[I] + ',CSQL=' + TmpCSQL;
            Exit;
          end;
          TmpCSQL := 'SELECT CINNERID,CBGDMBBH FROM ' + SDBLX +
            '..TBXMFMBMX WITH(NOLOCK) WHERE CMBBH=' + Quotedstr(CMBBH) +
            ' AND CELEBM=''SQD.26'' AND CSFXMBM=' + QUOTEDSTR(CZTBMList[I]) +
            ' AND CINNERID=' + Quotedstr(QRYTEMP1.fieldbyname('CINNERID').ASSTRING);
          if not ExeSql(QRYTEMP1, TmpCSQL, False) then
            Exit;
          if QRYTEMP1.IsEmpty then
          begin
            AERROR := '���뵥δ�ҵ���Ӧ�ļ����Ŀ:' + CZTBMList[I] + ',CSQL=' + TmpCSQL;
            Exit;
          end;
          CYZXXM0 := QRYTEMP1.fieldbyname('CINNERID').ASSTRING + '=' + QRYTEMP1.fieldbyname
            ('CBGDMBBH').ASSTRING + ':0';
          CYZXXM1 := QRYTEMP1.fieldbyname('CINNERID').ASSTRING + '=' + QRYTEMP1.fieldbyname
            ('CBGDMBBH').ASSTRING + ':1';
          TmpCSQL := 'SELECT  CINNERID,ISTATUS FROM ' + TBXMWZX +
            ' WITH(NOLOCK) where cbh=' + quotedstr(FCBH) + ' and CINNERID=' +
            quotedstr(QRYTEMP1.fieldbyname('CINNERID').ASSTRING);
          if not ExeSql(QRYTEMP, TmpCSQL, False) then
            Exit;
          if QRYTEMP.IsEmpty then
          begin
            AERROR := 'δ�ҵ���Ӧ���뵥��Ŀ���ݣ�' + TmpCSQL;
            Exit;
          end;
          if ILX = 0 then
          begin
            if CBGDBHLIST.Values[QRYTEMP.FieldByName('CINNERID').asstring] <> '' then
            begin
              AERROR := '��ǰ���뵥��Ŀ[' + QRYTEMP.FieldByName('CINNERID').asstring +
                ']���б��棡����ȡ�����棡';
              Exit;
            end;
          end;
          if ILX = 1 then
          begin
            if (not FBSFKZ) and (QRYTEMP.fieldbyname('ISTATUS').asinteger <> 2) then
            begin
              AERROR := '��ǰ�����Ŀ[' + CZTBMList[I] + ']δ�շѣ���ִֹ�У�,CSQL=' + TmpCSQL;
              Exit;
            end;
          end;
          if ILX = 1 then
            CSQL := CSQL + #13#10 + ' UPDATE ' + TBXXWZX +
              ' SET IZXZT = 2 , CYZXXM=REPLACE(CYZXXM,' + Quotedstr(CYZXXM0) +
              ',' + Quotedstr(CYZXXM1) + ')  WHERE CBH=' + quotedstr(FCBH) +
              ' and cbrh=' + quotedstr(CBRH)
          else if ILX = 0 then
            CSQL := CSQL + #13#10 + ' UPDATE ' + TBXXWZX +
              ' SET IZXZT = 2 , CYZXXM=REPLACE(CYZXXM,' + Quotedstr(CYZXXM1) +
              ',' + Quotedstr(CYZXXM0) + ')  WHERE CBH=' + quotedstr(FCBH) +
              ' and cbrh=' + quotedstr(CBRH);
          if (FBQYLYZ) and (IBRLX = 1) then
            CSQL := CSQL + #13#10 + ' UPDATE ' + TBYZYJWZX +
              ' SET IZXZT = 2,DZX=' + iif(ILX = 1, 'GetDate() ', '''''') +
              ' where CYZH=' + QuotedStr('SQ' + FCBH);
        end;
      end;
    end;
    try
      BZXR := False;
      if not ExeSql(QRYTEMP, 'SELECT TOP 1 * FROM ' + TBXXWZX, False) then
        exit;
      if (QRYTEMP.FindField('CZXR') <> nil) and (QRYTEMP.FindField('CZXRBM') <>
        nil) and (QRYTEMP.FindField('DZXRQ') <> nil) then
        BZXR := True;
      if (FBQYLYZ) and (IBRLX = 1) then
      begin
        if not ExeSql(QRYTEMP, 'SELECT TOP 1 * FROM ' + TBYZYJWZX, False) then
          exit;
        if (BZXR) and (QRYTEMP.FindField('CZXR') <> nil) and (QRYTEMP.FindField('CZXRBM')
          <> nil) and (QRYTEMP.FindField('DZXRQ') <> nil) then
          BZXR := True
        else
          BZXR := False;
      end;
      if InTransaction(2) then
        Rollback(2);
      StartTransaction(2);
      if not ExeSql(QRYTEMP, CSQL, True) then
      begin
        AERROR := '���뵥ִ��ʧ��:' + AERROR;
        Exit;
      end;
      for j := 0 to CSQDLIST.Count - 1 do
      begin
        CBH := CSQDLIST[j];
        if Pos('=', CBH) > 0 then
        begin
          CBH := Copy(CBH, 1, Pos('=', CBH) - 1);
          GetMode(CBH, FCBH, AMODE);
        end;
        CSQL := 'SELECT CYZXXM FROM ' + TBXXWZX + ' WHERE CBH=' + quotedstr(FCBH)
          + ' and cbrh=' + quotedstr(FCBRH);
        if not ExeSql(QRYTEMP, CSQL, False) then
          EXIT;
        CSQL := '';
        if not QRYTEMP.IsEmpty then
        begin
          if ILX = 1 then
          begin
            if Pos(':0', QRYTEMP.fieldbyname('CYZXXM').ASSTRING) <= 0 then
              CSQL := 'UPDATE ' + TBXXWZX + ' SET IZXZT = 1 WHERE CBH=' +
                quotedstr(FCBH) + ' and cbrh=' + quotedstr(FCBRH);
          end
          else if ILX = 0 then
          begin
            if Pos(':1', QRYTEMP.fieldbyname('CYZXXM').ASSTRING) <= 0 then
              CSQL := 'UPDATE ' + TBXXWZX + ' SET IZXZT = 0 WHERE CBH=' +
                quotedstr(FCBH) + ' and cbrh=' + quotedstr(FCBRH);
          end;
          if (FBQYLYZ) and (IBRLX = 1) then
            CSQL := CSQL + #13#10 + ' UPDATE ' + TBYZYJWZX + ' SET IZXZT=' +
              inttostr(ILX) + ',DZX=' + iif(ILX = 1, 'GetDate() ', '''''') +
              ' where CYZH=' + QuotedStr('SQ' + CBH);
          if BZXR then
          begin
            CSQL := CSQL + #13#10 + 'UPDATE ' + TBXXWZX + ' SET CZXR=' +
              Quotedstr(FCZYMC) + ',CZXRBM=' + Quotedstr(FCZYGH) +
              ',DZXRQ=GetDate() ' + 'WHERE CBH=' + quotedstr(FCBH) +
              ' and cbrh=' + quotedstr(FCBRH);
            if (FBQYLYZ) and (IBRLX = 1) then
              CSQL := CSQL + #13#10 + ' update ' + TBYZYJWZX + ' set CZXR=' +
                QuotedStr(FCZYMC) + ',CZXRBM=' + QuotedStr(FCZYGH) +
                ',DZXRQ=GetDate() ' + ' where CYZH=' + QuotedStr('SQ' + FCBH);
          end;
          if not ExeSql(QRYTEMP, CSQL, True) then
            Exit;
        end;
      end;
      Commit(2);
    except
      if InTransaction(2) then
        Rollback(2);
      Exit;
    end;
  finally
    FreeAndNil(QRYTEMP);
    FreeAndNil(QRYTEMP1);
    FreeAndNil(CZTBMList);
    FreeAndNil(CSQDLIST);
    FreeAndNil(CBGDBHLIST);
  end;
  Result := True;
end;

function TYXSVR.WriteReport(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, XMLDATA,
  CDBLX: string): Boolean;
  //����ͼƬ��base64���봮�����ݿ���

  function SaveImage(Invalue: string; out ID: string): Boolean;
  var
    AQry: TFDQuery;
    TBNAME: string;
    CID: string;
    MS: TMemoryStream;
    SS: TStringStream;
  begin
    Result := False;
    ID := '';
    CID := GetSysNumber2('IMAGE', 1, '0');
    if not CheckDataBase then
      Exit;
    MS := nil;
    SS := nil;
    try
      MS := TMemoryStream.Create;
      SS := TStringStream.Create(Invalue);
    except
      on e: Exception do
      begin
        AERROR := 'ͼƬ�����������������飡' + e.Message;
        Exit;
      end;
    end;
    AQry := TFDQuery.Create(nil);
    try
      TBNAME := GetTBName('tbbltpxx+');
      if TBNAME = '' then
        Exit;
      AQry.Connection := DATABASE;
      DecodeStream(SS, MS);
      MS.Position := 0;
      with AQry do
      begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ' + TBNAME + ' (ID,DATA) VALUES (:ID,:DATA)');
        Params.ParamValues['ID'] := CID;
        Params.ParamByName('DATA').LoadFromStream(MS, ftBlob, 0);
        try
          ExecSql;
        except
          on E: Exception do
          begin
            CLOSE;
            AERROR := '������Ϣ:' + E.Message + #13#10 + ' SQL:' + SQL.Text;
            Exit;
          end;
        end;
      end;

    finally
      ID := CID;
      FreeAndNil(MS);
      FreeAndNil(SS);
      FreeAndNil(AQry);
    end;
    Result := True;
  end;

const
  FunctionName = 'WriteReport';
var
  SqdXML, BgdXML: IXMLDOMDocument2;
  CSQLXM, CSQLZT, StrSQL, mxsql: string;
  MainSQL: string;
  CSQDXML, CDATA2, CDATA1, SID, CINNERID, CBGJBH: string;
  IBGZT, IZXZT, ISFZT, i, j, k: Integer;
  CBGDBH, CXGBGDH, CYZXBGD, CBGMBBH: string;
  CBGMBList, CZTBMList, CINNERIDList, CYZXBGDList, CYCBGMBBHList: TStringList;
  SqdNode, BgdNode, RNode: IXMLDOMNode;
  BGBGList: IXMLDOMNodeList;
  TBYZYJWGD: string;
  BBG: Boolean;
  CBBG, XMLNR, S: string;
  COLXH, COLXM, COLXMZ, CROWBH: string;
  IBGKZ: Integer; //������ƣ�0��Ĭ�ϲ����޸ģ���Ҫ��ȡ���ٳ����棻1��ֱ�Ӹ�����һ�α��棬
  QryZT: TFDQuery;
  QRYTEMP, QRYTEMP1: TFDQuery;
begin
  Result := false;
  if CDBLX <> '' then
    SDBLX := SDBLX + CDBLX;
  try
    CBGMBList := TStringList.Create;
    CZTBMList := TStringList.Create;
    CINNERIDList := TStringList.Create;
    CYZXBGDList := TStringList.Create;
    CYCBGMBBHList := TStringList.Create;
    SqdXML := CoDOMDocument.Create;
    BgdXML := CoDOMDocument.Create;
    QRYTEMP := TFDQuery.Create(nil);
    QRYTEMP1 := TFDQuery.Create(nil);
    if CZTBM = '' then
    begin
      AERROR := 'δ��������Ŀ�����飡';
      Exit;
    end;
    if CSQDH = '' then
    begin
      AERROR := 'δ�������뵥�ţ����飡';
      Exit;
    end;
    CZTBM := StringReplace(CZTBM, ',', '|', [rfReplaceAll, rfIgnoreCase]);
    if not ILX in [0, 1] then
    begin
      AERROR := '�������ʹ������飡';
      exit;
    end;
    if not IBRLX in [0, 1] then
    begin
      AERROR := '���벡�����ʹ������飡';
      exit;
    end;
    FBQYLYZ := GetUserParam('IYJKSZXBQYLYZ', '0') = '1';
    FBSFKZ := GetUserParam('IYJKSSFKZ', '0') = '1';
    FBZXKZ := GetUserParam('IYJKSZXBGKZ', '0') = '1';
    IBGKZ := Getuserparam('YJJKXGBGKZ', 0);
    GetMode(CSQDH, FCBH, FAmode);
    FIBRLX := IBRLX;
    FCBRH := CBRH;
    SetTBInfo;
    if not CheckSQD(QRYTEMP) then
      exit;
    CSQLXM := '';
    CSQLXM := 'select * from ' + TBXMWZX + '  with(nolock) where CBH=' + quotedstr(FCBH);
    CSQLXM := CSQLXM + #13#10 + 'union all' + #13#10 + 'select * from ' +
      TBXMWGD + '  with(nolock) where CBH=' + quotedstr(FCBH);
    CBGMBList.Delimiter := '|';
    CZTBMList.Delimiter := '|';
    CYZXBGDList.Delimiter := '|';
    CYCBGMBBHList.Delimiter := '|';
    CBGMBList.DelimitedText := QRYTEMP.fieldbyname('CYZXXM').asstring;
    CZTBMList.DelimitedText := CZTBM;
    CYZXBGDList.DelimitedText := QRYTEMP.fieldbyname('CBGDBH').asstring;
    IZXZT := QRYTEMP.fieldbyname('IZXZT').ASINTEGER;
    IBGZT := QRYTEMP.fieldbyname('IBGZT').ASINTEGER;
    ISFZT := QRYTEMP.fieldbyname('ISFZT').ASINTEGER;
    CSQDXML := QRYTEMP.fieldbyname('XMLNR').asstring;
    if (FBQYLYZ) and (IBRLX = 1) then
      TBYZYJWGD := GetTBName('TBZYYZYJXX', CBRH, 4, QRYTEMP.fieldbyname('DQZ').AsDateTime);
    if (not FBSFKZ) or (IBRLX = 0) then
    begin
      if (ILX = 1) and (ISFZT = 0) then
      begin
        AERROR := '���뵥δ�շѣ���ֹ���棡';
        exit;
      end;
    end;
    if not FBZXKZ then   //ҽ���������  0Ĭ��Ҫִ�� 1 ��ִ�п���ֱ�ӳ�����
    begin
      if (ILX = 1) and (IZXZT = 0) then
      begin
        AERROR := '���뵥δִ�У���ֹ���棡';
        Exit;
      end;
    end;
    if CZTBM = '*' then
    begin
      CSQLZT := 'SELECT DISTINCT CINNERID FROM (' + CSQLXM + ') A ';
      if not ExeSql(QRYTEMP1, CSQLZT, False, FunctionName) then
        Exit;
      if QRYTEMP1.IsEmpty then
      begin
        AERROR := '���뵥��δ�ҵ���ǰ�����Ŀ�����飡SQL=' + CSQLZT;
        Exit;
      end;
      QRYTEMP1.First;
      while not QRYTEMP1.eof do
      begin
        CINNERIDList.Add(QRYTEMP1.fieldbyname('CINNERID').asstring);
        QRYTEMP1.Next;
      end;
    end
    else
    begin
      for i := 0 to CZTBMList.Count - 1 do
      begin
        CSQLZT := 'SELECT DISTINCT CINNERID FROM (' + CSQLXM +
          ') A WHERE CZTBM=' + quotedstr(CZTBMList[i]);
        if not ExeSql(QRYTEMP1, CSQLZT, False, FunctionName) then
          Exit;
        if QRYTEMP1.IsEmpty then
        begin
          AERROR := '���뵥��δ�ҵ���ǰ�����Ŀ[' + CZTBMList[i] + ']�����飡SQL=' + CSQLZT;
          Exit;
        end;
        CINNERIDList.Add(QRYTEMP1.fieldbyname('CINNERID').asstring);
      end;
    end;
    if (IBGZT = 1) and (ILX = 1) then
    begin
      if IBGKZ = 0 then
      begin
        AERROR := '�����뵥�Ѿ��б��棡����ȡ�����棡';
        Exit;
      end
      else if IBGKZ = 1 then //���Ǳ�������������Ȱ�����ת����Ϣ������������ж��Ƿ�ת��
      begin
        MainSQL := MainSQL + #13#10 + ' insert into ' + tbxxWZX +
          ' select * from ' + tbxxWGD + ' where CBH =' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' delete from ' + tbxxWGD +
          ' where cbh = ' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' insert into ' + tbmxWZX +
          ' select * from ' + tbmxWGD + ' where CBH =' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' delete from ' + tbmxWGD +
          ' where cbh = ' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' insert into ' + tbxmWZX +
          ' select * from ' + tbxmWGD + ' where CBH =' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' delete from ' + tbxmWGD +
          ' where cbh = ' + quotedstr(FCBH);
        if (FBQYLYZ) and (IBRLX = 1) then
        begin
          MainSQL := MainSQL + #13#10 + ' insert into ' + TBYZYJWZX +
            ' select * from ' + TBYZYJWGD + ' where CYZH =' + quotedstr('SQ' + FCBH);
          MainSQL := MainSQL + #13#10 + ' delete from ' + TBYZYJWGD +
            ' where CYZH = ' + quotedstr('SQ' + FCBH);
        end;
      end;
    end;
    if (IBGZT = 0) and (ILX = 0) then
    begin
      AERROR := '�����뵥û���κα��浥��Ϣ�����ȳ����棡';
      Exit;
    end;
    if (ILX = 1) then
    begin
      if CSQDXML <> '' then
      begin
        if not LoadXMLText(SqdXML, CSQDXML) then
          Exit;
        SqdNode := SqdXML.selectSingleNode('SQD');
        if SqdNode = nil then
          SqdXML := nil;
      end;
      if not LoadXMLText(BgdXML, XMLDATA) then
        Exit;
      XMLNR := XMLDATA;
      if Pos('?>', XMLDATA) > 0 then
      begin
        S := Copy(XMLDATA, 1, Pos('?>', XMLDATA) + 1);
        XMLNR := Copy(XMLDATA, Length(S) + 1, Length(XMLDATA) - Length(S));
      end;
      BgdNode := BgdXML.selectSingleNode('MSG/BGD');
      if BgdNode = nil then
      begin
        AERROR := '�ޱ��浥XML���ݣ����飡';
        Exit;
      end;
      for i := 0 to CINNERIDList.Count - 1 do
      begin
        CXGBGDH := CYZXBGDList.Values[CINNERIDList[i]];
        CBGMBBH := CBGMBList.Values[CINNERIDList[i]];
        if not FBZXKZ then
        begin
          if Pos(':0', CBGMBBH) > 0 then
          begin
            AERROR := '��Ŀ[' + CINNERIDList[i] + ']δִ�У���ֹ���棡';
            Exit;
          end;
        end;
        CBGMBBH := Copy(CBGMBBH, 1, Pos(':', CBGMBBH) - 1);
        //�����ͬһ��ģ�壬����һ�ű��浥�ϱ�
        if Pos(CBGMBBH + '=', CYCBGMBBHList.Text) > 0 then
        begin
          MainSQL := MainSQL + #13#10 + 'UPDATE ' + TBXXWZX +
            ' SET CBGDBH=REPLACE(CBGDBH,' + Quotedstr(CINNERIDList[i] + '=' +
            CXGBGDH + '|') + ',' + Quotedstr(CINNERIDList[i] + '=' +
            CYCBGMBBHList.Values[CBGMBBH] + '|') + ') ' + ' WHERE CBH=' + Quotedstr(FCBH);
          Continue;
        end;
        if CXGBGDH = '' then
          CBGDBH := GetSysNumber2('0028', 1, '00')
        else if CXGBGDH <> '' then
        begin
          if CXGBGDH = 'BG' then //��ʿվ����������BG��� ,��������Ŀ
            continue;
          if IBGKZ = 0 then
          begin
            AERROR := '��Ŀ[' + CINNERIDList[i] + ']�Ѿ��б���[' + CXGBGDH + ']������ȡ����';
            Exit;
          end;
          CBGDBH := CXGBGDH;
          MainSQL := MainSQL + #13#10 + 'delete ' + TBBGMX + ' where cbh=' +
            quotedstr(CXGBGDH);
          MainSQL := MainSQL + #13#10 + 'delete ' + TBBGXX + ' where cbh=' +
            quotedstr(CXGBGDH);
        end;
        CYCBGMBBHList.Add(CBGMBBH + '=' + CBGDBH);
        mxsql := 'select CELEBM,CINNERID from ' + SDBLX +
          '..TBXMFMBMX with (nolock) where cmbbh=' + quotedstr(CBGMBBH) +
          ' and (cmrz<>'''' or cjsbt<>'''' or ixmlx=9)';
        if not ExeSql(QRYTEMP1, mxsql, False, FunctionName) then
          Exit;
        MainSQL := MainSQL + #13#10 + 'Insert Into ' + TBBGXX +
          ' (CBH,CMBBH,CMBMC,CBRH,CBRID,CBRXM,CBRXB,CBRNL,CSQBH,DSJSJ,';
        if IBRLX = 0 then
          MainSQL := MainSQL + 'DSQSJ,';
        MainSQL := MainSQL +
          ' CZXDWBM,CZXDWMC,DJLRQ,CJLRBM,CJLRMC,DSHRQ,CSHRBM,' + 'CSHRMC,ISTATUS,CSTXX1,CSTXX2,CSTXX3,CSTXX4,CSTXX5,XMLNR) Values('
          + quotedstr(CBGDBH) + ',' + quotedstr(CBGMBBH) + ','''',' + quotedstr(CBRH)
          + ',' + quotedstr(QRYTEMP.FieldByName('cbrid').AsString) + ',' +
          quotedstr(QRYTEMP.FieldByName('cbrxm').AsString) + ',' + quotedstr(QRYTEMP.FieldByName
          ('cbrxb').AsString) + ',' + quotedstr(QRYTEMP.FieldByName('cbrnl').AsString)
          + ',' + quotedstr(QRYTEMP.FieldByName('CBH').AsString) + ',' +
          quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', rdata)) + ',';
        if IBRLX = 0 then
          MainSQL := MainSQL + quotedstr(QRYTEMP.FieldByName('DSJSJ').AsString) + ',';
        MainSQL := MainSQL + ''''','''',' + quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS',
          rdata)) + ',' + quotedstr(QRYTEMP.FieldByName('CJLRBM').AsString) +
          ',' + quotedstr(QRYTEMP.FieldByName('CJLRMC').AsString) + ',' +
          quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS', rdata)) + ',' +
          quotedstr(QRYTEMP.FieldByName('CJLRBM').AsString) + ',' + quotedstr(QRYTEMP.FieldByName
          ('CJLRMC').AsString) + ',1,'''','''','''','''','''',' + quotedstr(XMLNR) + ') ';
        QRYTEMP1.First;
        CBGJBH := GetSysNumber2('0049', 1, '00');
        for j := 0 to QRYTEMP1.RecordCount - 1 do
        begin
          CDATA2 := '';
          CDATA1 := '';
          if Pos('NUL', QRYTEMP1.FieldByName('celebm').AsString) <= 0 then
          begin
            if QRYTEMP1.FieldByName('celebm').AsString = 'BGD.30' then
            begin
              CDATA1 := 'GRID';
              CDATA2 := CBGJBH;
              CINNERID := QRYTEMP1.FieldByName('CINNERID').AsString;
            end
            else if (QRYTEMP1.FieldByName('celebm').AsString = 'BGD.20') or (QRYTEMP1.FieldByName
              ('celebm').AsString = 'BGD.21') or (QRYTEMP1.FieldByName('celebm').AsString
              = 'BGD.22') or (QRYTEMP1.FieldByName('celebm').AsString = 'BGD.23')
              or (QRYTEMP1.FieldByName('celebm').AsString = 'BGD.24') then
            begin
              if BgdNode.selectSingleNode(QRYTEMP1.FieldByName('celebm').AsString)
                <> nil then
              begin
                CDATA2 := VarToStrDef(BgdNode.selectSingleNode(QRYTEMP1.FieldByName
                  ('celebm').AsString).text, '');
                if CDATA2 <> '' then
                begin
                  if not SaveImage(CDATA2, SID) then
                    Exit;
                  CDATA2 := SID;
                end;
              end;
            end
            else if (SqdNode <> nil) and (SqdNode.selectSingleNode(copy(QRYTEMP1.FieldByName
              ('celebm').AsString, 1, 3) + '/' + QRYTEMP1.FieldByName('celebm').AsString)
              <> nil) then
              CDATA2 := VarToStrDef(SqdNode.selectSingleNode(copy(QRYTEMP1.FieldByName
                ('celebm').AsString, 1, 3) + '/' + QRYTEMP1.FieldByName('celebm').AsString).text,
                '')
            else if BgdNode.selectSingleNode(QRYTEMP1.FieldByName('celebm').AsString)
              <> nil then
              CDATA2 := VarToStrDef(BgdNode.selectSingleNode(QRYTEMP1.FieldByName
                ('celebm').AsString).text, '')
            else if BgdNode.selectSingleNode(copy(QRYTEMP1.FieldByName('celebm').AsString,
              1, 3) + '/' + QRYTEMP1.FieldByName('celebm').AsString) <> nil then
              CDATA2 := VarToStrDef(BgdNode.selectSingleNode(copy(QRYTEMP1.FieldByName
                ('celebm').AsString, 1, 3) + '/' + QRYTEMP1.FieldByName('celebm').AsString).text,
                '')
          end;
          MainSQL := MainSQL + #13#10 + 'Insert Into ' + tbbgmx +
            ' (CBH,CINNERID,CXMBM,CDATA1,CDATA2) Values(' + quotedstr(CBGDBH) +
            ',' + quotedstr(QRYTEMP1.FieldByName('CINNERID').AsString) + ',' +
            quotedstr(QRYTEMP1.FieldByName('celebm').AsString) + ',' + quotedstr
            (CDATA1) + ',' + quotedstr(CDATA2) + ')';
          QRYTEMP1.Next;
        end;
        if CINNERID <> '' then
        begin
          StrSQL := '';
          mxsql := 'SELECT CXMBM,IDTXH FROM ' + SDBLX +
            '..TBTABLEMBMX  with(nolock) WHERE CINNERID=' + quotedstr(CINNERID)
            + ' AND cmbbh=' + quotedstr(CBGMBBH) + ' ORDER BY ICOL_SN ASC ';
          if not ExeSql(QRYTEMP1, mxsql, False, FunctionName) then
            Exit;
          if not QRYTEMP1.IsEmpty then
          begin
            BGBGList := BgdXML.documentElement.selectNodes('BGD/BGD.30/BGD.30');
            RNode := GetFirstEle(BGBGList);
            k := 1;
            while RNode <> nil do
            begin
              QRYTEMP1.First;
              COLXM := '';
              COLXH := '';
              COLXMZ := '';
              for j := 0 to QRYTEMP1.RecordCount - 1 do
              begin
                if QRYTEMP1.FieldByName('CXMBM').AsString = 'BGD.31' then
                  COLXM := QuotedStr(IntToStr(k))
                else
                begin
                  if RNode.selectSingleNode(QRYTEMP1.FieldByName('CXMBM').AsString)
                    <> nil then
                    COLXM := QuotedStr(RNode.selectSingleNode(QRYTEMP1.FieldByName
                      ('CXMBM').AsString).text)
                  else
                    COLXM := QuotedStr('');
                end;
                COLXH := IIF(COLXH = '', 'CVALCOL' + QRYTEMP1.FieldByName('IDTXH').AsString,
                  COLXH + ',' + 'CVALCOL' + QRYTEMP1.FieldByName('IDTXH').AsString);
                COLXMZ := IIF(COLXMZ = '', COLXM, COLXMZ + ',' + COLXM);
                QRYTEMP1.Next;
              end;
              CROWBH := GetSysNumber2('0049', 1, '00');
              MainSQL := MainSQL + #13#10 + 'INSERT INTO ' + TBBGBGMX +
                ' (CDATA2,CROWBH,' + COLXH + ',DSJ,ISTATUS,ITSTYPE,CBH) VALUES'
                + '(' + QUOTEDSTR(CBGJBH) + ',' + QUOTEDSTR(CROWBH) + ',' +
                COLXMZ + ',' + quotedstr(FormatDateTime('YYYY-MM-DD HH:NN:SS',
                rdata)) + ',0,0,' + quotedstr(CBGDBH) + ')';
              k := k + 1;
              RNode := GetNextEle(BGBGList);
            end;
          end;
        end;
        CYZXBGD := CINNERIDList[i] + '=' + CBGDBH + '|';
        MainSQL := MainSQL + #13#10 + ' update ' + tbxxWZX +
          ' set CBGDBH=replace(CBGDBH,' + quotedstr(CINNERIDList[i] + '=|') +
          ',' + quotedstr(CYZXBGD) + ') where CBH=' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' update ' + tbxxWZX +
          ' set IBGZT=2  where CBH=' + quotedstr(fCBH);
        if IBRLX = 1 then
        begin
          if (FBQYLYZ) then
          begin
            MainSQL := MainSQL + #13#10 + 'update ' + TBYZYJWZX +
              ' set IBGZT=2  where CYZH=' + QuotedStr('SQ' + fCBH);
          end;
          if TBYZBYZYLBQ <> '' then
            MainSQL := MainSQL + #13#10 + 'UPDATE ' + TBYZBYZYLBQ +
              ' SET IFYZT=6' + ' WHERE CZYH=' + Quotedstr(FCBRH) +
              ' AND CSQDBH=' + Quotedstr(FCBH);
        end;
      end;
    end
    else if ILX = 0 then
    begin
      StrSQL := '';
      CYZXBGD := '';
      if IBGZT = 1 then
      begin
        MainSQL := MainSQL + #13#10 + ' insert into ' + tbxxWZX +
          ' select * from ' + tbxxWGD + ' where CBH =' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' delete from ' + tbxxWGD +
          ' where cbh = ' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' insert into ' + tbmxWZX +
          ' select * from ' + tbmxWGD + ' where CBH =' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' delete from ' + tbmxWGD +
          ' where cbh = ' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' insert into ' + tbxmWZX +
          ' select * from ' + tbxmWGD + ' where CBH =' + quotedstr(FCBH);
        MainSQL := MainSQL + #13#10 + ' delete from ' + tbxmWGD +
          ' where cbh = ' + quotedstr(FCBH);
        if (FBQYLYZ) and (IBRLX = 1) then
        begin
          MainSQL := MainSQL + #13#10 + ' insert into ' + TBYZYJWZX +
            ' select * from ' + TBYZYJWGD + ' where CYZH =' + quotedstr('SQ' + FCBH);
          MainSQL := MainSQL + #13#10 + ' delete from ' + TBYZYJWGD +
            ' where CYZH = ' + quotedstr('SQ' + FCBH);
        end;
      end;
      for i := 0 to CINNERIDList.Count - 1 do
      begin
        MainSQL := MainSQL + #13#10 + ' update ' + tbxxWZX +
          ' set CBGDBH=replace(CBGDBH,' + quotedstr(CINNERIDList[i] + '=' +
          CYZXBGDList.Values[CINNERIDList[i]] + '|') + ',' + Quotedstr(CINNERIDList
          [i] + '=|') + '),IBGZT=2 where CBH=' + quotedstr(FCBH);
        if (IBRLX = 1) then
        begin
          if (FBQYLYZ) then
            MainSQL := MainSQL + #13#10 + 'update ' + TBYZYJWZX +
              ' set IBGZT=2  where CYZH=' + QuotedStr('SQ' + FCBH);
          if TBYZBYZYLBQ <> '' then
            MainSQL := MainSQL + #13#10 + 'UPDATE ' + TBYZBYZYLBQ +
              ' SET IFYZT=6' + ' WHERE CZYH=' + Quotedstr(FCBRH) +
              ' AND CSQDBH=' + Quotedstr(FCBH);
        end;
      end;
    end;
    StrSQL := '';
    if InTransaction(2) then
      Rollback(2);
    StartTransaction(2);
    try
      if not ExeSql(QRYTEMP, MainSQL, True, FunctionName) then
      begin
        if Pos('Э��������ȷ', AERROR) > 0 then
        begin
          Sleep(1000);
          if not ExeSql(QRYTEMP, MainSQL, True, FunctionName) then
          begin
            AERROR := '���浥���ݶ����ύʧ��:' + AERROR;
            Exit;
          end;
        end
        else
        begin
          AERROR := '���浥���ݱ���ʧ��:' + AERROR;
          Exit;
        end;
      end;
      BBG := False;
      MainSQL := '';
      if not ExeSql(QRYTEMP1, 'Select CBGDBH from ' + tbxxWZX +
        ' with(nolock) where cbh=' + quotedstr(FCBH), false) then
        exit;
      if ILX = 1 then
      begin
        BBG := Pos('=|', QRYTEMP1.fieldbyname('CBGDBH').AsString) <= 0;
        if BBG then
        begin
          MainSQL := MainSQL + #13#10 + ' update ' + tbxxWZX +
            ' set IBGZT=1  where CBH=' + quotedstr(FCBH);
          MainSQL := MainSQL + #13#10 + ' insert into ' + tbmxWGD +
            ' select * from ' + tbmxWZX + ' where CBH=' + quotedstr(FCBH);
          MainSQL := MainSQL + #13#10 + ' delete from ' + tbmxWZX +
            ' Where CBH=' + quotedstr(FCBH);
          MainSQL := MainSQL + #13#10 + ' insert into ' + tbxxWGD +
            ' select * from ' + tbxxWZX + ' where CBH=' + quotedstr(FCBH);
          MainSQL := MainSQL + #13#10 + ' delete from ' + tbxxWZX +
            ' Where CBH=' + quotedstr(FCBH);
          MainSQL := MainSQL + #13#10 + ' insert into ' + tbxmWGD +
            ' select * from ' + tbxmWZX + ' where CBH=' + quotedstr(FCBH);
          MainSQL := MainSQL + #13#10 + ' delete from ' + tbxmWZX +
            ' Where CBH=' + quotedstr(FCBH);
          if (IBRLX = 1) then
          begin
            if (FBQYLYZ) then
            begin
              MainSQL := MainSQL + #13#10 + 'update ' + TBYZYJWZX +
                ' set IBGZT=1  where CYZH=' + QuotedStr('SQ' + FCBH);
              MainSQL := MainSQL + #13#10 + ' insert into ' + TBYZYJWGD +
                ' select * from ' + TBYZYJWZX + ' where CYZH=' + quotedstr('SQ' + FCBH);
              MainSQL := MainSQL + #13#10 + ' delete from ' + TBYZYJWZX +
                ' Where CYZH=' + quotedstr('SQ' + FCBH);
            end;
            if TBYZBYZYLBQ <> '' then
              MainSQL := MainSQL + #13#10 + 'UPDATE ' + TBYZBYZYLBQ +
                ' SET IFYZT=5' + ' WHERE CZYH=' + Quotedstr(FCBRH) +
                ' AND CSQDBH=' + Quotedstr(FCBH);
          end;
        end;
      end
      else if ILX = 0 then
      begin
        CBBG := QRYTEMP1.fieldbyname('CBGDBH').AsString;
        CBBG := StringReplace(CBBG, '=|', '', [rfReplaceAll, rfIgnoreCase]);
        BBG := Pos('=', CBBG) <= 0;
        if BBG then
        begin
          MainSQL := MainSQL + #13#10 + ' update ' + tbxxWZX +
            ' set IBGZT=0  where CBH=' + quotedstr(FCBH);
          if (IBRLX = 1) then
          begin
            if (FBQYLYZ) then
              MainSQL := MainSQL + #13#10 + 'update ' + TBYZYJWZX +
                ' set IBGZT=0  where CYZH=' + QuotedStr('SQ' + FCBH);
            if TBYZBYZYLBQ <> '' then
              MainSQL := MainSQL + #13#10 + 'UPDATE ' + TBYZBYZYLBQ +
                ' SET IFYZT=1' + ' WHERE CZYH=' + Quotedstr(FCBRH) +
                ' AND CSQDBH=' + Quotedstr(FCBH);
          end;
        end;
      end;
      if MainSQL <> '' then
      begin
        if not ExeSql(QRYTEMP, MainSQL, True) then
        begin
          AERROR := ('���뵥ת��ʧ��:' + AERROR);
          Exit;
        end;
      end;
      Commit(2);
    except
      if InTransaction(2) then
        Rollback(2);
      Exit;
    end;
  finally
    SqdXML := nil;
    BgdXML := nil;
    FreeAndNil(CBGMBList);
    FreeAndNil(CZTBMList);
    FreeAndNil(CINNERIDList);
    FreeAndNil(CYZXBGDList);
    FreeAndNil(CYCBGMBBHList);
    FreeAndNil(QRYTEMP);
    FreeAndNil(QRYTEMP1);
  end;
  Result := True;
end;

function TYXSVR.DoExcute(InValue: string; out OutValue: string): Boolean;
var
  RNode: IXMLDOMNode;
  value: string;
  MainXML: IXMLDOMDocument2;
begin
  Result := False;
  try
    OleInitialize(nil);
    MainXML := CoDOMDocument.Create;
    try
      if not LoadXMLText(MainXML, InValue) then
      begin
        OutValue := '����XML����:' + AERROR + ',XML:' + #13#10 + InValue;
        Exit;
      end;
      RNode := MainXML.selectSingleNode('MSG');
      if RNode = nil then
      begin
        OutValue := 'δ�ҵ�<MSG>ͷ�ڵ㣡���飡' + MainXML.xml;
        Exit;
      end;
      if RNode.selectSingleNode('Header') = nil then
      begin
        OutValue := 'δ�ҵ�<Header>�ڵ㣡���飡' + MainXML.xml;
        Exit;
      end;
      if not CheckInvalue(RNode, OutValue) then
        Exit;
      {$REGION '����ҵ����'}
      if RNode.selectSingleNode('Header').Text = 'WriteRegInfo' then
      begin
        if not WriteRegInfo(StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT, -
          1), StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT, -1),
          VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT, ''), VarToStrDef(RNode.selectSingleNode
          ('Body/CSQDH').TEXT, ''), VarToStrDef(RNode.selectSingleNode('Body/CZTBM').TEXT,
          ''), VarToStrDef(RNode.selectSingleNode('Body/CDBLX').TEXT, '')) then
        begin
          OutValue := Aerror;
          Exit;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'MakeSQD' then
      begin
        if not MakeSQD(StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT, -1),
          StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT, -1), VarToStrDef(RNode.selectSingleNode
          ('Body/CBRH').TEXT, ''), VarToStrDef(RNode.selectSingleNode('Body/CMBBH').TEXT,
          ''), VarToStrDef(RNode.selectSingleNode('Body/CZTBM').TEXT, ''), '', '',
          VarToStrDef(RNode.selectSingleNode('Body/CDBLX').TEXT, '')) then
        begin
          OutValue := Aerror;
          Exit;
        end
        else
        begin
          OutValue := MAKESQDH;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'DelSQD' then
      begin
        if not DelSQD(StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT, -1),
          StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT, -1), RNode.selectSingleNode
          ('Body/CBRH').TEXT, RNode.selectSingleNode('Body/CSQDH').TEXT, RNode.selectSingleNode
          ('Body/CDBLX').TEXT) then
        begin
          OutValue := Aerror;
          Exit;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'ReadCard' then
      begin
        if not ReadCard(RNode.selectSingleNode('Body/CYLKH').TEXT, RNode.selectSingleNode
          ('Body/CDBLX').TEXT) then
        begin
          OutValue := Aerror;
          Exit;
        end
        else
        begin
          OutValue := ReadCardH;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'DoPerForm' then
      begin
        if not DoPerForm(StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT, -1),
          StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT, -1), RNode.selectSingleNode
          ('Body/CBRH').TEXT, RNode.selectSingleNode('Body/CSQDH').TEXT, RNode.selectSingleNode
          ('Body/CDBLX').TEXT) then
        begin
          OutValue := Aerror;
          Exit;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'DoCharge' then
      begin
        if not DoCharge(StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT, -1),
          StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT, -1), RNode.selectSingleNode
          ('Body/CZY').TEXT, RNode.selectSingleNode('Body/CBRH').TEXT, RNode.selectSingleNode
          ('Body/CSQDH').TEXT, RNode.selectSingleNode('Body/CDBLX').TEXT) then
        begin
          OutValue := Aerror;
          Exit;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'WriteReport' then
      begin
        if not WriteReport(StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT, -1),
          StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT, -1), RNode.selectSingleNode
          ('Body/CBRH').TEXT, RNode.selectSingleNode('Body/CSQDH').TEXT, RNode.selectSingleNode
          ('Body/CZTBM').TEXT, RNode.selectSingleNode('Body/XMLDATA').TEXT, RNode.selectSingleNode
          ('Body/CDBLX').TEXT) then
        begin
          OutValue := Aerror;
          Exit;
        end;
      end
      else if RNode.selectSingleNode('Header').Text = 'ExecCharge' then
      begin
        value := RNode.selectSingleNode('Body/InValue').TEXT;
        if not ExecCharge(value,OutValue)
        then
        begin
          OutValue:=Aerror;
          Exit;
        end;
      end;
    {$ENDREGION}
    finally
      MainXML := nil;
      OleUninitialize;
    end;
  except
    on e: exception do
    begin
      OutValue := Aerror + ',' + e.message;
      Exit;
    end
  end;
  Result := True;
end;

function TYXSVR.CheckInvalue(InNode: IXMLDOMNode; out OutValue: string): Boolean;
begin
  Result := False;
  try
    {$REGION '���XML���'}
    if InNode = nil then
      Exit;
    if InNode.selectSingleNode('Header').Text = 'WriteRegInfo' then
    begin
      if InNode.selectSingleNode('Body/ILX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/IBRLX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CBRH') = nil then
      begin
        OutValue := 'δ����<CBRH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CSQDH') = nil then
      begin
        OutValue := 'δ����<CSQDH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CZTBM') = nil then
      begin
        OutValue := 'δ����<CZTBM>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if InNode.selectSingleNode('Header').Text = 'MakeSQD' then
    begin
      if InNode.selectSingleNode('Body/ILX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/IBRLX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CBRH') = nil then
      begin
        OutValue := 'δ����<CBRH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CMBBH') = nil then
      begin
        OutValue := 'δ����<CSQDH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CZTBM') = nil then
      begin
        OutValue := 'δ����<CZTBM>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if InNode.selectSingleNode('Header').Text = 'DelSQD' then
    begin
      if InNode.selectSingleNode('Body/ILX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/IBRLX') = nil then
      begin
        OutValue := 'δ����<IBRLX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CBRH') = nil then
      begin
        OutValue := 'δ����<CBRH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CSQDH') = nil then
      begin
        OutValue := 'δ����<CSQDH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if InNode.selectSingleNode('Header').Text = 'ReadCard' then
    begin
      if InNode.selectSingleNode('Body/CYLKH') = nil then
      begin
        OutValue := 'δ����<CYLKH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if (InNode.selectSingleNode('Header').Text = 'DoPerForm') then
    begin
      if InNode.selectSingleNode('Body/ILX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/IBRLX') = nil then
      begin
        OutValue := 'δ����<IBRLX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CBRH') = nil then
      begin
        OutValue := 'δ����<CBRH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CSQDH') = nil then
      begin
        OutValue := 'δ����<CSQDH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if InNode.selectSingleNode('Header').Text = 'DoCharge' then
    begin
      if InNode.selectSingleNode('Body/ILX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/IBRLX') = nil then
      begin
        OutValue := 'δ����<IBRLX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CBRH') = nil then
      begin
        OutValue := 'δ����<CBRH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CSQDH') = nil then
      begin
        OutValue := 'δ����<CSQDH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CZY') = nil then
      begin
        OutValue := 'δ����<CZY>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if InNode.selectSingleNode('Header').Text = 'WriteReport' then
    begin
      if InNode.selectSingleNode('Body/ILX') = nil then
      begin
        OutValue := 'δ����<ILX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/IBRLX') = nil then
      begin
        OutValue := 'δ����<IBRLX>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CBRH') = nil then
      begin
        OutValue := 'δ����<CBRH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CSQDH') = nil then
      begin
        OutValue := 'δ����<CSQDH>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CZTBM') = nil then
      begin
        OutValue := 'δ����<CZTBM>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/XMLDATA') = nil then
      begin
        OutValue := 'δ����<XMLDATA>�ڵ㣡���飡';
        Exit;
      end;
      if InNode.selectSingleNode('Body/CDBLX') = nil then
      begin
        OutValue := 'δ����<CDBLX>�ڵ㣡���飡';
        Exit;
      end;
    end
    else if InNode.selectSingleNode('Header').Text = 'ExecCharge' then
    begin
      if InNode.selectSingleNode('Body/InValue') = nil then
      begin
        OutValue := 'δ����<InValue>�ڵ㣡���飡';
        Exit;
      end;
    end
    else
    begin
      OutValue := InNode.selectSingleNode('Header').Text + 'ҵ�񲻴��ڣ�';
      Exit;
    end;

  {$ENDREGION}
  except
    on e: Exception do
    begin
      OutValue := '�������XML����' + e.Message;
      Exit;
    end;
  end;
  Result := True;
end;

////////////////////////////////////////ҽ�ƿ�ˢ��////////////////////////////////////////////////
type
  TBMJumpTable = array[0..255] of Integer;
function TYXSVR.CheckCardNo(const Card: WideString): Integer;
const
  FunctionName = 'CheckCardNo';
var
  FHXX: array[0..30] of string;
  vCard: string;
  CSQL, str: string;
  BYLK: boolean; //ʹ��IUSEYLKFL������¼��ֵ�Ƿ�ΪTBYLKFL���������
  CTYPE, str1, str2: string;
  n, I: integer;
  vList: TStrings;
  tmpStr: string;
  tmpStrXX: array[0..30] of string;
  IUSEYLKCFSYDKHY: Integer;
  CBM: string; //TBYLKFL.IBM
  CYKTJXKHZDYCD: string;
  iStart, iLen: Integer;
  tmpList: TStringList;
  tmpValue: string;
  FCard, CNYLH: string;
  //UNCARD: TCARD; // IC����
  IYKTJXKHCLGDF_TYPE: Integer;
  ATJ: string;
  FYSKH: string;
  CSKLX: string;
  CYLKDKMSBM: string;
  IBM: Integer;
  CSKKH: string;
  itype: integer;
  ICCardXX: string;
  FIType: integer;
  ICallCode: integer;
  QryTemp, QryTemp1, QryTemp2: TFDQuery;
  QryYLK: TFDQuery;
  UserName: string;
  Handle: HWND;
  SetType: procedure(YKT_Type: Integer); stdcall;
  GetDecode: function(Invalue: string): Int64; stdcall;
  //���ݽ���

  function Decrypt2(const S, Key1: AnsiString; Key: Word): AnsiString;

    function Decode(const S: AnsiString): AnsiString;
    const
      Map: array[AnsiChar] of Byte = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 62, 0, 0, 0, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 0, 0, 0, 0, 0, 0, 26, 27, 28,
        29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
        47, 48, 49, 50, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    var
      I: LongInt;
    begin
      case Length(S) of
        2:
          begin
            I := Map[S[1]] + (Map[S[2]] shl 6);
            SetLength(Result, 1);
            Move(I, Result[1], Length(Result))
          end;
        3:
          begin
            I := Map[S[1]] + (Map[S[2]] shl 6) + (Map[S[3]] shl 12);
            SetLength(Result, 2);
            Move(I, Result[1], Length(Result))
          end;
        4:
          begin
            I := Map[S[1]] + (Map[S[2]] shl 6) + (Map[S[3]] shl 12) + (Map[S[4]] shl 18);
            SetLength(Result, 3);
            Move(I, Result[1], Length(Result))
          end
      end
    end;

    function PreProcess(const S: AnsiString): AnsiString;
    var
      SS: AnsiString;
    begin
      SS := S;
      Result := '';
      while SS <> '' do
      begin
        Result := Result + Decode(Copy(SS, 1, 4));
        Delete(SS, 1, 4)
      end
    end;

    function InternalDecrypt(const S: AnsiString; Key: Word): AnsiString;
    var
      I: Word;
      Seed: int64;
    begin
      Result := S;
      Seed := Key;
      for I := 1 to Length(Result) do
      begin
        Result[I] := ansiChar(Byte(Result[I]) xor (Seed shr 8));
        Seed := (Byte(S[I]) + Seed) * Word(28853) + Word(31836)
      end
    end;

  var
    i, a: Word;
    c: AnsiString;
  begin
    Result := '';
    a := Key;
    for i := 1 to Length(Key1) do
      a := a + Ord(Key1[i]);
    c := InternalDecrypt(PreProcess(S), a);
    for i := 1 to Length(c) do
      Result := Result + AnsiChar(Ord(c[i]) xor $A5);
    Result := Trim(Result);
  end;

  procedure DivideData(List: TStrings; InValue: WideString; Compart: string); overload;
  var
    I: integer;
    Posit: Integer;
    AStr: string;
    Len: Integer;
  begin
    List.Clear;
    AStr := InValue;
    Len := Length(Compart);
    for I := Length(AStr) downto 1 do
    begin
      Posit := AnsiPos(Compart, AStr);
      if Posit > 0 then
      begin
        List.Add(Copy(AStr, 1, Posit - 1));
        AStr := Copy(AStr, Posit + Len, Length(AStr) - Posit - Len + 1);
        Continue;
      end;
      Break;
    end;
    List.Add(AStr);
  end;

  procedure DivideData(var Data: array of string; InValue: WideString; Compart:
    string = '|'); overload;
  var
    I, Index: integer;
    Posit: Integer;
    AStr: string;
    Len: Integer;
  begin
    for I := 0 to Length(Data) - 1 do
      Data[I] := '';
    Index := 1;
    AStr := InValue;
    Len := Length(Compart);
    for I := Length(AStr) downto 1 do
    begin
      Posit := AnsiPos(Compart, AStr);
      if Posit > 0 then
      begin
        Data[Index] := Copy(AStr, 1, Posit - 1);
        AStr := Copy(AStr, Posit + Len, Length(AStr) - Posit - Len + 1);
        Inc(Index);
        Continue;
      end;
      Break;
    end;
    Data[Index] := AStr;
  end;

  function ValidatePIDnew(const APID: string): string;
  var
    L: Integer;
    sCentury: string;
    sYear2Bit: string;
    sMonth: string;
    sDate: string;
    iCentury: Integer;
    iMonth: Integer;
    iDate: Integer;
    CRCFact: string; //18λ֤�ŵ�ʵ��ֵ
    //CRCTh: string; //18λ֤�ŵ�����ֵ
    FebDayAmt: Byte; //2������
  {�ڲ�����,ȡ���֤��У��λ,���һλ,��18λ��Ч}

    function GetVerifyBit(sIdentityNum: string): Boolean;
    var
      nNum: Integer;
      LastCode: string;
    begin
      Result := False;
    //15λ�����֤��У��
      if Length(sIdentityNum) = 15 then
      begin
        Result := True;
        Exit;
      end;

      nNum := StrToInt(sIdentityNum[1]) * 7 + StrToInt(sIdentityNum[2]) * 9 +
        StrToInt(sIdentityNum[3]) * 10 + StrToInt(sIdentityNum[4]) * 5 +
        StrToInt(sIdentityNum[5]) * 8 + StrToInt(sIdentityNum[6]) * 4 + StrToInt
        (sIdentityNum[7]) * 2 + StrToInt(sIdentityNum[8]) * 1 + StrToInt(sIdentityNum
        [9]) * 6 + StrToInt(sIdentityNum[10]) * 3 + StrToInt(sIdentityNum[11]) *
        7 + StrToInt(sIdentityNum[12]) * 9 + StrToInt(sIdentityNum[13]) * 10 +
        StrToInt(sIdentityNum[14]) * 5 + StrToInt(sIdentityNum[15]) * 8 +
        StrToInt(sIdentityNum[16]) * 4 + StrToInt(sIdentityNum[17]) * 2;

      nNum := nNum - nNum div 11 * 11;
      case nNum of
        0:
          LastCode := '1';
        1:
          LastCode := '0';
        2:
          LastCode := '11';
        3:
          LastCode := '9';
        4:
          LastCode := '8';
        5:
          LastCode := '7';
        6:
          LastCode := '6';
        7:
          LastCode := '5';
        8:
          LastCode := '4';
        9:
          LastCode := '3';
        10:
          LastCode := '2';
      else
        LastCode := '';
      end;
      if LastCode = '11' then
        LastCode := 'X';
      if UpperCase(LastCode) <> UpperCase(sIdentityNum[18]) then
        Exit;
      Result := True;
    end;

  begin
    L := Length(APID);
    if (L in [15, 18]) = False then
    begin
      Result := Format('���֤�Ų���15λ��18λ(%0:s, ʵ��λ��:%1:d)', [APID, L]);
      Exit;
    end;
    CRCFact := '';
    if L = 18 then
    begin
      sCentury := Copy(APID, 7, 2);
      iCentury := StrToInt(sCentury);
      if (iCentury in [18..20]) = False then
      begin
        Result := Format('���֤������Ч:18λ֤�ŵ����ǰ��λ������18-20֮��(%0:S)', [sCentury]);
        Exit;
      end;
      sYear2Bit := Copy(APID, 9, 2);
      sMonth := Copy(APID, 11, 2);
      sDate := Copy(APID, 13, 2);
      CRCFact := Copy(APID, 18, 1);
    end
    else
    begin
      sCentury := '19';
      sYear2Bit := Copy(APID, 7, 2);
      sMonth := Copy(APID, 9, 2);
      sDate := Copy(APID, 11, 2);
    end;
    iMonth := StrToInt(sMonth);
    iDate := StrToInt(sDate);
    if (iMonth in [01..12]) = False then
    begin
      Result := Format('���֤������Ч:�·ݱ�����01-12֮��(%0:s)', [sMonth]);
      Exit;
    end;
    if (iMonth in [1, 3, 5, 7, 8, 10, 12]) then
    begin
      if (iDate in [01..31]) = False then
      begin
        Result := Format('���֤������Ч:������Ч,����Ϊ��򳬳��������ֵ(%0:s)', [sDate]);
        Exit;
      end;
    end;
    if (iMonth in [4, 6, 9, 11]) then
    begin
      if (iDate in [01..30]) = False then
      begin
        Result := Format('���֤������Ч:������Ч,����Ϊ��򳬳��������ֵ(%0:s)', [sDate]);
        Exit;
      end;
    end;
    if IsLeapYear(StrToInt(sCentury + sYear2Bit)) = True then
    begin
      FebDayAmt := 29;
    end
    else
    begin
      FebDayAmt := 28;
    end;
    if (iMonth in [2]) then
    begin
      if (iDate in [01..FebDayAmt]) = False then
      begin
        Result := Format('���֤������Ч:������Ч,����Ϊ��򳬳��������ֵ(%0:s)', [sDate]);
        Exit;
      end;
    end;
  //β��У��
    if not GetVerifyBit(APID) then
    begin
      Result := Format('���֤������Ч:У��λ(��18λ)��:(%0:s)��', [sDate]);
      Exit;
    end;
  end;

  function MsgInfo(vcard: string): Boolean;
  var
    CSQL: string;
  begin
    Result := False;
    if (GetYXXTCSI('IYKTKQGSTS', 0) = 1) and (GetYXXTCSI('USEYLKCFSY', 0) = 1) then
    begin
      CSQL := 'select CICID,IICZT FROM ' + SDBLX +
        '..TBICXXDZ WITH(NOLOCK) WHERE   IICZT = 2 and  (( CICKMW = ' +
        QuotedStr(vcard) + ') OR ( CICKMM = ' + QuotedStr(vcard) + '))';
      if not ExeSql(QryTemp1, CSQL, FALSE) then
        exit;
      if not QryTemp1.IsEmpty then
      begin
        AERROR := '��ҽ�ƿ��ѹ�ʧ';
        Exit;
      end;
    end;
    Result := True;
  end;

  function SearchICXX(const Card: wideString; Cvalue: string; out CNYLH: string): string;
  var
    CSQL: string;
  begin
    result := '';
    if GetYXXTCSI('IYLKSKXZXFKRQZD', 0) = 1 then
    begin
      CSQL := 'SELECT CICID,CNYLH from ' + SDBLX +
        '..TBICXX  with(nolock) where ' + Cvalue + ' = ' + QuotedStr(Card) +
        ' ORDER BY DFKRQ ASC';
    end
    else
      CSQL := 'select CICID,CNYLH from ' + SDBLX +
        '..TBICXX  with(nolock) where ' + Cvalue + '=''' + Card + '''';
    if not ExeSql(QryTemp1, CSQL, False) then
      Exit;

    if not QryTemp1.IsEmpty then
    begin
      result := QryTemp1.FieldByName('CICID').AsString;
      CNYLH := QryTemp1.FieldByName('CNYLH').AsString;
      Exit;
    end;
    if UpperCase(Cvalue) <> 'CNYLH' then
    begin
      CSQL := 'select CICID,CNYLH  from ' + SDBLX +
        '..TBICXX  with(nolock) where CNYLH=''' + Card + '''';
      if not ExeSql(QryTemp1, CSQL, False) then
        Exit;
      if QryTemp1.IsEmpty then
        Exit;
      result := QryTemp1.FieldByName('CICID').AsString;
      CNYLH := QryTemp1.FieldByName('CNYLH').AsString;
      CSKKH := CNYLH; //������Ҫ�����ò�����������...
    end;
  end;

  function GetDZKH(Ctype: string): integer;
  var
    csql: string;
    ABool: boolean;
    BBool: boolean;
    CBool: boolean;
    CFCYLH: string;
  begin
    result := 2;
    CFCYLH := '';
  //����������黻�����߶���  --���� 2017��12��22�� 11:20:48
    if Ctype = '1' then
    begin
      Result := 1;
      exit;
    end;
  //CTYPE=1Ϊ�½���
    ABool := (GetYXXTCSI('USEYLKCFSY', 0) = 1) and (Ctype <> '1');
  //¹Ȫ����
    BBool := (GetYXXTCSI('USELQQYYLK', 0) = 1);
    CBool := ((Copy(FCYLH, 1, 1) = 'A') or (GetYXXTCSI('USEWHQYYKT', 0) = 1)); //A��ͷ�Ĵ�����ʱ���������ظ�(��ͬ��)ʹ��һ
  //2013-05-16ʹ���µ�ҽ�ƿ�����:ҽ�ƿ��ظ�ʹ�ù���(���ܺ�),����ʱ�����������
  //������߼�:�ظ��ÿ����� and (û��ʹ��¹Ȫ�� ���� ʹ����¹Ȫ��������ʱ����)
    if ABool and (not BBool or (BBool and CBool)) then
    begin
    //ʹ��ҽ�ƿ��ظ�ʹ�ù��ܶ࿨��һ  ldk 2018��8��2��    ����ʡʡ��ҽԺ������ʡ��ͯҽԺ��
      if (GetYXXTCSI('USEYLKCFSYDKHY', 0) = 1) then
      begin
      //ũ�����п��ź����֤�ų��ȶ�Ϊ18����Ҫ�������� ��� 2018��12��17��  ��֣������ҽԺ
        if (GetYXXTCSI('USEYLKCFSYDKHYQFYHKH', 0) > 0) and (Length(FCYLH) = 18) then
        begin
          if ValidatePIDnew(FCYLH) = '' then   //Ϊ�ձ�ʾ�����֤
          begin
           //(FCYLH+'��ȡΪ���֤');
          end
          else
          begin
            IBM := GetYXXTCSI('USEYLKCFSYDKHYQFYHKH', 0);
          end;
        end;
        CFCYLH := FCYLH; //CFCYLH�������ISYYLKBGGN���õ�
        csql := 'select CICID from ' + SDBLX +
          '..TBICXXDZ with(nolock) where IICZT=1 ' + ' and CICKMM' + IntToStr(IBM)
          + '=' + QuotedStr(FCYLH);
        if not ExeSql(QryTemp1, csql, FALSE) then
        begin
          Result := 2;
          AERROR := ' ��Ч����(δ������������Ϣ)������';
          FCYLH := '';
          Exit;
        end;
        if QryTemp1.IsEmpty then
        begin
          csql := 'select CICID,IICZT from ' + SDBLX +
            '..TBICXXDZ with(nolock) where 1=1 ' + ' and CICKMM' + IntToStr(IBM)
            + '=' + QuotedStr(FCYLH);
          if not ExeSql(QryTemp2, csql, FALSE) then
            Exit;
          case QryTemp2.Fields[1].AsInteger of
            1:
              AERROR := ' ����';
            2:
              AERROR := ' �ÿ��ѹ�ʧ';
            3:
              AERROR := ' �ÿ���ע��';
            4:
              AERROR := ' �ÿ����˿�';
          else
            AERROR := ' ��Ч����(δ������������Ϣ)������';
          end;
          Exit;
        end;
      end
      else
      begin
        csql := 'select CICID from ' + SDBLX +
          '..TBICXXDZ with(nolock) where IICZT=1 and CICKMM=' + QuotedStr(FCYLH);
        if not ExeSql(QryTemp1, csql, FALSE) then
        begin
          Result := 2;
          AERROR := '��Ч����(δ������������Ϣ)';
          FCYLH := '';
          Exit;
        end;
      end;
      FCYLH := QryTemp1.Fields[0].AsString;
    end;

    CSKKH := FCYLH;
    if GetYXXTCSI('ISYYLKBGGN', 0) = 1 then
    begin
    //ʹ���˶࿨��һ��ǰ���Ѿ���CICID��ֵ����FCYLH,���˿��ľͲ��������µĿ���
    //�࿨��һ��ȡ�¿� ��֣������ҽԺ ldk  2018��12��19��
      if (GetYXXTCSI('USEYLKCFSYDKHYDQXK', 0) = 1) then
      begin
        Result := 1;
        Exit;
      end;
      csql := 'SELECT CICID FROM ' + SDBLX +
        '..tbylkhkdz WITH (NOLOCK) WHERE (XYLKH=''' + FCYLH + ''')';
      if not ExeSql(QryTemp1, csql, FALSE) then
      begin
        RESULT := 2;
        exit;
      end;
      if not QryTemp1.IsEmpty then
      begin
        FCYLH := QryTemp1.FieldByName('CICID').AsString;
        if FCYLH = '' then
        begin
          AERROR := 'ȡԭ����Ϊ�գ�' + csql;
          Exit;
        end;
      end;
    end;
    result := 1;
  end;

  procedure MakeBMTable(Buffer: PAnsiChar; BufferLen: Integer; var JumpTable:
    TBMJumpTable);
  begin
    if BufferLen = 0 then
      raise Exception.Create('BufferLen is 0');
    asm
        push    EDI
        push    ESI
        mov     EDI, JumpTable
        mov     EAX, BufferLen
        mov     ECX, $100
        REPNE   STOSD
        mov     ECX, BufferLen
        mov     EDI, JumpTable
        mov     ESI, Buffer
        dec     ECX
        XOR     EAX, EAX

@@loop:
        mov     AL, [ESI]
        lea     ESI, ESI + 1
        mov     [EDI + EAX * 4], ECX
        dec     ECX
        jg      @@loop
        pop     ESI
        pop     EDI
    end;
  end;

  function BMPos(const aSource, aFind: Pointer; const aSourceLen, aFindLen:
    Integer; var JumpTable: TBMJumpTable): Pointer;
  var
    LastPos: Pointer;
  begin
    LastPos := Pointer(Integer(aSource) + aSourceLen - 1);
    asm
        push    ESI
        push    EDI
        push    EBX
        mov     EAX, aFindLen
        mov     ESI, aSource
        lea     ESI, ESI + EAX - 1
        std
        mov     EBX, JumpTable

@@comparetext:
        cmp     ESI, LastPos
        jg      @@NotFound
        mov     EAX, aFindLen
        mov     EDI, aFind
        mov     ECX, EAX
        push    ESI //Remember where we are
        lea     EDI, EDI + EAX - 1
        XOR     EAX, EAX

@@CompareNext:
        mov     al, [ESI]
        cmp     al, [EDI]
        jne     @@LookAhead
        lea     ESI, ESI - 1
        lea     EDI, EDI - 1
        dec     ECX
        jz      @@Found
        jmp     @@CompareNext

@@LookAhead:
        //Look up the char in our Jump Table
        pop     ESI
        mov     al, [ESI]
        mov     EAX, [EBX + EAX * 4]
        lea     ESI, ESI + EAX
        jmp     @@CompareText

@@NotFound:
        mov     Result, 0
        jmp     @@TheEnd

@@Found:
        pop     EDI //We are just popping, we don't need the value
        inc     ESI
        mov     Result, ESI

@@TheEnd:
        cld
        pop     EBX
        pop     EDI
        pop     ESI
    end;
  end;

  function FastPos(const aSourceString, aFindString: AnsiString; const
    aSourceLen, aFindLen, StartPos: Integer): Integer;
  var
    JumpTable: TBMJumpTable;
  begin
  //If this assert failed, it is because you passed 0 for StartPos, lowest value is 1 ����
    Assert(StartPos > 0);
    if aFindLen < 1 then
    begin
      Result := 0;
      exit;
    end;
    if aFindLen > aSourceLen then
    begin
      Result := 0;
      exit;
    end;

    MakeBMTable(PAnsiChar(aFindString), aFindLen, JumpTable);
    Result := Integer(BMPos(PAnsiChar(aSourceString) + (StartPos - 1), PAnsiChar
      (aFindString), aSourceLen - (StartPos - 1), aFindLen, JumpTable));
    if Result > 0 then
      Result := Result - Integer(@aSourceString[1]) + 1;
  end;
  {function FastCharPos(const aSource: string; const C: Char;StartPos: Integer): Integer;
var
  L: Integer;
begin
  //If this assert failed, it is because you passed 0 for StartPos, lowest value is 1 ����
  Assert(StartPos > 0);

  Result := 0;
  L := Length(aSource);
  if L = 0 then exit;
  if StartPos > L then exit;
  Dec(StartPos);
  asm
      PUSH EDI                 //Preserve this register

      mov  EDI, aSource        //Point EDI at aSource
      add  EDI, StartPos
      mov  ECX, L              //Make a note of how many chars to search through
      sub  ECX, StartPos
      mov  AL,  C              //and which char we want
    @Loop:
      cmp  Al, [EDI]           //compare it against the SourceString
      jz   @Found
      inc  EDI
      dec  ECX
      jnz  @Loop
      jmp  @NotFound
    @Found:
      sub  EDI, aSource        //EDI has been incremented, so EDI-OrigAdress = Char pos ��
      inc  EDI
      mov  Result,   EDI
    @NotFound:

      POP  EDI
  end;
end;  }

  function StringMatches(Value, Pattern: string): Boolean;
  var
    NextPos, Star1, Star2: Integer;
    NextPattern: string;
  begin
    Star1 := 0;
    Star2 := 0;

 // Star1 := FastCharPos(Pattern, '*', 1);
  //if Star1 = 0 then
    if Length(vCard) - length(StringReplace(vCard, '=', '', [rfReplaceAll])) <> 2 then
      Result := (Value = Pattern)
    else
    begin
      result := False;
      Exit;
      Result := (Copy(Value, 1, Star1 - 1) = Copy(Pattern, 1, Star1 - 1));
      if Result then
      begin
        if Star1 > 1 then
          Value := Copy(Value, Star1, Length(Value));
        Pattern := Copy(Pattern, Star1 + 1, Length(Pattern));

        NextPattern := Pattern;
      //Star2 := FastCharPos(NextPattern, '*', 1);
        if Star2 > 0 then
          NextPattern := Copy(NextPattern, 1, Star2 - 1);

      //pos(NextPattern,Value);
        NextPos := FastPos(Value, NextPattern, Length(Value), Length(NextPattern), 1);
        if (NextPos = 0) and not (NextPattern = '') then
          Result := False
        else
        begin
          Value := Copy(Value, NextPos, Length(Value));
          if Pattern = '' then
            Result := True
          else
            Result := Result and StringMatches(Value, Pattern);
        end;
      end;
    end;
  end;
    //רҵ�������п�

  function DivBankCard: string;
  begin
    Result := vCard;
    //��³���п������ƿ�ʹ��
    if (GetYXXTCSI('IQLYHKZZLK', 0) = 1) or (GetYXXTCSI('ISLQYYKT', 0) = 1) then
    begin
    //���п�һ����ȡ=��ǰ�������λ��
    //ҽԺ���ܻ�����������ֱ��ȡֵ����������û��=������ֵ��Ϊ���ˣ������ж�
      if Pos('=', vCard) > 0 then
        Result := Copy(vCard, 1, Pos('=', vCard) - 1);
    end;
    //��³ʡֱҽ���������ƿ�(�ӵڶ�λ��ʼ����^ֹ) ���ݿ�λ�������ж�
    //B6222114048040560^MR.QIUYUZHEN    ^25031010082000000000007350000006222114048040560=2503101
    if (GetYXXTCSI('IQLSZYBKZZLK', 0) > 0) then
    begin
      if Pos('^', vCard) > 0 then
        Result := Copy(vCard, 2, Pos('^', vCard) - 2);
    end;
  end;

  function DivideCard: string;
  begin
    Result := vCard;
    n := pos('=', vCard);
    if n > 0 then
    begin
      str1 := copy(vCard, n + 1, maxint);
      n := pos('=', str1);
      if n > 0 then
      begin
        str2 := copy(str1, 1, n - 1);
        Result := str2;
      end;
    end;
  end;

  function GetDZJKK(Table: string = 'TBDZJKK'): Boolean;
  begin
    Result := false;
    CSQL := 'select CICID from ' + SDBLX + '..' + Table +
      ' with(nolock) where IICZT=1 and CICKMM=' + QuotedStr(vCard);
    if not ExeSql(QryYLK, CSQL, FALSE) then
    begin
      AERROR := '��Ч����(δ������������Ϣ��δ����):' + AERROR;
      FCYLH := '';
      Exit;
    end;
    if QryTemp.RecordCount > 1 then
    begin
      AERROR := '�ÿ�[' + FCYLH + ']��Ӧ���߼����ƺŴ��ڶ�����' + CSQL;
      FCYLH := '';
      Exit;
    end;
    FCYLH := QryTemp.Fields[0].AsString;

    Result := True;
  end;
  //ʹ�õ��Ӿ��￨

  function GetDZJZK: Boolean;
  var
    ATJ: string;
  begin
    Result := false;
     //���ܿ�
    FCYLH := Decrypt2(vCard, UserName, 5728);
    if CTYPE = '1' then //������Ժ
    begin
      Result := True;
      exit;
    end;
    if (GetYXXTCSI('USEYLKCFSY', 0) = 1) then
    begin
      ATJ := ' and CICKMM=' + QuotedStr(FCYLH);
      if (GetYXXTCSI('USEYLKCFSYDKHY', 0) = 1) then
      begin
        ATJ := ' AND CICKMM' + INTTOSTR(GetYXXTCSI('IDZJZKFLBM', 0)) + '=' +
          QuotedStr(FCYLH);
      end;
      CSQL := 'select CICID from ' + SDBLX +
        '..TBICXXDZ with(nolock) where IICZT=1 ' + ATJ;
      if not ExeSql(QryTemp, CSQL, FALSE) then
      begin
        AERROR := '��Ч����(δ������������Ϣ��δ����):' + AERROR;
        FCYLH := '';
        Exit;
      end;
      if QryTemp.RecordCount > 1 then
      begin
        AERROR := '�ÿ�[' + FCYLH + ']��Ӧ���߼����ƺŴ��ڶ�����' + CSQL;
        FCYLH := '';
        Exit;
      end;
      FCYLH := QryTemp.Fields[0].AsString;
    end;

    Result := True;
  end;
  //����ܹ�������ȡ���ܿ�����ô�Ϳ������������

  function CheckExtCard_DZJKK(ATYPE: string): Boolean;
  var
    Handle: Variant;
    ain, WBDYURL, OutValue: string;
    vListJK: TStrings;
  begin
    Result := False;
    CSQL := 'SELECT * FROM ' + SDBLX +
      '..TBYLKDKMS with(nolock) WHERE  CHARINDEX(''|' + IntToStr(length(vCard))
      + '|'',CZDJKWSEX)>0 AND ISNULL(BSTOP,0)=0';
    if not ExeSql(QryTemp, CSQL, False) then
      Exit;
    with QryTemp do
    begin
      First;
      while not eof do
      begin
        try
          Handle := CreateOleObject(QryTemp.fieldbyname('CCOMSTRING').asstring);
          vListJK := TStringList.Create();
          if (GetYXXTCSI('ISYDZJKKDK', 0) = 1) and (POS('|' + IntToStr(length(vCard))
            + '|', GetYXXTCSI('CDZJKKJMKCD', '')) > 0) then
          begin
              //Ϊ�˲���TBSYSTABLES�����ã�������HIS�н���һ����ͼ
            CSQL := 'Select CHISURL From ' + SDBLX + '..VTBSYSNO Where CSYSNO ='
              + QuotedStr('DZJKK');
            if not ExeSql(QryTemp1, CSQL, False) then
              Exit;
            WBDYURL := QryTemp1.FieldByName('CHISURL').AsString;
          end;
            // iccardeditˢ�����ļ��ܴ�
            //1ϵͳ���|2����Ա����|3����Ա����|4����Ա����|5����Ա�������ұ���|6����Ա������������|7�ⲿ��������|
            //8ˢ�����Ŀ���(�п����Ǽ��ܴ�)|9ҽԺ����(����Ч�������õ�)|
          ain := '40' + '|' + FCZYGH + '|' + FCZYGH + '|' + FCZYMC + '|' +
            FIZXKS + '|' + FCZXKS + '|' + WBDYURL + '|' + vCard + '|' + UserName
            + '|' + ATYPE;
          try
            if not Handle.Execute('READCARD', ain, OutValue) then
            begin
              AERROR := Handle.ErrorInfo;
              Exit;
            end;
          except
            on E: Exception do
            begin
              AERROR := e.Message;
              Exit;
            end;
          end;
          ICCardXX := OutValue;
          DivideData(vListJK, ICCardXX, '|');
          CSKKH := vListJK[0];
          vCard := vListJK[0];
          FIType := 0;
          Result := True;
        finally
          Handle := Unassigned;
          FreeAndNil(vListJK);
        end;
        if Result then
        begin
          Break;
        end;
        Next;
      end;
    end;
    Result := True;
  end;

  function GetICXXDZ: boolean;
  begin
    Result := False;
    if (GetYXXTCSI('USEYLKCFSY', 0) = 1) then
    begin
      //ʹ��ҽ�ƿ��ظ�ʹ�ù��ܶ࿨��һ  ldk 2018��8��2��    ����ʡʡ��ҽԺ������ʡ��ͯҽԺ��
      if IUSEYLKCFSYDKHY = 1 then
      begin
        //ũ�����п��ź����֤�ų��ȶ�Ϊ18����Ҫ�������� ��� 2018��12��17��  ��֣������ҽԺ
        //ҽ�ƿ��ظ�ʹ�ö࿨��һ�������п���
        if (GetYXXTCSI('USEYLKCFSYDKHYQFYHKH', 0) > 0) and (Length(vCard) = 18) then
        begin
          if ValidatePIDnew(vCard) = '' then   //Ϊ�ձ�ʾ�����֤
          begin
          end
          else
          begin
            IBM := GetYXXTCSI('USEYLKCFSYDKHYQFYHKH', 0);
          end;
        end;
        CSQL := 'select CICID from ' + SDBLX +
          '..TBICXXDZ with(nolock) where IICZT=1 ' + ' and CICKMM' + IntToStr(IBM)
          + '=' + QuotedStr(vCard);
      end
      else
      begin

        if not MsgInfo(vCard) then
          exit;
        CSQL := 'select CICID from ' + SDBLX +
          '..TBICXXDZ with(nolock) where IICZT=1 and CICKMM=' + QuotedStr(vCard);
      end;
      if not ExeSql(QryTemp, CSQL, FALSE) then
      begin
        AERROR := ' ��Ч����(δ������������Ϣ��δ����):' + AERROR;
        FCYLH := '';
        Exit;
      end;
      if (IUSEYLKCFSYDKHY = 1) then
      begin
        if (QryTemp.IsEmpty) then
        begin
          FCYLH := vCard;
          CSQL := 'select CICID,IICZT from ' + SDBLX +
            '..TBICXXDZ with(nolock) where 1=1 ' + ' and CICKMM' + IntToStr(IBM)
            + '=' + QuotedStr(vCard);
          if not ExeSql(QryTemp1, CSQL, FALSE) then
            Exit;
          case QryTemp1.Fields[1].AsInteger of
            1:
              AERROR := ' ����';
            2:
              AERROR := ' �ÿ��ѹ�ʧ';
            3:
              AERROR := ' �ÿ���ע��';
            4:
              AERROR := ' �ÿ����˿�';
          else
            if GetYXXTCSI('IYLKDZMSDKXSYHK', 0) = 1 then
            begin
              CSQL := 'SELECT * FROM ' + SDBLX +
                '..TBYLKHKDZ WITH(NOLOCK) WHERE 1=1 AND YYLKH =' + QuotedStr(vCard);
              if not ExeSql(QryTemp, CSQL, FALSE) then
                Exit;
              if not QryTemp.IsEmpty then
              begin
                AERROR := '��ҽ�ƿ��ѻ���,��ʹ���¿���';
              end
              else
              begin
                AERROR := ' ��Ч����(δ������������Ϣ)��';
              end;
            end
            else
              AERROR := ' ��Ч����(δ������������Ϣ)��';
          end;
          Exit;
        end
        else
        begin
          FCYLH := QryTemp.Fields[0].AsString;
        end;
      end
      else
      begin
        if QryTemp.RecordCount > 1 then
        begin
          AERROR := '�ÿ�[' + FCYLH + ']��Ӧ���߼����ƺŴ��ڶ�����' + CSQL;
          FCYLH := '';
          Exit;
        end;
        FCYLH := QryTemp.Fields[0].AsString;
      end;
    end;
    Result := True;
  end;

  function CheckExtCard_SL(atype: Integer; INVALUE: string; out OUTVALUE: string):
    Boolean; //�����ⲿ��У�飨˫������һ��ͨ��
  var
    Handle: Variant; //atype��1������2д��־
    Cinvalue: string;
    CKSBM, CKSMC, CYSBM, CYSMC: string;
  begin
    Result := False;
    Handle := CreateOleObject('YxCard.ExtCard');
    try
      //������Ϣ
      if atype = 1 then
      begin
        Cinvalue := INVALUE;
        if not Handle.Execute('READCARD', Cinvalue, OUTVALUE) then
        begin
          AERROR := Handle.AERROR;
          Exit;
        end;
        //tmpStr://1����|2����|3�Ա�|4���֤��|5��������|6�绰|7�շ��������|8�շ���������|9��ͥ��ַ|10����|11ְҵ����״��|12ְҵ||||
        DivideData(tmpStrXX, OUTVALUE);
      end;
      //д������־
      if atype = 2 then
      begin
        //ȡ���պ�ı��������
        CSQL := 'SELECT * FROM ' + SDBLX + '..VTBZDQYCZY WHERE CYSMC =' +
          QUOTEDSTR(FCZYMC);
        if not ExeSql(QryTemp, CSQL, False) then
          Exit;
        if QryTemp.IsEmpty then
        begin
          Aerror := 'ȡҽ�����ձ���Ϊ�գ�' + CSQL;
    //      Exit;
    //ȡ���ձ��롢����ʧ�ܺ󣬲��˳�������ʹ�ñ�Ժ����д��־
          CYSBM := FCZYGH;
          CYSMC := FCZYMC;
          CKSBM := '99';
          CKSMC := 'δ���տ���';
        end
        else
        begin
          CYSBM := QryTemp.FieldByName('CYSBM').AsString;
          CYSMC := QryTemp.FieldByName('CYSMC').AsString;
          CKSBM := QryTemp.FieldByName('CKSBM').AsString;
          CKSMC := QryTemp.FieldByName('CKSMC').AsString;
        end;
        //��֯���
        Cinvalue := INVALUE + '|' + CYSBM + '|' + CYSMC + '|' + CKSBM + '|' + CKSMC;
        if not Handle.Execute('WRITELOG', Cinvalue, OUTVALUE) then
        begin
          AERROR := Handle.AERROR;
          Exit;
        end;
      end;
    finally
      Handle := Unassigned;
    end;

    Result := True;
  end;

  function CallProTimestampCheck(astr: string): Boolean;
  var
    IResult: integer;
    CMsg: string;
  begin
    Result := False;
    //1ˢ����õĶ�ά����Ϣ

    CSQL := 'DECLARE	@return_value int,' + #13#10 + '@aVAlue VARCHAR(2000),' +
      #13#10 + '@AError varchar(2000)' + #13#10 + 'EXEC	@return_value = [' +
      SDBLX + '].[dbo].[ProTimestampCheck] ' + #13#10 + '@aVAlue =' + QuotedStr(astr)
      + ', ' + #13#10 + '@AERROR = @AError OUTPUT  ' + #13#10 +
      'SELECT	@AError as N''@AError'',@return_value as N''@return_value'' ';

    if not ExeSql(QryTemp, CSQL, False) then
      Exit;
    //2017-12-19 ������չ�����ݷ���ֵreturn_valueȷ���Ƿ���������˳�
    //0��ʾ���󣬲�������� ;1��ʾ��ѡ���Ƿ����;2��ʾ����������
    IResult := QryTemp.Fields[1].AsInteger;
    CMsg := QryTemp.Fields[0].AsString;
    if IResult = 0 then
    begin
      AERROR := CMsg;
      EXIT;
    end;
    Result := True;
  end;

  function CheckCardNo_YLK(const vCard: WideString): Integer;
  var
    CardNo, I: Integer;
    FCard, csql: string;
    Card: string;
    CTYPE: string; //���ͣ�0���Ϊ����,1��Ϊ����
    vHandle: Variant;
    OutValue: Widestring;
    FHXX: array[0..30] of string;
    CFCYLH: string;
  //���뿨���Ƿ�Ϊ������

    function IsAllNumber(strtxt: string): Boolean;
    var
      I: Integer;
    begin
      Result := False;
      for I := 1 to Length(strtxt) do
      begin //����ÿ���ַ���ASCII������ж�
        if not (ord(strtxt[I]) in [48..57]) then
          Exit;
      end;
      Result := True;
    end;
  //�������ҽ�ƿ�

    function DivideCard_TT(ACard: string): boolean;
    var
      AStr, BStr, CStr: string;
    begin
      Result := False;
      if Length(ACard) <> 16 then
        Exit;
      AStr := Copy(ACard, 14, 1);
      BStr := Copy(ACard, 15, 1);
      CStr := Copy(ACard, 5, 2);
      if StrToInt(AStr) * StrToInt(BStr) + StrToInt(BStr) <> StrToInt(CStr) then
        Exit;
      FCYLH := Copy(ACard, 9, 7);
      FCYLH := Addstr(Trim(FCYLH), '0', 8);
      Result := True;
    end;

    function CheckCardNo9: WordBool;
    var
      Tmp: Int64;
    begin
      Result := False;
      Handle := LoadLibrary('YxCisSvrDK.dll');
      if Handle = 0 then
      begin
        AERROR := 'YxCisSvrDK.dll����ʧ�ܣ�����';
        Exit
      end;
      try
        @SetType := GetProcAddress(Handle, 'SetType');
        SetType(GetYXXTCSI('IYLKDKMS', 0));
        @GetDecode := GetProcAddress(Handle, 'GetDecode');
        Tmp := GetDecode(UpperCase(Copy(FCard, 7, 9)));
      finally
        FreeLibrary(Handle);
      end;
    //ylkcl.ireadcard_type := GetYXXTCSI('IYLKDKMS', 0);
    //Tmp := Decode(UpperCase(FCard));
      if Tmp = 0 then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      FCYLH := StringOfChar('0', 8 - Length(IntToStr(Tmp))) + inttostr(Tmp);
      FIType := 0;
      Result := True;
    end;

    function CheckCardNo34: WordBool;
    var
      Tmp: Int64;
      vcard: string;
      rcard: string;

      function UncrypStr(Src, Key: string): string; //�ַ������ܺ���
//���ַ�������(Src:Դ Key:�ܳ�)
      var
        KeyLen: Integer;
        KeyPos: Integer;
        offset: Integer;
        dest: string;
        SrcPos: Integer;
        SrcAsc: Integer;
        TmpSrcAsc: Integer;
      begin
        KeyLen := Length(Key);
        if KeyLen = 0 then
          Key := 'delphi';
        KeyPos := 0;
        offset := StrToInt('$' + copy(Src, 1, 2));
        SrcPos := 3;
        repeat
          SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
          if KeyPos < KeyLen then
            KeyPos := KeyPos + 1
          else
            KeyPos := 1;
          TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
          if TmpSrcAsc <= offset then
            TmpSrcAsc := 255 + TmpSrcAsc - offset
          else
            TmpSrcAsc := TmpSrcAsc - offset;
          dest := dest + chr(TmpSrcAsc);
          offset := SrcAsc;
          SrcPos := SrcPos + 2;
        until SrcPos >= Length(Src);
        Result := dest;
      end;

    begin
      Result := False;
      Handle := LoadLibrary('YxCisSvrDK.dll');
      if Handle = 0 then
      begin
        AERROR := 'YxCisSvrDK.dll����ʧ�ܣ�����';
        Exit
      end;
      try
        @SetType := GetProcAddress(Handle, 'SetType');
        SetType(GetYXXTCSI('IYLKDKMS', 0));
        if pos('===', FCard) > 0 then
        begin
          vcard := copy(FCard, pos('===', FCard) + 3, 20);
          rcard := copy(FCard, 1, 11);
        end;
        @GetDecode := GetProcAddress(Handle, 'GetDecode');
        Tmp := GetDecode(UpperCase(Copy(FCard, 7, 9)));
      finally
        FreeLibrary(Handle);
      end;
    {{ylkcl.ireadcard_type := GetYXXTCSI('IYLKDKMS', 0);
    if pos('===', FCard) > 0 then
    begin
      vcard := copy(fcard, pos('===', FCard) + 3, 20);
      rcard := copy(fcard, 1, 11);
    end;
    Tmp := Decode(UpperCase(rcard)); }
      if Tmp = 0 then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      if Tmp <> strtoint64(UncrypStr(vcard, 'YX')) then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      FCYLH := StringOfChar('0', 8 - Length(IntToStr(Tmp))) + inttostr(Tmp);
      FIType := 0;
      Result := True;
    end;
  //�������п�

    function CheckCardNo37: WordBool;
    var
      IPos: Integer;
    begin
    //6222081602000182666=49121208859991636
      Result := False;
    //Tmp := Decode(UpperCase(FCard));
      IPos := Pos('=', FCard);
      if (IPos = 0) and (Length(FCard) in [37]) then
      begin
        AERROR := '�޸����п���';
        Exit;
      end;
    //���п���������TBICXX��Ŀ���ǰ�涼��?��ʾ
    //�������ſ�����56λ��
      if Length(FCard) in [56] then
      begin
        FCYLH := '?' + Copy(FCard, 1, 19);
      end
      else
      begin
        FCYLH := '?' + Copy(FCard, 1, IPos - 1);
      end;
      FIType := 5;
    //���п������ƿ�ʹ��дTBICXX,����������FITypeΪ0,����������ɺ󣬲�ѯTBICXX��ȡ������Ϣ�����ϴ�ѧ����ҽԺ ʹ��
      if GetYXXTCSI('IYHKZZLKSYXTBICXX', 0) = 1 then
        FIType := 0;
      Result := True;
    end;

    function CheckCardNo32: WordBool;
    var
      Tmp: Int64;
      vcard: string;
      rcard: string;

      function UncrypStr(Src, Key: string): string; //�ַ������ܺ���
//���ַ�������(Src:Դ Key:�ܳ�)
      var
        KeyLen: Integer;
        KeyPos: Integer;
        offset: Integer;
        dest: string;
        SrcPos: Integer;
        SrcAsc: Integer;
        TmpSrcAsc: Integer;
      begin
        KeyLen := Length(Key);
        if KeyLen = 0 then
          Key := 'delphi';
        KeyPos := 0;
        offset := StrToInt('$' + copy(Src, 1, 2));
        SrcPos := 3;
        repeat
          SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
          if KeyPos < KeyLen then
            KeyPos := KeyPos + 1
          else
            KeyPos := 1;
          TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
          if TmpSrcAsc <= offset then
            TmpSrcAsc := 255 + TmpSrcAsc - offset
          else
            TmpSrcAsc := TmpSrcAsc - offset;
          dest := dest + chr(TmpSrcAsc);
          offset := SrcAsc;
          SrcPos := SrcPos + 2;
        until SrcPos >= Length(Src);
        Result := dest;
      end;

    begin
      Result := False;
      Handle := LoadLibrary('YxCisSvrDK.dll');
      if Handle = 0 then
      begin
        AERROR := 'YxCisSvrDK.dll����ʧ�ܣ�����';
        Exit
      end;
      try
        @SetType := GetProcAddress(Handle, 'SetType');
        SetType(GetYXXTCSI('IYLKDKMS', 0));
        if pos('===', FCard) > 0 then
        begin
          vcard := copy(FCard, pos('===', FCard) + 3, 20);
          rcard := copy(FCard, 1, 11);
        end;
        @GetDecode := GetProcAddress(Handle, 'GetDecode');
        Tmp := GetDecode(UpperCase(Copy(FCard, 7, 9)));
      finally
        FreeLibrary(Handle);
      end;
    {ylkcl.ireadcard_type := GetYXXTCSI('IYLKDKMS', 0);  //����汾2019.07.31�գ���Ԫ��һ����ҽԺר���������ע���˾Ͷ���������ȡ��ע�ͺ󣬾Ϳ���
    if pos('===', FCard) > 0 then
    begin
      vcard := copy(fcard, pos('===', FCard) + 3, 20);
      rcard := copy(fcard, 1, 9);
    end;
    Tmp := Decode(UpperCase(rcard));}
      if Tmp = 0 then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      if Tmp <> strtoint64(UncrypStr(vcard, 'YX')) then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      FCYLH := StringOfChar('0', 8 - Length(IntToStr(Tmp))) + inttostr(Tmp);
      FIType := 0;
      Result := True;
    end;

    function CheckCardNo15: WordBool;
    var
      Tmp: Int64;
    begin
      Result := False;
      if GetYXXTCSI('BMWYLK', 0) = 1 then
      begin
        FCYLH := FCard;
        FIType := 1;
        Result := True;
        Exit;
      end; //��ʵ��ҽ�ƿ�
      Handle := LoadLibrary('YxCisSvrDK.dll');
      if Handle = 0 then
      begin
        AERROR := 'YxCisSvrDK.dll����ʧ�ܣ�����';
        Exit
      end;
      try
        @SetType := GetProcAddress(Handle, 'SetType');
        SetType(GetYXXTCSI('IYLKDKMS', 0));
        @GetDecode := GetProcAddress(Handle, 'GetDecode');
        Tmp := GetDecode(UpperCase(Copy(FCard, 7, 9)));
      finally
        FreeLibrary(Handle);
      end;
    //ylkcl.ireadcard_type := GetYXXTCSI('IYLKDKMS', 0);
    //Tmp := Decode(UpperCase(Copy(FCard, 7, 9)));
      if Tmp = 0 then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      FCYLH := StringOfChar('0', 9 - Length(IntToStr(Tmp))) + inttostr(Tmp);
      FCYLH := Copy(FCard, 1, 6) + FCYLH;
      FIType := 1;
      Result := True;

    end;

    function CheckCardNo15DJY: WordBool;
    var
      Tmp: Int64;
      prestr: string;
    begin
      Result := False;
      Handle := LoadLibrary('YxCisSvrDK.dll');
      if Handle = 0 then
      begin
        AERROR := 'YxCisSvrDK.dll����ʧ�ܣ�����';
        Exit
      end;
      try
        @SetType := GetProcAddress(Handle, 'SetType');
        SetType(GetYXXTCSI('IYLKDKMS', 0));
        @GetDecode := GetProcAddress(Handle, 'GetDecode');
        Tmp := GetDecode(UpperCase(Copy(FCard, 7, 9)));
      finally
        FreeLibrary(Handle);
      end;

    //ylkcl.ireadcard_type := GetYXXTCSI('IYLKDKMS', 0);
   // Tmp := Decode(UpperCase(Copy(FCard, 5, 11)));
      if Tmp = 0 then
      begin
        AERROR := '�޸�ҽ�ƿ���';
        Exit;
      end;
      FCYLH := StringOfChar('0', 8 - Length(IntToStr(Tmp))) + inttostr(Tmp);
      prestr := Copy(FCard, 1, 4);
      if prestr = '0101' then
        prestr := '1101';

      FCYLH := prestr + FCYLH;
      FIType := 0;
      Result := True;
    end;

    function CheckCardNo16BB2Y: WordBool;
    const
      map1: array[0..9] of string = ('A6', 'B3', 'EX', 'HG', '5J', 'MI', 'K9',
        'Q4', 'ST', 'XU');
    var
      PART1, PART2: string;
      BCARD: string;
      I, J: INTEGER;
    begin
      Result := False;
      if Length(FCard) <> 16 then
        Exit;
      FCard := UpperCase(FCard);
      PART1 := Copy(FCard, 1, 5);
      PART2 := Copy(FCard, 6, 11);
      PART1 := PART1[5] + PART1[4] + PART1[3] + PART1[2] + PART1[1];
      PART2 := PART2[11] + PART2[10] + PART2[9] + PART2[8] + PART2[7] + PART2[6]
        + PART2[5] + PART2[4] + PART2[3] + PART2[2] + PART2[1];
      BCARD := PART1 + PART2;
      FCYLH := '';
      for I := 0 to 7 do
      begin
        for J := 0 to 9 do
        begin
          if MAP1[J] = Copy(BCARD, I * 2 + 1, 2) then
            FCYLH := FCYLH + IntToStr(J);
        end;
      end;
      if Length(FCYLH) <> 8 then
        EXIT;
      FIType := 0;
      Result := True;
    end;

//����������ҽԺ
    function CheckCardNo16_YZSRMYY: WordBool;
    const
      map1: array[0..9] of string = ('5C', 'BD', 'FA', 'B6', 'C1', 'AD', 'ED',
        'D7', 'CF', '0A');
    var
      BCARD: string;
      I, J: INTEGER;
    begin
      Result := False;
      if Length(FCard) <> 16 then
        Exit;
      FCard := UpperCase(FCard);
      BCARD := Copy(FCard, 10, 7) + Copy(FCard, 1, 9);
      BCARD := BCARD[16] + BCARD[15] + BCARD[14] + BCARD[13] + BCARD[12] + BCARD
        [11] + BCARD[10] + BCARD[9] + BCARD[8] + BCARD[7] + BCARD[6] + BCARD[5]
        + BCARD[4] + BCARD[3] + BCARD[2] + BCARD[1];
      FCYLH := '';
      for I := 0 to 7 do
      begin
        for J := 0 to 9 do
        begin
          if MAP1[J] = Copy(BCARD, I * 2 + 1, 2) then
            FCYLH := FCYLH + IntToStr(J);
        end;
      end;
      if Length(FCYLH) <> 8 then
        EXIT;
      FIType := 0;
      Result := True;
    end;

    function CheckExtCard: Boolean; //�����ⲿ��������COM�Խ�
    var
      Handle: Variant;
    begin
      Handle := CreateOleObject('YxCard.ExtCard');
      Result := False;
      if not Handle.SysInit('') then
      begin
        AERROR := Handle.ERROR;
        Handle := Unassigned;
        Exit;
      end;
      if not Handle.Execute('01', FCard, OutValue) then
      begin
        AERROR := Handle.ERROR;
        Handle := Unassigned;
        Exit;
      end;
      Handle := Unassigned;
      DivideData(FHXX, OutValue);
      FCYLH := FHXX[1];
    //�ֽ�OutValue
    //1���ƿ���|2����|3�Ա�|4���֤��|5�α���|6��������|7������λ|8��ͥ��ַ|9ְҵ|10����||||
//    with FDataSwitch1 do
//    begin
//      SetByFd('CICID', FHXX[1]);
//      SetByFd('CXM', FHXX[2]);
//      SetByFd('CXB', FHXX[3]);
//      SetByFd('CSFZH', FHXX[4]);
//      SetByFd('CYLBX', FHXX[5]);
//      SetByFd('CGZDW', FHXX[7]);
//      SetByFd('CJTDZ', FHXX[8]);
//      SetByFd('CZY', FHXX[9]);
//      SetByFd('CMZ', FHXX[10]);
//      if (FHXX[6] <> '') then
//      begin
//        SetByFd('DCSNY', StrToDateTimeDef(FHXX[6], 0));
//      end;
//      FIType := 0;
//    end;
      Result := True;
    end;

    function CheckExtCard_GA: Boolean; //�����ⲿ��������COM(����)
    var
      Handle: Variant;
    begin
      Result := False;
      Handle := CreateOleObject('YxCard.ExtCard');
      if not Handle.Execute('READCARD', FCard, OutValue) then
      begin
        AERROR := Handle.AERROR;
        Handle := Unassigned;
        Exit;
      end;
      Handle := Unassigned;
      FCYLH := OutValue;
      FIType := 0;
      Result := True;
    end;

    function CheckExtCard_MC2Y: Boolean; //�����ⲿ��������COM(�ɳ�2Ժ)
    var
      Handle: Variant;
    begin
      Result := False;
      Handle := CreateOleObject('YxCard.ExtCard');
      if not Handle.Execute('CHECKCARD', FCard, OutValue) then
      begin
        AERROR := Handle.AERROR;
        Handle := Unassigned;
        Exit;
      end;
      Handle := Unassigned;
      FCYLH := OutValue;
      FIType := 0;
      Result := True;
    end;

    function CheckExtCard_BB2Y: Boolean; //�����ⲿ��������COM(��������Ժ)
    var
      Handle: Variant;
    begin
      Result := False;
      Handle := CreateOleObject('YxExtCard.ExtCard');
      if not Handle.Execute('READCARD', FCard, OutValue) then
      begin
        AERROR := Handle.AERROR;
        Handle := Unassigned;
        Exit;
      end;
      Handle := Unassigned;
      FCYLH := OutValue;
      FIType := 0;
      Result := True;
    end;

    function CheckExtCard_DJY: boolean;
    var
      Handle: Variant;
      FHXX: array[0..100] of string;
      OutValue: WideString;
    begin
      Result := False;
  // ����������ҽ�ƿ�

      Handle := CreateOleObject('YxCard.ExtCard');
      if not Handle.SysInit('') then
      begin
        AERROR := Handle.ERROR;
        Handle := Unassigned;
        Exit;
      end;
  //1������|2����Ա����|3����Ա����|4�û���|5ԭʼ����
      if not Handle.Execute('01||||' + FCard, OutValue) then
      begin
        AERROR := Handle.ERROR;
        Handle := Unassigned;
        Exit;
      end;
      Handle := Unassigned;
      DivideData(FHXX, OutValue);
  //OutValue=ע���־(0:δע��,1:��ע��)|2�߼�����|3��������ID|4һ��ͨ���|5�ſ����
  //|6����|7�Ա�|8��������|9���֤��|10����ID|11����(�ֵ�)ID|
  //12��������|13��ͥסַ|14һ��ͨ״̬|15һ��ͨ״̬˵��|
      if FHXX[1] = '0' then
      begin
        AERROR := '�ÿ�δ������ע��,���ȵ�����ע�ᴰ����ע��ÿ���';
        Exit;
      end;
      Result := True;
    end;

    function CheckBankCard: Integer;
    begin
      Result := 0;
  //���п�����Ϊҽ�ƿ�ʹ��
      if GetYXXTCSI('YHKZWYLKSY', 0) = 0 then
        Exit;
  //HISϵͳ�Ľ������ҺŶ�����ʹ�����п������п���Ϊҽ�ƿ�������ҽͨ�ӿڳ���
  //�������Һ�Ҳ��������������ɣ�������������ҺŴ������
  //ԭ��:�������ӿ�����CICID�ºţ��������п�ƥ�䣬��TBICXXDZ������CSFZH�ֶ�
  //ͬһ�����֤�ſ��Ի��������п���������Ӧһ��CICID�ţ���˸ñ���������CICKMW
  //
      if (StrToIntDef(CTYPE, 0) in [1, 2]) then
        Exit;

      Result := -1;
  //���е�ԭʼ���ŷ���
      csql := 'select CICID from ' + SDBLX +
        '..TBICXXDZ with(nolock) where CICKMW=' + QuotedStr(FCard) + ' ';
      if not ExeSql(QryTemp1, csql, False) then
        Exit;
      if QryTemp1.IsEmpty then
      begin
        Result := 0;
        Exit;
      end;
      FCYLH := QryTemp1.FieldByName('CICID').AsString;
      FIType := 5;
      Result := 1;
    end;
  //���ݸ���

    function CheckExtCard_CZFY: boolean;
    begin
      Result := False;
      if Pos(';', Card) > 0 then
      begin
        Card := Copy(Card, 2, Length(Card) - 2);
      end;
      if Pos('��', Card) > 0 then
      begin
        Card := Copy(Card, 3, Length(Card) - 4);
      end;
    //����9Ϊ
      Card := Addstr(Trim(Card), '0', GetYXXTCSI('YLKMMMRZDCD', 9));
      FCard := Card;
      Result := True;
    end;

  var
    ABool: boolean;
  begin
    Result := 0;
  //vCard=����|������(�������洫��1�������ط������ǿ�)
    DivideData(FHXX, vCard);
    Card := FHXX[1];
    CTYPE := FHXX[2]; //CTYPE:string;//���ͣ�0���Ϊ����,1��Ϊ���� 2:����Һ�(ҽ��վ�Һ�)
    ICallCode := StrToIntDef(CTYPE, 0);
    FCard := Card;

    if GetYXXTCSI('IYLKHCL_CZFY', 0) = 1 then //ҽ�ƿ��Ŵ���_���ݸ���
    begin
      if not CheckExtCard_CZFY then
        exit;
    end;
  // ����������ҽ�ƿ�
    if GetYXXTCSI('USEDJYQYYLK', 0) = 1 then
    begin
    //1Ϊ������2��Ϊ�Һ�
    //����������ҽԺ����ˢ�����Ŀ�ǰ�����12�Ķ�����ʱ��,��ȥ������
      if (StrToIntDef(CTYPE, 0) = 2) and (Copy(FCard, 1, 2) <> '12') then
      begin
//      if not CheckExtCard_DJY then //ҽԺҪ��ҺŲ�ȥ������֤
//      begin
//        Result:=-1;
//        Exit;
//      end;
      end;
    //ҽԺ�ڲ���ҽ�ƿ��Ǽ��ܿ�,��Ҫ����
      if Length(FCard) = 12 then // ����ҽԺ�����뿨
      begin
        FCYLH := Trim(Card);
        CSKKH := FCYLH;
        Result := 1;
        FIType := 0;
        Exit;
      end;
    end;

  //���ӽ�������ʹ��DLL���������ӿڽ���
{  if (GetYXXTCSI('ISYDZJKKDK', 0) = 1) and (Length(FCard) >= 64) then
  begin
    if not CheckExtCard_DZJKK then
    begin
      Result := 2;
      Exit;
    end;
    CSKKH := FCYLH;
    Result := 1;
    FIType := 0;
    //ʹ���˻������ظ�ʹ�ù��ܣ�ȡ���տ���
    result := GetDZKH(ctype);
    Exit;
  end;    }
  //��������Ժҽ�ƿ�������ʹ��ҽԺ�ṩ�Ľ���DLL
    if GetYXXTCSI('IBBEFYYLKJX', 0) = 1 then
    begin
      if not CheckExtCard_BB2Y then
      begin
        Result := 2;
        Exit;
      end;
      CSKKH := FCYLH;
      Result := 1;
      FIType := 0;
    //ʹ���˻������ظ�ʹ�ù��ܣ�ȡ���տ���
      result := GetDZKH(CTYPE);
      Exit;
    end;
  //�ɳǶ�ҽԺ��ҽ��   ���� 00000001=34168430106������=�����룩
    if GetYXXTCSI('MCEYYYYK', 0) = 1 then
    begin
      if not CheckExtCard_MC2Y then
      begin
        Result := 2;
        Exit;
      end;
      CSKKH := FCYLH;
      Result := 1;
      FIType := 0;
    //ʹ���˻������ظ�ʹ�ù��ܣ�ȡ���տ���
      result := GetDZKH(CTYPE);
      Exit;
    end;

  //ʹ�ù���ũ�Ͽ���ҽ�ƿ�
  //ũ�Ͽ���Ϊ7λ���ڿ���ǰ��N��ʾ����
  //ҽԺ�ڲ���ҽ�ƿ��Ǽ��ܿ�,��Ҫ����
    if (GetYXXTCSI('USEGANHK', 0) = 1) and (Length(FCard) >= 37) then
    begin
      if not CheckExtCard_GA then
      begin
        Result := 2;
        Exit;
      end;
      Result := 1;
      CSKKH := FCYLH;
      Exit;
    end;
  //������п�
    case CheckBankCard of
      -1:
        begin
          AERROR := '������п�����';
          Result := -1;
          Exit;
        end;
      1:
        begin //�����п�
          Result := 1;
          FIType := 5;
          Exit;
        end;
      0:
        begin
       //�����п�����δ��TBICXXע������п� ����������
        end;
    end;
    ABool := GetYXXTCSI('UseYLLMK', 0) = 1;
    ABool := ABool and ((Length(Trim(Card)) < GetYXXTCSI('YLKMMMRZDCD', 9) + 1)
      or (GetYXXTCSI('USELQQYYLK', 0) = 1));
  //����**λ��������Ϊ�������뿨  GetYXXTCSI('YLKMMMRZDCD', 9)
    if ABool then //ʹ��ҽ�����뿨
    begin
    //λ��С��8λ����Ϊ����ҽ�ƿ�   YLKMMKYXZXCD:ҽ�ƿ����뿨������С����
      if Length(Trim(Card)) < GetYXXTCSI('YLKMMKYXZXCD', 8) then
      begin
        AERROR := '���ų���С��' + IntToStr(GetYXXTCSI('YLKMMKYXZXCD', 8)) + '����Ϊ�ú��벻��ҽ�ƿ��ţ�';
        Result := -1;
        Exit;
      end;

    // YLKHZDYXSWZD ��ҽ�ƿ��ų�������10λ����
      if (Length(Trim(Card)) = 10) and (GetYXXTCSI('YLKHZDYXSWZD', 0) = 0) then
      begin
        AERROR := '���ų��Ȳ���Ϊ10λ��';
        Result := -1;
        Exit;
      end;
      if Length(Trim(Card)) > 9 then
      begin
        FCYLH := Trim(Card);
        Result := 1;
        FIType := 0;
      //ʹ���˻������ظ�ʹ�ù��ܣ�ȡ���տ���
        result := GetDZKH(CTYPE);
        Exit;
      end
      else
      begin
        FCYLH := Card;
      //�����߿վ�����Ժҽ�ƿ�����
        if GetYXXTCSI('DJYKJLYYYLKJX', 0) = 1 then
        begin
          try
            vHandle := CreateOleObject('YxICCard.Card');
          except
            on E: exception do
            begin
              AERROR := '����ҽ�ƿ��ⲿ����COM����(YxICCard.dll)����:' + e.Message;
              Exit;
            end;
          end;
          if not vHandle.Execute('READCARD', vCard, OutValue) then
          begin
            AERROR := vHandle.AERROR;
            vHandle := Unassigned;
            Exit;
          end;
          vHandle := Unassigned;
          DivideData(FHXX, OutValue);
          FCYLH := FHXX[1];
        end;
      //ҽ�ƿ�����Ĭ����󳤶�
        FCYLH := Addstr(Trim(FCYLH), '0', GetYXXTCSI('YLKMMMRZDCD', 9));
        Result := 1;
        FIType := 0;
      //ʹ���˻������ظ�ʹ�ù��ܣ�ȡ���տ���
        result := getdzkh(CTYPE);
        Exit;
      end;
    end;
    FCYLH := '';
    FIType := -1;
  //��ҽ�Ʊ��պ���Ϊҽ�ƿ���(�½�����)
    if (GetYXXTCSI('YLBXH=YLKH', 0) = 1) and (Length(FCard) in [9, 11, 24, 26]) then
    begin
      if (Length(FCard) = 9) and (not IsAllNumber(FCard)) then
      begin
    //����9λ���ҷǴ����֣���Ϊ�ÿ�Ϊ��˾�Ƽ���ҽ�ƿ����ߺ����⿨���̡�
      end
      else
      begin
        case Length(FCard) of
          9:
            FCYLH := FCard;
          11:
            FCYLH := Copy(FCard, 2, 9);
          24:
            FCYLH := Copy(FCard, 13, 9);
          26:
            FCYLH := Copy(FCard, 14, 9);
        else
          begin
            AERROR := '��ϵͳ��ǰû�жԴ˿��Ľ���֧�֣���ȷ�Ͽ��Ϸ�������ϵ������������';
            Exit;
          end;
        end;
        FIType := 2;
        Result := 1;
        Exit;
      end;
    end;
    case Length(FCard) of
      6:
        begin
          if GetYXXTCSI('AHISTYPE', 0) = 1 then
          begin
            if GetYXXTCSI('CYLKLEN_6', 0) = 1 then
            begin
              FCYLH := FCard;
              FIType := 1
            end;
          end
          else
          begin
            Result := 2;
            AERROR := '��ϵͳ��ǰû�жԴ˿��Ľ���֧�֣���ȷ�Ͽ��Ϸ�������ϵ������������';
            Exit;
          end;
        end;
      9:
        if not CheckCardNo9 then
          Exit;

      10:
        begin
        //ʹ�����ϲƴ�ѧ����
          if GetYXXTCSI('USEXNCDXSK', 0) = 1 then
          begin
            if not CheckExtCard then
            begin
              Result := 2;
              Exit;
            end;
            Result := 1;
            CSKKH := FCYLH;
            Exit;
          end;
          if GetYXXTCSI('YLKSZMFLK', 0) = 1 then //ҽ�ƿ�����ĸ���࿨
          begin
            FCard := Copy(Card, 2, Length(Card) - 1);
            if not CheckCardNo9 then
              Exit;
            FCYLH := UpperCase(Copy(Card, 1, 1)) + FCYLH;
          end
          else
          begin
            Result := 2;
            AERROR := '��ϵͳ��ǰû�жԴ˿��Ľ���֧�֣���ȷ�Ͽ��Ϸ�������ϵ������������';
            Exit;
          end;

        end;
      15, 64:
        begin
          if GetYXXTCSI('AHISTYPE', 0) = 1 then
          begin
            if not CheckCardNo15 then
              Exit;
          end
          else
          begin
            if GetYXXTCSI('IYLKDKMS', 0) = 4 then
            begin
              if not CheckCardNo15DJY then
                Exit;
            end;
          end;
       //��ά����Ϊ���￨
          if (GetYXXTCSI('IEWMZWJZK', 0) = 1) or (GetYXXTCSI('ISYDZJKKDK', 0) = 1) then
          begin
            FCYLH := FCard;
            FIType := 1;
          end;
        end;
      16:
        begin
        //��������ʹ����16λ�����ÿ�
          if GetYXXTCSI('YZSRMYY_YLKJX', 0) = 1 then
          begin
            if not CheckCardNo16_YZSRMYY then
              EXIT;
          end
          else if GetYXXTCSI('IYLKDKMS', 0) = 10 then
          begin
            if not CheckCardNo16BB2Y then
              EXIT;
          end
          else
          begin

            if GetYXXTCSI('YxBank', 0) = 1 then
            begin
              if not CheckCardNo37 then
                Exit;
            end
            else
            begin
              if not DivideCard_TT(FCard) then
              begin
                AERROR := '��ϵͳ��ǰû�жԴ˿��Ľ���֧�֣���ȷ�Ͽ��Ϸ���';
                Exit;
              end;
            end;
          end;
          FIType := 0;
        end;
      32:
        begin
          if not CheckCardNo32 then
            Exit;
          if GetYXXTCSI('AHISTYPE', 0) = 1 then
            FIType := 1;
        end;
      34:
        begin
          if not CheckCardNo34 then
            Exit;
        end;
      24:
        begin
          if ((Copy(FCard, 1, 1) = ':') and (Copy(FCard, 22, 1) = '=')) then
          begin
            FCYLH := Copy(FCard, 13, 9);
            FIType := 2;
         // Exit;
          end;
        end;
      37, 19, 56:
        begin
          if not CheckCardNo37 then
            Exit;
        end;
      40:
        begin
           ////˫��ҽԺ���⴦��
          if not CheckCardNo32 then
            Exit;
        end
    else
      begin
        if GetYXXTCSI('AHISTYPE', 0) = 1 then
        begin
          FCYLH := GetYXXTCSI('AHISIDPART', '') + Addstr(FCard, '0', 9);
          FIType := 1;
          Exit; //�ֹ�¼��ҽ�ƿ�
        end;
        if GetYXXTCSI('G_MANAL_YLKH', 0) = 1 then
        begin // �ֹ�����
          if Length(FCard) > 8 then
          begin
            Result := 2;
            AERROR := '��ҽ�ƿ������ڣ�';
            Exit;
          end;
          if Length(FCard) < 8 then
          begin
            FCard := Addstr(FCard, '0', 8);
          end;

          for I := 1 to Length(FCard) do
          begin
            if not (FCard[I] in ['0'..'9']) then
            begin
              Result := 2;
              AERROR := '��Ч����';
              Exit;
            end;
          end;
          CardNo := StrToInt(FCard);
          FIType := 0;
//        if (CardNo < 1) or (CardNo > MaxManualYlkh) then
//        begin
//          Result := 2;
//          AERROR := '��ϵͳ��ǰû�жԴ˿��Ľ���֧�֣���ȷ�Ͽ��Ϸ�������ϵ������������';
//          Exit;
//        end;
          FCYLH := FCard;
        end
        else
        begin
          Result := 2;
          AERROR := '��ϵͳ��ǰû�жԴ˿��Ľ���֧�֣���ȷ�Ͽ��Ϸ�������ϵ������������';
          Exit;
        end;
      end;
    end;
  //2013-05-16ʹ���µ�ҽ�ƿ�����:ҽ�ƿ��ظ�ʹ�ù���(���ܺ�),����ʱ�����������
    if (GetYXXTCSI('USEYLKCFSY', 0) = 1) and (CTYPE <> '1') then
    begin
    //ʹ��ҽ�ƿ��ظ�ʹ�ù��ܶ࿨��һ  ldk 2018��8��2��    ����ʡʡ��ҽԺ������ʡ��ͯҽԺ��
      if (GetYXXTCSI('USEYLKCFSYDKHY', 0) = 1) then
      begin
      //ũ�����п��ź����֤�ų��ȶ�Ϊ18����Ҫ�������� ��� 2018��12��17��  ��֣������ҽԺ
        if (GetYXXTCSI('USEYLKCFSYDKHYQFYHKH', 0) > 0) and (Length(FCYLH) = 18) then
        begin
          if ValidatePIDnew(FCYLH) = '' then   //Ϊ�ձ�ʾ�����֤
          begin
          //(FCYLH+'��ȡΪ���֤');
          end
          else
          begin
            IBM := GetYXXTCSI('USEYLKCFSYDKHYQFYHKH', 0);
          end;
        end;
        CFCYLH := FCYLH;
        csql := 'select CICID from ' + SDBLX +
          '..TBICXXDZ with(nolock) where IICZT=1 ' + ' and CICKMM' + IntToStr(IBM)
          + '=' + QuotedStr(FCYLH);
        if not ExeSql(QryTemp1, csql, FALSE) then
        begin
          Result := 2;
          AERROR := '��Ч����(δ������������Ϣ)��';
          FCYLH := '';
          Exit;
        end;
        if QryTemp1.IsEmpty then
        begin
          csql := 'select CICID,IICZT from ' + SDBLX +
            '..TBICXXDZ with(nolock) where 1=1 ' + ' and CICKMM' + IntToStr(IBM)
            + '=' + QuotedStr(FCYLH);
          if not ExeSql(QryTemp2, csql, FALSE) then
            Exit;
          case QryTemp2.Fields[1].AsInteger of
            1:
              AERROR := ' ����';
            2:
              AERROR := ' �ÿ��ѹ�ʧ';
            3:
              AERROR := ' �ÿ���ע��';
            4:
              AERROR := ' �ÿ����˿�';
          else
            if GetYXXTCSI('IYLKDZMSDKXSYHK', 0) = 1 then
            begin
              csql := 'SELECT * FROM ' + SDBLX +
                '..TBYLKHKDZ WITH(NOLOCK) WHERE 1=1 AND YYLKH =' + QuotedStr(vCard);
              if not ExeSql(QryTemp1, csql, FALSE) then
                Exit;
              if not QryTemp1.IsEmpty then
              begin
                AERROR := '��ҽ�ƿ��ѻ���,��ʹ���¿���';
              end
              else
                AERROR := ' ��Ч����(δ������������Ϣ)��';
            end
            else
              AERROR := ' ��Ч����(δ������������Ϣ)��';
          end;
          Exit;
        end;
      end
      else
      begin
        csql := 'select CICID from ' + SDBLX +
          '..TBICXXDZ with(nolock) where IICZT=1 and CICKMM=' + QuotedStr(FCYLH);
        if not ExeSql(QryTemp1, csql, FALSE) then
        begin
          Result := 2;
          AERROR := '��Ч����(δ������������Ϣ)';
          FCYLH := '';
          Exit;
        end;
      end;
      FCYLH := QryTemp1.Fields[0].AsString;
    end;
    CSKKH := FCYLH;
    if (GetYXXTCSI('ISYYLKBGGN', 0) = 1) and (CTYPE <> '1') then
    begin
    //ʹ���˶࿨��һ��ǰ���Ѿ���CICID��ֵ����FCYLH,���˿��ľͲ��������µĿ���
    //�࿨��һ��ȡ�¿� ��֣������ҽԺ ldk  2018��12��19��
      if (GetYXXTCSI('USEYLKCFSYDKHYDQXK', 0) > 0) then
      begin
        Result := 1;
        Exit;
      end;
      csql := 'SELECT CICID FROM ' + SDBLX +
        '..tbylkhkdz WITH (NOLOCK) WHERE (XYLKH=''' + FCYLH + ''')';
      if not ExeSql(QryTemp1, csql, FALSE) then
      begin
        RESULT := 2;
      end;
      if not QryTemp1.IsEmpty then //ˢ�¿�
      begin
        FCYLH := QryTemp1.FieldByName('CICID').AsString;
        if FCYLH = '' then
        begin
          AERROR := 'ȡԭ����Ϊ�գ�' + csql;
          Exit;
        end;
      end
      else //ˢ�Ͽ�
      begin
      //��λ������ֶ�CYLKʼ��Ϊԭʼ���ţ��жϲ����������޸ģ�ʹ�ñ�������ж�
      //һ��ͨ����ʹ���Ͽ������������Ͽ���Ϣ����ʹ�ã������������
        if ICallCode = 1 then //Ϊ1������ȥ�飬��������SQL��ѯ�����
        begin
//        CSQL := 'SELECT * FROM TBYKLBGJL WHERE (cylk=' + QuotedStr(FCYLH) + ' AND cbgnr LIKE ''%����ҽ�ƿ�%'')or(cbgnr like ''%����ҽ�ƿ�_' + FCYLH + '%'')';
          csql := 'SELECT * FROM ' + SDBLX + '..TBYLKBDJL WHERE CBDHKH=' +
            QuotedStr(FCYLH);
          if ExeSql(QryTemp1, csql, FALSE) and not QryTemp1.IsEmpty and (GetYXXTCSI
            ('IYKTYXSYLK', 0) <> 1) then
          begin
            AERROR := '��ҽ�ƿ��ѻ���,����ʹ�øÿ���' + csql;
            Exit;
          end;
        end;
      end;

    end;
    Result := 1
  end;

begin
  //vCard=����|������(�������洫��1�������ط������ǿ�)
  QryYLK := TFDQuery.Create(nil);
  QryTemp := TFDQuery.Create(nil);
  QryTemp1 := TFDQuery.Create(nil);
  QryTemp2 := TFDQuery.Create(nil);
  try
    result := -1;
    UserName := GetUserParam('YJJKReadCardYY', '');
    if UserName = '' then
    begin
      AERROR := '����ҽԺ����Ϊ�գ�';
      Exit;
    end;
    DivideData(FHXX, Card);
    vCard := FHXX[1];
    CTYPE := FHXX[2];
    FYSKH := vCard; //�������Ŀǰ��cfrmdataYLK�����ã���Ҫ�Ǵ��������ź�Ŀ��ŷ���ȥ
    CSKLX := 'CICID';
    ATJ := '';

    //2020-08-17 ��ҽ���Ӿ��￨ʱ������(0��ʹ��;1ʹ��)
    if (GetYXXTCSI('IBYDZJZKSJXZ', 0) = 1) then
    begin
      if not CallProTimestampCheck(vCard) then
        exit;
    end;
    //2020-07-18 ly  IBYDMHY ��ҽ�����һ(���֧��/���ӽ�����/���Ӿ��￨)ͳһʹ��һ��.��ά������URL��ַCBRID��CYLH
    //http://cdyxdev.com/pay?CMZH=00001&CBRID=00001&CYLH=ABCDEFGHIJK
    //˫����,������,�Ҷ�ά��http��CYLH�Ž��н�ȡ
    if (GetYXXTCSI('IBYDMHY', 0) = 1)    //  and (AnsiPos('HTTP',UpperCase(vCard))>0)
      and (AnsiPos('CYLH', UpperCase(vCard)) > 0) then
    begin
      tmpList := TStringList.Create;
      try
        DivideData(tmpList, vCard, '&');
        vCard := tmpList.Values['CYLH'];
        if vCard = '' then
        begin
          AERROR := '����Ч�Ŀ����ַ���,��ϸ������鿴��־.';
          AERROR := AERROR + sLineBreak +
            '��������IBYDMHY��,�����ַ�������CYLH=���ŵ��ַ���' + sLineBreak + Card;
          Result := 2;
          Exit;
        end;
      finally
        FreeAndNil(tmpList);
      end;
    end;
    //Ϊ�˷�ֹ����ͨ�Ķ�����ͻ������ֱ�ӵ��ý⿨�ļ��ܴ����ȣ�ֻ�����������Ĳ���������
    if (Length(vCard) >= 35) and (GetYXXTCSI('CDZJKKJMKCD', '') <> '') then
    begin
      if not CheckExtCard_DZJKK(CTYPE) then
        Exit;
    end;

    //������������
    if GetYXXTCSI('IYKTJXKHCLGDF', 0) = 1 then
    begin
      IYKTJXKHCLGDF_TYPE := GetYXXTCSI('IYKTJXKHCLGDF_TYPE', 0);
      if IYKTJXKHCLGDF_TYPE = 0 then
      begin
        //Ӣ��
        if Pos(';', vCard) > 0 then
        begin
          vCard := Copy(vCard, 2, Length(vCard) - 2);
        end;
        //����
        if Pos('��', vCard) > 0 then
        begin
          vCard := Copy(vCard, 3, Length(vCard) - 4);
        end;
      end;
      if IYKTJXKHCLGDF_TYPE = 1 then
      begin
        //Ӣ��
        if Pos(';', vCard) > 0 then
        begin
          vCard := Copy(vCard, 2, Pos('?', vCard) - 2);
        end;
        //����
        if Pos('��', vCard) > 0 then
        begin
          vCard := Copy(vCard, 3, Pos('��', vCard) - 3);
        end;
      end;
      if IYKTJXKHCLGDF_TYPE = 2 then
      begin
        //  VCARD =  %e?;12345678?;e?
        //Ӣ��
        if Pos(';', vCard) > 0 then
        begin
          vCard := Copy(vCard, Pos(';', vCard) + 1, Length(vCard));
          vCard := Copy(vCard, 1, Pos('?', vCard) - 1);
        end;
        //����
        if Pos('��', vCard) > 0 then
        begin
          vCard := Copy(vCard, Pos('��', vCard) + 1, Length(vCard));
          vCard := Copy(vCard, 1, Pos('��', vCard) - 1);
        end;
      end;
      FYSKH := vCard;
    end;
    //һ��ͨ���������Զ��峤�� ��ʽ �ַ�������1$�ַ�����ʼλ��=����|�ַ�������2$�ַ�����ʼλ��=���� add by luowei 2018-11-03
    if GetYXXTCSI('CYKTJXKHZDYCD', '') <> '' then
    begin
      tmpList := TStringList.Create;
      try
        CYKTJXKHZDYCD := GetYXXTCSI('CYKTJXKHZDYCD', '');
        tmpList.Delimiter := '|';
        tmpList.DelimitedText := CYKTJXKHZDYCD;
        for I := 0 to tmpList.Count - 1 do
        begin
          if Length(vCard) = StrToInt(Copy(tmpList[I], 1, Pos('$', tmpList[I]) - 1)) then
          begin
            tmpValue := Copy(tmpList[I], Pos('$', tmpList[I]) + 1, Length(tmpList
              [I]) - Pos('$', tmpList[I]));
            iStart := StrToInt(Copy(tmpValue, 1, Pos('=', tmpValue) - 1));
            iLen := StrToInt(Copy(tmpValue, Pos('=', tmpValue) + 1, Length(tmpValue)
              - Pos('=', tmpValue)));
            vCard := Copy(vCard, iStart, iLen);
            Break;
          end;
        end;
      finally
        FreeAndNil(tmpList);
      end;
      FYSKH := vCard;
    end;

    ///ˢ�������ţ���³�ж��Ƿ�Ϊҽ����ʹ��
    ///  2017-07-06 ҽԺ�������˴���ֵ�Ѿ����ˣ�Ӧ�����Ҽ�������ֵ
    //  GlobValues['CWLKH'].Value := vCard;
    ///

    CBM := '';
    IUSEYLKCFSYDKHY := 0;
    IUSEYLKCFSYDKHY := GetYXXTCSI('USEYLKCFSYDKHY', 0);
    FCard := vCard;
    // ҽ�ƿ������Ž�ȡλ��(�ӵ�1λ��ʼ����ȡNλ��ҽ�ƿ���)
    //��֣�Ͽ�,�¿�����
    if (GetYXXTCSI('IYLKWLKHJQWS', 0) > 0) and (Length(vCard) > GetYXXTCSI('IYLKWLKHJQWS',
      0)) and (pos('===', vCard) <= 0) then
    begin
      vCard := Copy(vCard, 1, GetYXXTCSI('IYLKWLKHJQWS', 0));
      FCard := vCard;
    end;
    //////////////////////////////////// ��ҽԺʹ�ÿ������Ϊ������ǹ�˾�ڲ������´���
    if (GetYXXTCSI('IUSEYLKFL', 0) = 1) then
    begin
      //��³ʡֱҽ���������ƿ�(�ӵڶ�λ��ʼ����^ֹ)  ˢ��ֵλ���������˴���ȡ�̶�ֵ
      if (GetYXXTCSI('IQLSZYBKZZLK', 0) > 0) and (Length(vCard) > GetYXXTCSI('IQLSZYBKZZLK',
        0)) then
      begin
        vCard := Copy(vCard, 1, GetYXXTCSI('IQLSZYBKZZLK', 0));
      end;
      BYLK := FALSE;
      {ԭ�еĶ࿨��һֱ��ͨ����λ�����ҿ��ţ�����ڶ������͵Ŀ���λ����ͬ�������������� ��
      �����ڵĴ���ʽ�� ��tbylkdkms������һ���ֶ� CYLKFLBM �洢��Ӧ��tbylkfl.ibm 2020��1��15��13:25:14}
      if (GetYXXTCSI('USEYLKCFSY', 0) = 1) and (IUSEYLKCFSYDKHY = 1) then
      begin
        vCard := Addstr(Trim(vCard), '0', GetYXXTCSI('YLKMMMRZDCD', 9));
        FCard := vCard;
        if CYLKDKMSBM = '' then
        begin
           {���TBYLKFL���� ����ikws��ͬ�����ǲ���Ա����ͨ���ֶ����� ���������ﱨ��}
          CSQL := 'select IBM from ' + SDBLX +
            '..TBYLKFL with(nolock) where IKWS=' + inttostr(Length(vCard));
          ExeSql(QryYLK, CSQL, FALSE);
          if QryYLK.RecordCount > 1 then
          begin
            AERROR := 'TBYLKFL���ڶ���ikws��ͬ�����ݣ����Ҽ�������';
            Result := 2;
            Exit;
          end;
        end;
        if CYLKDKMSBM <> '' then
        begin
          CSQL := 'select CYLKFLBM from ' + SDBLX +
            '..TBYLKDKMS  with(nolock) WHERE IBM=' + CYLKDKMSBM;
          if not ExeSql(QryYLK, CSQL, FALSE) then
          begin
            AERROR := 'ͨ���������͡�CDKLX(' + CYLKDKMSBM + ')����ȡҽ�ƿ��������ʧ�ܣ�';
            Result := 2;
            Exit;
          end;
          if QryYLK.RecordCount > 1 then
          begin
            AERROR := 'TBYLKDKMS��CYLKFLBM �ظ����ã����飡';
            Result := 2;
            Exit;
          end;
          if not QryYLK.IsEmpty then
          begin
    //        IBM := QryTemp.FieldByName('CYLKFLBM').AsInteger;
            ATJ := ' where IBM=' + QryYLK.FieldByName('CYLKFLBM').asstring;
          end;
          CYLKDKMSBM := '';
        end;
      end;
      CSQL := 'select * from ' + SDBLX + '..TBYLKFL with(nolock) ' + ATJ;
      if not ExeSql(QryYLK, CSQL, FALSE) then
        EXIT;
      with QryYLK do
      begin
        if IsEmpty then
        begin
          AERROR := 'û�н���ҽ�ƿ����࣡';
          Result := 2;
          Exit;
        end;
//        CreateSafeObject(TStringList, vList);
        vList := TStringList.Create;
        try
          First;
          while not Eof do
          begin
            if IUSEYLKCFSYDKHY = 1 then
            begin
              CBM := FieldByName('IBM').AsString + '|';
            end;
            {����CJSLX �ֶε�˵��
            1 �ڲ���
            2���ⲿ��
            3�����֤
            4���籣��
            5�����п�
            }
            //�����ֶ�|��������|����ע=��λ��
            vList.Add(fieldbyname('CJSZD').asstring + '|' + FieldByName('CJSLX').asstring
              + '|' + CBM + StringReplace(FieldByName('CKBZ').asstring, '=', '&',
              [rfReplaceAll]) + '=' + FieldByName('IKWS').AsString);
            Next; //�˴���CKBZ�е�=�滻Ϊ&����Ϊ=���ƻ�LIST�ṹ
          end;
          for I := 0 to vList.Count - 1 do
          begin
            if Length(vCard) <> StrToIntDef(vList.ValueFromIndex[I], 0) then
              Continue;
            BYLK := TRUE; //λ����TBYLKFL�������ã���Ϊ�ǿ����߿�����
            DivideData(FHXX, vList.Names[I]);

            CSKLX := UpperCase(FHXX[1]);
            if IUSEYLKCFSYDKHY = 1 then
            begin
              IBM := StrToIntDef(FHXX[3], 0); //������ FHXX[2] = '1' ֮ǰȡֵ����Ȼ�ֶβ����ڣ��޷���ȡ�ڲ�����
              //��֮ǰ�滻��=��ԭ
              FHXX[4] := StringReplace(FHXX[4], '&', '=', [rfReplaceAll]);
              //�����Ҫ��ȡ�����ַ������� �����籣�� :1066574175=887947985=09  ��CKBZ :*=*=* ��ʽ
              if StringMatches(vCard, FHXX[4]) then
              begin
                vCard := DivideCard;
              end;
            end
            else
            begin
              //��֮ǰ�滻��=��ԭ
              FHXX[3] := StringReplace(FHXX[3], '&', '=', [rfReplaceAll]);
            //�����Ҫ��ȡ�����ַ������� �����籣�� :1066574175=887947985=09  ��CKBZ :*=*=* ��ʽ
              if StringMatches(vCard, FHXX[3]) then
              begin
                vCard := DivideCard;
              end;
            end;
            if FHXX[2] = '1' then //�ڲ���ֱ����������ǰ�ϴ���
            begin
              Continue;
            end;
            vCard := DivBankCard;
            CSKKH := vCard;
            //ʹ�õ��Ӿ��￨����   ���Ӿ��￨���ĵ���17λ�����ܺ���23λ
            if (GetYXXTCSI('USEDZJZK', '') <> '') and (GetYXXTCSI('IDZJZKCD', 23)
              = Length(vCard)) then
            begin
              if not GetDZJZK then
                Exit;
              CSKKH := FCYLH;
              itype := 0;
              result := 1;
              Exit;
            end;

            if CTYPE = '1' then //������Ժ
            begin
              FCYLH := vCard;
              if not MsgInfo(vCard) then
                Exit;
              CSKKH := FCYLH;
              Result := 1;
              EXIT;
            end;

            //˫������һ��ͨ��У�飨1������0�رգ�
            if GetYXXTCSI('ISLQYYKT', 0) = 1 then
            begin
            //ʹ������һ��ͨ��˫��Ԥ�ƻ��� 9λ�籣����16Ϊ�������ƿ���19Ϊ���н�������32λ���ܹ�˾�����ƿ�
            //32λ���߹�˾�ڲ���������������COM�м���Ƿ��Ѵ���TBICXX���������ѯ�����Ƿ�����Ϣ�������ص�����
              //д��������־����������
              CheckExtCard_SL(2, vCard, tmpStr);
              //������Ϣ
              tmpStr := SearchICXX(vCard, FHXX[1], CNYLH);
              if tmpStr = '' then
              begin
                if not CheckExtCard_SL(1, vCard, tmpStr) then
                  EXIT;
              end
              else
              begin
                vCard := tmpStr;
              end;
              if tmpStr = CSKKH then
                CSKKH := '';
            end;
            //
            if (GetYXXTCSI('USEYLKCFSY', 0) = 1) and (GetYXXTCSI('IQLYHKZZLK', 0)
              = 0) then
            begin
              if not GetICXXDZ then
                Exit;
              CSKKH := FCYLH;
              itype := 0;
              result := 1;
              Exit;
            end;
            if (GetYXXTCSI('ISYDZJKKDK', 0) = 1) and (Length(FCard) >= 64) then
            begin
              if not GetDZJKK then
                Exit;
          //ˢ�������ƿղ��߻������
              CSKKH := '';
              itype := 0;
              result := 1;
              Exit;
            end;
            //��ά���ȡ
            if (GetYXXTCSI('IEWMZWJZK', 0) = 1) and ((Length(FCard) >= 64) or (Length
              (FCard) = 15)) then
            begin
              if not GetDZJKK('TBICXXDZ') then
                Exit;
              CSKKH := FCYLH;
              itype := 0;
              result := 1;
              Exit;
            end;
            str := SearchICXX(vCard, FHXX[1], CNYLH);
            FCYLH := str;
           // CSKKH := FCYLH;
            itype := 0;
            result := 1;
            if str = '' then
            begin
              result := 2;
              AERROR := '���������Ҳ�������¼�����ѻ���';
              //���п������ƿ��������������Ŀ�����TBICXX����ʱ����Ϊ����ϵͳ��ʹ�����п����Ŀ�
              if (GetYXXTCSI('IQLYHKZZLK', 0) = 1) then
              begin
                Break; //���˳���������������Ϊ�����������ϵĹҺ�(û��дTBICXX��)
              end;
            end;
            Exit;
            ;
          end;
        finally
          FreeAndNil(vList);
        end;
      end;
      //��TBYLKFL��û��������ã���Ϊ���ǿ���ֱ���˳�
      if not BYLK then
      begin
        AERROR := '��ˢ������δ����ҽ�Ʒ�����в鵽��ƥ��ĳ������ã�';
        exit;
      end;
    end;
    Result := CheckCardNo_YLK(FCard + '|' + CTYPE);

    FCYLKMW := vCard;
    if (Result <> 1) and (GetYXXTCSI('IUSEICCARDDKFS', 0) = 1) and (Trim(ICCardXX)
      <> '') then
    begin
      //ɽ���ɲ��������״�����
      // �⿨�ӿڷ���8λ�������������û�ж�ITYPE��ֵ����ʹ��
      //һ��ͨ����дһ��ͨ��ǣ�����ͼӲ���ǿ�Ƹ���  SY2019��11��21��14:01:28
      itype := GetYXXTCSI('IDKFHMMKSYYKT', 6);
      FCYLH := vCard;
      ICCardXX := '';
      Result := 1;
      Exit;
    end;
//    if (Result <> 1) and (Trim(FCard) = '') then
//    begin
//      //2011-4-18����Ϊ���������ӵģ�ʹ�����֤��ȡҽ�ƿ���Ϣ
//      if (GetYXXTCSI('IEDSFZDYLK', 0) = 1) then
//      begin
//        Result := CheckCardNo_SFZ(vCard);
//      end;
//    end;
  finally

    //��ʹ���ظ�ʹ�ù��ܣ����ｨ��ʱCheckCardNo_YLK�����н������Ÿ���CSKKH��
    //�Һ�����У����CNYLH�Ƚϱ����ѻ������ʴ˴���CSKKH���
    if ((GetYXXTCSI('USEYLKCFSY', 0) = 1) and (CTYPE = '1'))     {�࿨��һ��ҲҪ����}
      or ((GetYXXTCSI('USEYLKCFSY', 0) = 1) and (GetYXXTCSI('USEYLKCFSYDKHY', 0)
      = 1)) then
    begin
      CSKKH := '';
    end;
                                 //ҽ�ƿ�ʹ��Ƶ�ʼ�¼
    if (Result = 1) and (GetYXXTCSI('IYLKSYPLJL', 0) = 1) then
    begin
      CSQL := 'INSERT INTO ' + SDBLX +
        '..TBICXXSYJL (CICID,CXTBH,DSKSJ,CKH) VALUES (' + QuoTedStr(FCYLH) + ','
        + QuoTedStr('40') + ',CONVERT(VARCHAR(100),GETDATE(),120),' + QuoTedStr(vCard)
        + ')';
      ExeSql(QryYLK, CSQL, True); //���ж��Ƿ�ɹ�
    end;
    FreeAndNil(QryYLK);
    FreeAndNil(QryTemp);
    FreeAndNil(QryTemp1);
    FreeAndNil(QryTemp2);
  end;
end;

initialization
  OleInitialize(nil);


finalization
  OleUninitialize;

end.

