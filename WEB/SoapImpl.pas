{ Invokable implementation File for TTest which implements ITest }

unit SoapImpl;

interface

uses
  InvokeRegistry, Types, XSBuiltIns, SoapIntf, Winapi.Windows, Controls,
  SynCommons,QLog;

type

  { TTest }
  TWSYXHIS = class(TInvokableClass, IWSYXHIS)
  public
    function HelloWorld: string;
    //�⿨    ������ҽ�ƿ���
    function ReadCard(CYLKH: string; CDBLX: string = ''): string;
    //�´����뵥   ���� 0����� 1������|�������� 0������ 1��סԺ|���˺�|ģ����|���ױ���|�������ͣ�Ĭ��Ϊ��
    function MakeSQD(ILX, IBRLX: Integer; CBRH: string; CMBBH: string = '';
      CZTBM: string = ''; CKDKSBM: string = ''; CKDKSMC: string = ''; CDBLX:
      string = ''; CSTXX: string = ''; CRYLB: string = ''): string;
    //ɾ�����뵥  ���� 0����� 1������|�������� 0������ 1��סԺ|���˺�|���뵥��|�������ͣ�Ĭ��Ϊ��
    function DelSQD(ILX, IBRLX: Integer; const CBRH, CSQDH: string; CDBLX:
      string = ''): string;
    //�Ǽ� �������� 0ȡ���Ǽ�1�Ǽ�|�������� 0������ 1��סԺ|���˺�|���뵥��|���ױ���
    function WriteRegInfo(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM: string; CDBLX:
      string = ''): string;
    //���뵥�շ�   ���� 0���˷� 1���շ�|�������� 0������ 1��סԺ|���˺�|���뵥��=���ױ���1,2,3|Ĭ��ִ�п��ұ���
    function DoCharge(ILX, IBRLX: Integer; CZY, CBRH, CSQDH: string; CMRZXKSBM:
      string = ''; CDBLX: string = ''): string;
    //ִ�����뵥   ���� 0��ȡ��ִ�� 1��ִ��|�������� 0������ 1��סԺ|���˺�|���뵥��|���ױ���
    function DoPerForm(ILX, IBRLX: Integer; CBRH, CSQDH: string; CDBLX: string =
      ''): string;
    //���� �������� 0ȡ������1����|�������� 0������ 1��סԺ|���˺�|���뵥��|���ױ���|���浥XML����
    function WriteReport(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, XMLDATA:
      string; CDBLX: string = ''): string;
    //�շ���Ŀ�����շ�
    function ExecCharge(Invalue: string): string;
  end;

implementation

uses
  uDataYxCisSvr, Winapi.Messages, Forms, Soap.EncdDecd, System.SysUtils;

const
  Success_Result = '<Result><Code>1</Code><Info>�ɹ�</Info></Result>';
  Success_Info = '<Result><Code>1</Code><Info>@Info@</Info></Result>';
  Fail_Result = '<Result><Code>0</Code><Info>@Info@</Info></Result>';
  WM_HTTPINFO = WM_USER + 203;


function TWSYXHis.HelloWorld: string;
begin
  Result := '���';
end;

function TWSYXHIS.ReadCard(CYLKH, CDBLX: string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'ReadCard:CYLKH=' + CYLKH + ',CDBLX=' + CDBLX;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.ReadCard(CYLKH, CDBLX) then
        begin
          Result := stringreplace(Fail_Result, '@Info@', Af.AERROR, []);
          Exit;
        end;
        Result := stringreplace(Success_Info, '@Info@', Af.ReadCardH, []);
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := stringreplace(Fail_Result, '@Info@', e.message, []);
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);
  end;
end;

function TWSYXHIS.MakeSQD(ILX, IBRLX: Integer; CBRH, CMBBH, CZTBM, CKDKSBM,
  CKDKSMC, CDBLX, CSTXX, CRYLB: string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'MakeSQD:ILX=' + IntToStr(ILX) + ',IBRLX=' + IntToStr(IBRLX) + ',CBRH='
    + CBRH + ',CMBBH=' + CMBBH + ',CZTBM=' + CZTBM + ',CKDKSBM=' + CKDKSBM +
    ',CKDKSMC=' + CKDKSMC + ',CDBLX=' + CDBLX + ',CSTXX=' + CSTXX + ',CRYLB=' + CRYLB;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if CSTXX = '' then
          CSTXX := 'CSTXX5';
        if not Af.MakeSQD(ILX, IBRLX, CBRH, CMBBH, CZTBM, CKDKSBM, CKDKSMC,
          CDBLX, CSTXX, CRYLB) then
        begin
          Result := stringreplace(Fail_Result, '@Info@', Af.AERROR, []);
          Exit;
        end;
        Result := stringreplace(Success_Info, '@Info@', Af.MAKESQDH, []);
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := stringreplace(Fail_Result, '@Info@', e.message, []);
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);
  end;
end;

