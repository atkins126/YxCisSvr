{ Invokable interface ITest }

unit SoapIntf;

interface

uses
  InvokeRegistry, Types, XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IWSYXHIS = interface(IInvokable)
    ['{2FEFD041-C424-4673-8B86-42106004CCE4}']
    function HelloWorld: string;
    function ReadCard(CYLKH: string; CDBLX: string = ''): string;
    function MakeSQD(ILX, IBRLX: Integer; CBRH: string; CMBBH: string = '';
      CZTBM: string = ''; CKDKSBM: string = ''; CKDKSMC: string = ''; CDBLX:
      string = ''; CSTXX: string = ''; CRYLB: string = ''): string;
    function DelSQD(ILX, IBRLX: Integer; const CBRH, CSQDH: string; CDBLX:
      string = ''): string;
    function WriteRegInfo(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM: string; CDBLX:
      string = ''): string;
    function DoCharge(ILX, IBRLX: Integer; CZY, CBRH, CSQDH: string; CMRZXKSBM:
      string = ''; CDBLX: string = ''): string;
    function DoPerForm(ILX, IBRLX: Integer; CBRH, CSQDH: string; CDBLX: string =
      ''): string;
    function DontTransact(IBRLX: Integer; CBRH, CSQDH, CZTBM, CJQYY, CJQCZY,
      CTMH, CJQBM: string; CDBLX: string = ''): string;
    function WriteReport(ILX, IBRLX: Integer; CBRH, CSQDH, CZTBM, XMLDATA:
      string; CDBLX: string = ''): string;
    function ExecCharge(Invalue: string): string;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWSYXHIS));

end.

