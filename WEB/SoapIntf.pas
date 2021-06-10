{ Invokable interface ITest }

unit SoapIntf;

interface

uses InvokeRegistry, Types, XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IWSYXHIS = interface(IInvokable)
  ['{2FEFD041-C424-4673-8B86-42106004CCE4}']
    function HelloWorld:String;
    function ReadCard(CYLKH: String;CDBLX:String=''):String;
    function MakeSQD(ILX,IBRLX:Integer;CBRH:String;CMBBH :String = ''; CZTBM :String = '';CKDKSBM:String='';
      CKDKSMC:String='';CDBLX:String='';CSTXX:String='';CRYLB:String=''): String;
    function DelSQD(ILX,IBRLX:Integer;const CBRH,CSQDH: string;CDBLX:string=''):string;
    function WriteRegInfo(ILX,IBRLX: Integer; CBRH,CSQDH,CZTBM: string;CDBLX:String=''):string;
    function DoCharge(ILX,IBRLX:Integer;CZY,CBRH,CSQDH:string;CMRZXKSBM:string = '';CDBLX:String=''): string;
    function DoPerForm(ILX,IBRLX:Integer;CBRH,CSQDH:string;CDBLX:String=''): string;
    function WriteReport(ILX,IBRLX: Integer; CBRH,CSQDH,CZTBM,XMLDATA: string;CDBLX:String=''):String;
    function ExecCharge(Invalue:string): string;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWSYXHIS));

end.