function TWSYXHIS.DelSQD(ILX, IBRLX: Integer; const CBRH, CSQDH: string; CDBLX:
  string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'DelSQD:ILX=' + IntToStr(ILX) + ',IBRLX=' + IntToStr(IBRLX) + ',CBRH='
    + CBRH + ',CSQDH=' + CSQDH + ',CDBLX=' + CDBLX;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.DelSQD(ILX, IBRLX, CBRH, CSQDH, CDBLX) then
        begin
          Result := stringreplace(Fail_Result, '@Info@', Af.AERROR, []);
          Exit;
        end;
        Result := Success_Result;
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := stringreplace(Fail_Result, '@Info@', e.message, []);
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);
  end;
end;

function TWSYXHIS.WriteRegInfo(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, CDBLX:
  string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'WriteRegInfo:ILX=' + IntToStr(ILX) + ',IBRLX=' + IntToStr(IBRLX) +
    ',CBRH=' + CBRH + ',CSQDH=' + CSQDH + ',CZTBM=' + CZTBM + ',CDBLX=' + CDBLX;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.WriteRegInfo(ILX, IBRLX, CBRH, CSQDH, CZTBM, CDBLX) then
        begin
          Result := (stringreplace(Fail_Result, '@Info@', Af.AERROR, []));
          Exit;
        end;
        Result := Success_Result;
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := (stringreplace(Fail_Result, '@Info@', e.message, []));
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);

  end;
end;

function TWSYXHIS.DoCharge(ILX, IBRLX: Integer; CZY, CBRH, CSQDH, CMRZXKSBM,
  CDBLX: string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'DoCharge:ILX=' + IntToStr(ILX) + ',IBRLX=' + IntToStr(IBRLX) + ',CZY='
    + CZY + ',CBRH=' + CBRH + ',CSQDH=' + CSQDH + ',CMRZXKSBM=' + CMRZXKSBM +
    ',CDBLX=' + CDBLX;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.DoCharge(ILX, IBRLX, CZY, CBRH, CSQDH, CMRZXKSBM, CDBLX) then
        begin
          Result := (stringreplace(Fail_Result, '@Info@', Af.AERROR, []));
          Exit;
        end;
        Result := Success_Result;
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := (stringreplace(Fail_Result, '@Info@', e.message, []));
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);

  end;
end;

function TWSYXHIS.DoPerForm(ILX, IBRLX: Integer; CBRH, CSQDH, CDBLX: string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'DoPerForm:ILX=' + IntToStr(ILX) + ',IBRLX=' + IntToStr(IBRLX) +
    ',CBRH=' + CBRH + ',CSQDH=' + CSQDH + ',CDBLX=' + CDBLX;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.DoPerForm(ILX, IBRLX, CBRH, CSQDH, CDBLX) then
        begin
          Result := (stringreplace(Fail_Result, '@Info@', Af.AERROR, []));
          Exit;
        end;
        Result := Success_Result;
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := (stringreplace(Fail_Result, '@Info@', e.message, []));
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);
  end;
end;

function TWSYXHIS.WriteReport(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, XMLDATA,
  CDBLX: string): string;
var
  Af: TYXSVR;
  Log: string;
begin
  Log := 'WriteReport:ILX=' + IntToStr(ILX) + ',IBRLX=' + IntToStr(IBRLX) +
    ',CBRH=' + CBRH + ',CSQDH=' + CSQDH + ',CZTBM=' + CZTBM + ',CDBLX=' + CDBLX;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.WriteReport(ILX, IBRLX, CBRH, CSQDH, CZTBM, XMLDATA, CDBLX) then
        begin
          Result := (stringreplace(Fail_Result, '@Info@', Af.AERROR, []));
          Exit;
        end;
        Result := Success_Result;
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := (stringreplace(Fail_Result, '@Info@', e.message, []));
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);
  end;
end;

function TWSYXHIS.ExecCharge(Invalue: string): string;
var
  Af: TYXSVR;
  Log, outValue: string;
begin
  Log := 'ExecCharge:Invalue=' + Invalue;
  Result := Fail_Result;
  try
    try
      Af := TYXSVR.Create(nil);
      try
        if not Af.ExecCharge(Invalue, outValue) then
        begin
          Result := (stringreplace(Fail_Result, '@Info@', Af.AERROR, []));
          Exit;
        end;
        Result := stringreplace(Success_Info, '@Info@', outValue, []);
      finally
        freeandnil(Af);
      end;
    except
      on e: exception do
      begin
        Result := (stringreplace(Fail_Result, '@Info@', e.message, []));
        Exit;
      end;
    end;
  finally
    Log := Log + #13#10 + Result;
    if POS('<Code>0</Code>', Log) > 0 then
    begin
      PostLog(llError,Log);
      PostMessage(Application.MainForm.Handle, WM_HTTPINFO, 0, 2);
    end
    else
      PostLog(llMessage,Log);
  end;
end;

initialization

{ Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TWSYXHIS);

end.

