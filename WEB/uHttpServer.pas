unit uHttpServer;

interface

uses
  SysUtils, IdBaseComponent, IdComponent,uWebModule,
  HTTPApp,UdataYxCisSvr,Variants,
  ActiveX,Windows;
type
  THttpServer = class
  private
    FType: Boolean;

    FStart: Boolean;
    procedure HTTPServerCommandGet(AThread: TIdPeerThread;
      ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo);
  published
   public
    FServer: TIdCustomHTTPServer;  
    constructor Create(aType: Boolean = True);
    destructor Destroy; override;
    function Start: Boolean;
    function Stop: Boolean;
    property BStart: Boolean read FStart;
    function Execute(InXML: IXMLDOMDocument2;out OutValue: WideString):Boolean;
  end;
 var
  aHttpServer: THttpServer;
implementation

const
    Success_Result = '<Result><Code>1</Code><Info>成功</Info></Result>';
    Success_Info = '<Result><Code>1</Code><Info>ResultInfo</Info></Result>';
    Fail_Result = '<Result><Code>0</Code><Info>ErrorInfo</Info></Result>';

{ THttpServer }

constructor THttpServer.Create(aType: Boolean);
begin
  InitializeCriticalSection(cs);
  FType := aType;
  if FType then
  begin
    FServer := TIdHTTPServer.Create(nil);
    TIdHTTPServer(FServer).OnCommandGet := HTTPServerCommandGet;
  end
  else
  begin
    FServer := TIdHTTPWebBrokerBridge.Create(nil);
    TIdHTTPWebBrokerBridge(FServer).RegisterWebModuleClass(THisWebModule);
  end;
  FStart := False;
end;

destructor THttpServer.Destroy;
begin
  DeleteCriticalSection(cs);
  FreeAndNil(cs);
  FreeAndNil(FServer);
  inherited;
end;


procedure THttpServer.HTTPServerCommandGet(AThread: TIdPeerThread;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  aBuff: string;
  OutValue: WideString;
  MainXML: IXMLDOMDocument2;
begin
  try
    EnterCriticalSection(cs);
    OutValue := '';
    WriteYxlog('http:发起请求：'+ARequestInfo.Document);
    if ARequestInfo.Document <> '/IWSYXHis' then
    begin
      OutValue := '你有点调皮哦！不按照文档调！';
      Exit;
    end;
    WriteYxlog('http:请求方式：'+ARequestInfo.Command);
    WriteYxlog('http:请求入参：'+ARequestInfo.UnparsedParams);
    aBuff := UTF8Decode(HTTPDecode(ARequestInfo.UnparsedParams));
    if aBuff = '' then
    begin
      OutValue := '你成功的连通了我的接口！太棒了！';
      Exit;
    end;
    WriteYxlog(aBuff, 'THttpServer.CommandGet');
    try
      OleInitialize(nil);
      if MainXML = nil then MainXML := ComsDOMDocument.Create;
      if not LoadXMLText(MainXML,aBuff) then
      begin
        OutValue := '载入XML错误:'+AERROR+',XML:'+#13#10+aBuff;
        WriteYxlog(OutValue, 'THttpServer.LoadXMLText');
        OutValue := StringToBase64(Utf8Encode(stringreplace(Fail_Result,'ErrorInfo',OutValue,[])));
        Exit;
      end;
      if not Execute(MainXML,OutValue) then
      begin
        OutValue := StringToBase64(Utf8Encode(stringreplace(Fail_Result,'ErrorInfo',OutValue,[])));
        Exit;
      end
      else
      begin
        if OutValue <> '' then
          OutValue := StringToBase64(Utf8Encode(stringreplace(Success_Info,'ResultInfo',OutValue,[])))
        else
          OutValue := StringToBase64(Utf8Encode(Success_Result));
      end;
    finally
      OleUninitialize;
      MainXML := nil;
    end;
  finally
    AResponseInfo.ContentText := OutValue;
    LeaveCriticalSection(cs);
  end;
end;


function THttpServer.Execute(InXML: IXMLDOMDocument2;out OutValue: WideString):Boolean;
const functionname = 'THttpServer.Execute';
var
  RNode: IXMLDOMNode;
  YxCis:TYXSVR;
  Invalue,s:WideString;
begin
  try
    result := False;
    OutValue := '';
    YxCis := TYXSVR.Create(nil);
    with YxCis do
    begin
      if InXML = nil then Exit;
      RNode := InXML.selectSingleNode('MSG');
      if RNode=nil then
      begin
        OutValue := '未找到<MSG>头节点！请检查！'+InXML.xml;
        WriteYXLog(OutValue,FunctionName);
        Exit;
      end;
      if RNode.selectSingleNode('Header') = nil then
      begin
        OutValue := '未找到<Header>节点！请检查！'+InXML.xml;
        WriteYXLog(OutValue,FunctionName);
        Exit;
      end;
      try
        AERROR:='';
        DATABASE:= ADOPool.GetCon(ADOConfig);
        if RNode.selectSingleNode('Header').Text = 'WriteRegInfo' then
        begin
          if not WriteRegInfo(
              StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT,-1),
              StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT,-1),
              VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CSQDH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CZTBM').TEXT,'')
            )
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:= '';
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'MakeSQD' then
        begin
          if not MakeSQD(
              StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT,-1),
              StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT,-1),
              VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CMBBH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CZTBM').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CKDKSBM').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CKDKSMC').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CDBLX').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CSTXX').TEXT,'CSTXX5'),
              VarToStrDef(RNode.selectSingleNode('Body/CRYLB').TEXT,'')
            )
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:=MAKESQDH;
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'DelSQD' then
        begin
          if not DelSQD(
              StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT,-1),
              StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT,-1),
              VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CSQDH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CDBLX').TEXT,'')
            )
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:='';
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'ReadCard' then
        begin
          if not ReadCard(VarToStrDef(RNode.selectSingleNode('Body/CYLKH').TEXT,''))
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:=FReadCardH;
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'DoPerForm' then
        begin
          if not DoPerForm(
              StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT,-1),
              StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT,-1),
              VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CSQDH').TEXT,'')
            )
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:='';
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'DoCharge' then
        begin
          if not DoCharge(
              StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT,-1),
              StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT,-1),
              VarToStrDef(RNode.selectSingleNode('Body/CZY').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CSQDH').TEXT,'')
            )
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:='';
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'WriteReport' then
        begin
          if not WriteReport(
              StrToIntDef(RNode.selectSingleNode('Body/ILX').TEXT,-1),
              StrToIntDef(RNode.selectSingleNode('Body/IBRLX').TEXT,-1),
              VarToStrDef(RNode.selectSingleNode('Body/CBRH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CSQDH').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/CZTBM').TEXT,''),
              VarToStrDef(RNode.selectSingleNode('Body/XMLDATA').TEXT,'')
            )
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:='';
          end;
        end
        else if RNode.selectSingleNode('Header').Text = 'ExecCharge' then
        begin
          Invalue := VarToStrDef(RNode.selectSingleNode('InValue').TEXT,'');
          if not ExecCharge(Invalue,s)
          then
          begin
            WriteYXLog(Get_Errorinfo);
            OutValue:=Get_Errorinfo;
            Exit;
          end
          else
          begin
            OutValue:=s;
          end;
        end
        else
        begin
          OutValue := '未找到相应业务！';
          Exit;
        end;
      except
        on e:exception do
        begin
          WriteYXLog(Get_Errorinfo+','+e.message);
          OutValue:=Get_Errorinfo+','+e.message;
          Exit;
        end
      end;
    end;
  finally
    ADOPool.PutCon(DATABASE);
    FreeAndNil(YxCis);
  end;
  Result := True;
end;

function THttpServer.Start: Boolean;
begin
  Result := False;
  with FServer do
  try
    Active := False;
    Bindings.Clear;
    Active := True;
  except
    on e: Exception do
    begin
     // Errorinfo := '启动Http服务失败' + e.Message;
     // systemLog(Errorinfo, 'THttpServer.Start Error');
      Exit;
    end;
  end;
  Result := True;
end;

function THttpServer.Stop: Boolean;
begin
  //Result := False;
  FServer.Active := False;
  FStart := False;
  Result := True;
end;

end.
