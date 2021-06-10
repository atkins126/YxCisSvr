unit uDataClass;

interface

uses
  classes, System.SysUtils, FireDAC.Comp.Client;

type
 ////////////////////����////////////////////////////////
 ///���ﲡ����
  TMZBR = class
  private
  public
     //***********************
    CPYM: string; //ƴ����
    CBRID: string;
    //***********Modify By Huanbang
    CHSMZH: string; //��ʿվ���ùҺŴ����ⲿ�����
    CMZH: string; //����Һ�
    CMZYYH: string; //����ԤԼ��
    CFphHead: string; //��Ʊ��ͷ�ַ���
    CFPH: string; //��Ʊ��
    CKSLSH: string; //������ˮ��
    CDRLSH: string; //������ˮ��
    CYSLSH: string; //ҽ����ˮ��
    IGHZL: Integer; //�Һ��������
    CGHZL: string; //�Һ���������
    CGHFS: string; //�Һŷ�ʽ
    IKSBM: Integer; //���ұ���
    CKSMC: string; //��������
    IYSBM: Integer; //ҽ������
    CYSMC: string; //ҽ������
    CXS: string; //��ʾ��Ϣ,���Һ�����,���ӷ������Ƽ�����
    DGH: TDateTime; //�Һ�����
    DYGH: TDateTime; //ԭ�Һ�ʱ�� ��������ҵ����£����дBTH ----zhm
    CYLH: string; //ҽ�ƺ�
    CXM: string; //��������
    CXB: string; //�����Ա�
    IBRFL: string;
    CBRFL: string;
    CNL: string; //����
    DCSNY: TDateTime; //��������
    CDW: string; //��λ
    CDZ: string; //��ַ
    CJHRXM: string; //�໤������
    CXXBJ: string; //ѧУ�༶
    CSQZZ: string; //����ת��
   // IYH: Integer; //�Żݱ�־
   // IYHBL: Extended; //�Żݱ���
    ISFZL: Integer; //�շ��������
    CSFZL: string; //�շ���������
    MJE: Currency; //�Һ��ܽ��,�����ӷ���
    MZLF: Currency; //���Ʒ�
    MBLF: Currency; //������
    MGHF: Currency; //�ŷ�
    MYLKF: Currency; //ҽ�ƿ���
    CCZYGH: string; //����Ա����
    CCZY: string; //����Ա����
    cyyczygh: string; //ԤԼ����Ա����
    cyyczy: string; //ԤԼ����Ա
    DYY: TDateTime; // ԤԼʱ��
    CSFD: string; //�շѵ���
    IDYCS: Integer; //�������ӡ����
    IXG: Integer; //�޸Ĵ���
    IYXTS: Integer; //�Һ���Ч����
    CBZ: string; //��ע
    CBZ1: string; //��ע
    CYBH: string; //ҽ����
    ISFBZ: Integer; //�Һ��շѱ�־
                                      //0:��û���շ�
                                      //1:���չ���
                                      //2:���չ�����
    CGHKH: string; //�Һſ���
    cmz: string; //����
    CYYFS: string; //ԤԼ��ʽ
    IYBBZ: integer; ///������һЩ�շ����಻����ȡĳЩҩƷ���ر���ҽ���շ����಻���Է�ҩƷ��
    //IHKFS: integer; ����ҺŻ������0û�п���1ҽ�ƿ���2�Һſ�����ҽ�ƿ����Һſ�
    IHKFS: integer;  // ����ֶβ��˺ö�ط���û���ã�ȫ�Ǹ�ֵ��0�������������ϳ�����ҽԺ��������ֶ����뿨�ŹҺŻ���ˢ��  1�ֶ���2ˢ��
    IYLKZL: Integer; //ҽ�ƿ����ͣ���Ӧ����tbylkdkms.ibm
    IFZ: integer; //�����־
    CSFZH: string; //���֤��
    BTYLKF: BOOLEAN;
    CZY: string; //ְҵ
    CLXDH: string; //��ϵ�绰
    CTFCZYGH: string;
    CTFCZYXM: string;
    CFYBM: string; //��Ժ����
    XMList: TStrings;
    IYHKBJ: integer; //�Żݿ����   0 �� 1��
    FYMXBMGH: array of string; //�Һŷ��ö�Ӧ����Ŀ��ϸ���� (2011��5�µ��¼ӵģ��������ϲ��� ��ɭ--2011-11)
    FYLKYH: Double; //ҽ�ƿ��Żݱ���
    BankCOM: string; //����֧����ӿ��ַ���,������дֻ������WebServiceд��
    IYYFS: integer; //-1����ԤԼ��0���绰(���ֳ�ԤԼ)��1���ֳ�ԤԼ
    CMZYSBM: string; //����ҽ�����κ��ҽ������
    CYKTMRZFFSMC: string; // ����һ��ͨĬ��֧����ʽ
    CYKTMRZFFSBM: string; // ����һ��ͨĬ��֧����ʽ
    BTH: boolean;
    CHZLY: string; //������Դ
    BLG: Boolean;  // ����
    BLSTD: boolean; //��ɫͨ��
    IBRJZZT: Integer; //���˾���״̬��0���� 1ȡ������ 2���� 3ȡ������ 4����  5������Ժ�Ǽ�
    CYSPBH: string; //ҽ���Ű��
    IKSZY: Integer; //����רҵ����
    BJZBR: Boolean; //���ﲡ�˱��
    CYSPBHN: string; //��ҽ���Ű��
    CBQJBBM: string; //���鼶�����
    CBQJBMC: string; //���鼶������
    CGJ: string; //����
    CHY: string; //����
    CCSD: string; //������
    CLXRGX: string; //��ϵ�˹�ϵ
    CLXR: string; //��ϵ��
    CLXRDH: string; //��ϵ�˵绰
    CZJMC: string; //֤������
    CZJH: string; //֤����(�ݲ���)
    BJZFP: Boolean; //��׼��ƶ���
    BJHRSFZH: BOOLEAN; //�໤�����֤��
    CFXPG: string; //��������
    CRJBZ: string;
    CYX: string; //���ȱ��  ������ҽԺ���Ȳ���
    CLSTD: string;
    BSMZ: Boolean; //ʵ���Ʊ��
    CTW: string; //����
    BXGYQ: BOOLEAN; //�Ƿ�ȥ���¹�����
    BSYYQ: Boolean; //�Ƿ�ȥ����������
    BFR: Boolean; //�Ƿ���
    function ReadFromQry(AQry: TFDQuery): Boolean;
  end;

  TMZFYMXITEM = class
  private
  public
    IXH: Integer;
    IIXH: integer; //һ��ͨ���ֶ�
    ISFFS: Integer; //�շѷ�ʽ����
    CSFFS: string; //�շѷ�ʽ����
    IGRYH: Double; //�����Żݱ���
    IXMYH: Double; //��Ŀ�Żݱ���
    CXMBM: string; //�շ���Ŀ����
    CXMMC: string; //�շ���Ŀ����
    CDW: string; //�շ���Ŀ��λ
    ISL: Extended; //�շ���Ŀ���� {ZS modify }
    MDJ: Currency; //�շ���Ŀ����
    CZXKSBM: string; //ִ�п��ұ���
    CZXKSMC: string; //ִ�п�������
    CZXRBM: string; //ִ���˱���
    CZXRMC: string; //ִ��������
    IYS: Integer; //����ҽ������
    CYS: string; //����ҽ������
    CJLRGH: string; //��¼�˹���
    CSFD: string; // �շѵ�
    CJZD: string; //���˵�
    CFPH: string; // ��Ʊ��
    MYSJE: Currency; //Ӧ�ս��
    MSSJE: Currency; //ʵ�۽��
    MJZJE: Currency; //���ʽ��
    MSJJZ: Currency; //ʵ�ʼ��ʽ��
    myhje: Currency; //�Żݽ��
    MYHZF: Currency; //����֧��
    MYBZF: Currency; //ҽ�Ʊ���֧��
    DJZRQ: TDateTime; //��������
    DYJZRQ: TDateTime; //ԭ��������
    CBZ: string; //��ע
    CDJH: string; //�շѶ�Ӧ���ݺ�
    MYBZFJE: CURRENCY; ////�Էѽ��
    CHJYF: string; // ����ҩ��(������)
    IHJYF: integer;
    ICWTJ: INTEGER; ///����ͳ�Ʊ���
    IFYTJ: INTEGER; ///����ͳ�Ʊ���
    CCWTJ: string; ///����ͳ�Ʊ���
    CFYTJ: string; ///����ͳ�Ʊ���
    CZHSFXMBM: string; //���ױ���
    CZHSFXMMC: string; //��������
    CSBXX: string;
    //IKS: Integer; //������ұ���
    //CKS: string; //�����������
    CFYLX: string; //��������CF:������JY��飬JC����飬YL:ҽ��ҩҽ��
    BTY: Boolean; //����ҩ���
    BTYTBF: Boolean; //��ҩ�˲��ֱ��
    MTYYE: Currency; //��ҩ���
    MTYJZYE: Currency; //��ҩ�������
    MTYJE: Currency; //��ʱʹ�ã�Ŀǰֻ�в�����ҩʹ�õ�
    MTYJZ: Currency; //��ʱʹ�ã�
    CXCFH: string; //�´�����
    BTF: Boolean; //��Ҫ�˷ѱ��
    BYBJS: boolean; //ҽ��������
    BYBTXJ: boolean; //ҽ�����ʽ�����ֽ���
    BCFSFWFY: Boolean; //�����շ�δ��ҩ��־
    CWPBM: string;  //��Ʒ����
    IWPKC: string; //��Ʒ������(���������@�ֿ�)
    CWPSL: string; //��Ʒ����(���������@�ֿ���IWPKC��Ӧ)
    IWPKW: integer;
    CYSFD: string; //ԭ�շѵ���+ԭ���(��ʱ��)
    CYJZD: string; //ԭ���˵���+ԭ���(��ʱ��)
    CSSBH: string; //�������
    CJZRGH: string; //�����˹���
    CJZR: string; //������
    IYKT: Integer; //һ��ͨ����0��NULL��һ��ͨ���ã�1��һ��ͨ���ã�2��һ��ͨ�ѽ������
    DYKTJS: TDateTime; //һ��ͨ����ʱ��
    ICFYPS: Integer; //����ҩƷ������ʱʹ��
    CSHRMC: string; //�ս���(�ս�ʱд)
    DSHRQ: TDateTime; //�ս�����
    BSH: Boolean; //�Ƿ��ս�
    NTFSL: Currency; //�˷�����(��ʱʹ��)
    MSSTF: Currency; //(��ʱʹ��)
    MJZTF: Currency; //(��ʱʹ��)
    BBFTF: Boolean; //ҽ����Ŀ�����˷�
    CWZPCTXM: string; //��������������
    CWZNBTXM: string; //�����ڲ�������
    IXZJYPKBX: integer; //���Ƽ�ҩƷ�ɱ���
    CHJR: string; //ҽ�ƻ��۲���Ա
    MZFZYBJE: Currency;
    {����Żݽ�� 2019.7.25}
    MYHJETJ: Currency;
    BKSFZT: Boolean; //���շ�״̬
    CDYID: string; //
    CZHXMBM: string; //���ױ���
    CZHXMMC: string; //��������
    constructor Create;
    procedure Clear;
  end;
//���������ϸ����������

  TMZFYMX = class
  private
    AList: TList; //////�洢�շ���ĿLIST
    function GetItem(Index: Integer): TMZFYMXitem;
    function GetSumZJEYS: currency;
    function GetYSZE: currency;
    function GetSSZE: currency;
    function GetJZZE: currency;
    function GetSJJZ: currency;
    function GetYHZE: Currency;
    function GetYBZE: Currency;
    function GetYHJE: Currency;
  public
    ///////////////////////////////////////////
    Aitem: TMZFYMXITEM; /////������ϸ
    ///////////////////////////////////////////
    CTFCF: string;
    CFphHead: string; //��Ʊ��ͷ�ַ���
    CFPH: string; //��Ʊ��
    //CSFD: string; //�շѵ���,�շѵ��ŵ���ֺ�����ŵ������ͬ
    CSQDH: string; //���뵥��
    CMZH: string; //�����
    CYLH: string; //ҽ�ƺ�
    CXM: string; //��������
    CXB: string; //�����Ա�
    CNL: string; //��������
    CPYM: string; //ƴ����
    IBRDW: Integer; //���˵�λ����
    CBRDW: string; //���˵�λ����
    Msfzl: Currency; // �������޸��շ�����ʱ�������Ĳ�
    ISFZL: Integer; //�շ��������
    CSFZL: string; //�շ���������
    IKS: Integer; //������ұ���
    CKS: string; //�����������
    CSFRGH: string; //�շ��˹���
    CSFR: string; //�շ�������
    IJBBM: INTEGER; // �������
    IBJ: INTEGER; // ������־
    IXMFL: INTEGER; //  ��Ŀ����
    MZFJE: currency; //֧���ܽ��
    MGRZHZF: currency; //�����ʻ�֧��
    MXJZF: currency; //�ֽ�֧��
    CYBH: string; //ҽ������ҽ����
    IYBBJ: Integer; //ҽ�����
    COMCLASS: string; //�ӿ����ַ���
    BGRTF: Boolean; //�����˷�
    DJZRQ: TDateTime;
    ITXJ: integer; //�Ƿ񽫼��ʽ���˳��ֽ�
    BCur, BVisited: Boolean;
    BResetIndex: boolean; //�Ƿ����÷��õ����
    BLC: Boolean; //�ڳ��־
    BTYLKF: BOOLEAN; //��ҽ�ƿ���
    CTFCZYGH: string; //�˷Ѳ���Ա����
    CTFCZYXM: string; //�˷Ѳ���Ա����
    CFDBH: string; //�ֵ�����
    ISYKT: Boolean; //һ��ͨ���
    IJS_YKT: Boolean; //һ��ͨ�ѽ�����
    DGH: TDateTime; //������ ��д�ѷ�ҩ������Ϣ�շѵ�
    BankCOM: string; //����֧��COM��
    IBank: integer; //���нӿڱ��
    BBankTX: Boolean; //���нӿ����ֱ��
    CFYBM: string; //��Ժ����
    CFYMC: string; //��Ժ����
    CJSX: string; //������
    BYBAPPBJ: Boolean; //ҽ��APP��ǡ�  903ҽԺ�˷�ʹ��
    CXJKH: string;  // �ֽ𿨿���
    IsLSTDBR: Boolean; //������ɫͨ������
    CSHRBM: string;
    CSHRXM: string;
    BZTDCSF: Boolean;
    property Items[Index: Integer]: TMZFYMXitem read GetItem;
    property MSumZJEYS: currency read GetSumZJEYS;
    property MYSZE: Currency read GetYSZE; //ȡӦ���ܽ��
    property MSSZE: Currency read GetSSZE; //ȡʵ���ܽ��
    property MJZZE: Currency read GetJZZE; //ȡ�����ܽ��
    /// <remarks>
    ///  ʱ�䣺2019��3��23��14:16
    ///  ˵��������Żݽ��
    ///  ��ע���Żݽ� Ӧ�ս�� * (1-��Ŀ�Żݱ���)
    /// </remarks>
    property MYHJE: Currency read GetYHJE;  //ȡ�Ż��ܽ��
    property MSJJZZE: Currency read GetSJJZ; //ȡʵ�ʼ����ܽ��
    property MYHZE: Currency read GetYHZE; //ȡ����֧���ܽ��
    property MYBZE: Currency read GetYBZE; //ȡҽ��֧���ܽ��
    function RoundFloat(F: Double; i: Integer): double;
    /////////////////////////////////////
    constructor Create;
    destructor Destroy; override;

    //////�������Ŀ
    procedure AddItem;
    ////ɾ������Ŀ
    procedure DeleteItem(Index: integer);
    /////// �����������Ŀ
    procedure ClearItems;
    function Count: Integer;
  end;

////////////////////סԺ////////////////////////////////
///  סԺ������
  TZYBR = class
  private
  public
    CZYH: string;       //סԺ��
    IZTJZCS: Integer;   //��;���˴���
    CYLH: string;       //ҽ�ƺ�
    CBAH: string;       //������
    CYBH: string;       //ҽ����
    CBRID: string;      //����ID
    CXM: string;        //����
    CXB: string;        //�Ա�
    CNL: string;        //����
    DCSNY: TDateTime;    //��������
    CGZDW: string;       //������λ
    ISFZL: Integer;      //�շ��������
    CSFZL: string;       //�շ���������
    ISFFS: Integer;       //�շѷ�ʽ����
    CSFFS: string;        //�շѷ�ʽ����
    IZYBQ: Integer;       //סԺ����
    CZYBQ: string;
    IZYKS: Integer;        //סԺ����
    CZYKS: string;
    IMZKS: Integer;        //�������
    CMZKS: string;
    IZYYS: Integer;         //סԺҽ��
    CZYYS: string;
    IMZYS: Integer;         //����ҽ��
    CMZYS: string;
    IZYCW: Integer;          //סԺ��λ
    CZYCW: string;
    MJZXE: Currency;         //�����޶�
    MCKXE: Currency;         //�߿��޶�
    DJZRQ: TDateTime;        //��������
    IWCBJ: Integer;          //�޴����˱��
    CRYCZYGH: string;        //��Ժ����Ա
    CRYCZY: string;
    CCYCZYGH: string;        //��Ժ����Ա
    CCYCZY: string;
    CCZYGHWJZ: string;      //δ���˳�Ժ����Ա
    CCZYWJZ: string;
    CSJH: string;           //��Ժ�վݺ�
    DRYSJ: TDateTime;        //��Ժʱ��
    DCYSJ: TDateTime;        //��Ժʱ��
    DWJZCY: TDateTime;       //δ���˳�Ժʱ��
    CPYM: string;            //ƴ����
    CWBM: string;            //�����
    CFPH: string;            //��Ʊ��
    IRYCS: Integer;          //��Ժ����
    IBCCS: Integer;          //��������
    MBCJE: Currency;        //�������
    ICYJSZL: Integer;       //��Ժ��������
    CBZ: string;             //��ע
    DSCZTJZSJ: TDateTime;    //�ϴ���;����ʱ��
    BDD: Boolean;            //���ñ�� 1�������Ժ
    CDBR: string;            //���������
    MDBJE: Currency;         //�������
    CRYBZ: string;           //��Ժ��ע
    DDJSJ: TDateTime;        //�Ǽ�ʱ��
    CGSBM: string;           //��Ͻ����
    CGSMC: string;
    CSJYSBM: string;        //�ϼ�ҽ��
    CSJYSMC: string;
    CQFYY: string;          //��ԺǷ��ԭ��
    BQFBZ: Boolean;         //Ƿ�ѽ�����
    BJZFP: Boolean;         //��׼��ƶ���
    MYGFY: Currency;        // Ԥ������
    CBRTSBZ: string;         //����������Ϣ
    function ReadFromQry(AQry: TFDQuery): Boolean;
  end;

  TZYFYMXITEM = class
  private
  public
    CJZD: string; //���˵���
    CSFXM: string; //�շ���Ŀ
    CSFXMBM: string; //�շ���Ŀ����
    FSL: double; //����
    CDW: string; //��λ
    MDJ: currency; //����
    FBL: double; //����
    CBZ: string; //��ע
    CDJH: string; //������ϸ��ϵ��
    ICWTJ: integer; //����ͳ�Ʊ���
    IFYTJ: integer; //����ͳ�Ʊ���
    IBATJ: integer; //����ͳ�Ʊ���
    CSYMD: string; //
    CYJZD: string; //ԭ���˵�
    DYJZRQ: TDateTime; //ԭ��������(�˷���ʱ�õ�)
    //IZYYS: integer; //סԺҽ������
    //CZYYS: string; //סԺҽ������
    CQMYS: string; //����ǩ��ҽ��
    ITYPE: integer; //0 ��������Ŀ  1 �������� 2 �����������ӷ�
    CZXKSMC: string; /////ִ�пɿ���
    CZXKSBM: string; /////ִ�п��ұ���
    //IZYKS: Integer; /////סԺ���ұ���
    //CZYKS: string; /////סԺ����
    CXSE: string; ///������
    CZXRBM: string; //ִ���˱���
    CZXRMC: string; //ִ��������
    /////////////////////////////////////////////
    CYBJB: string;
    BTF: Boolean;
    IID: Integer;
    CZHXMBM: string; //�����Ŀ����
    CZHXMMC: string; //�����Ŀ����
    CKDKSBM: string; //�������ұ���
    CKDKSMC: string; //������������
    CLJBH: string; //·�����
    CWPBM: string; //��Ʒ���룺���ʽӿ���ʱ�õ�
    IWPKC: string; //��Ʒ��λ����(�п����Ƕ���������Զ��ŷֿ���)
    IWPKW: Integer; //��Ʒ��λ����
    CWPSL: string; //��Ʒ����(��ʱʹ��)
    CBJFYBZ: string; //���Ƿ��ñ�ע
    /////////////////////////////////////////////
    ITXBJ: integer; //������ (��ʿվ�÷��ü��ʱ��)
    BVisited: Boolean;
    FOBJECT: TOBJECT;
    ILB: Integer; //�Է����0�����ǣ�1�����Էѱ��
    CTXM: string;    //������  ��ʱΪ�����ӵ� 20141127 XL
    CHRPHCXX: string; //hrp�Ĳ���Ϣ  ��ȡhrp�������ĺĲ���Ϣ���ڴ��̵�ʱ���ִ��ؽӿ�
    IYBBJ: INTEGER;
    CYWFYBZ: string;  //Ժ����ñ�־
    CSBXX: string; //�豸��Ϣ
    CNBTXM: string; //��ֵ�Ĳ��ڲ�������
    MJE: Currency;  //ʵ��
    MSJ: currency;  //ʵ�ʼ�
    DYRQ: TDateTime;           //��ӡ����
    ICWBM: string;   //�������
    IFYBM: string;   //���ñ���
    CTFYY: string;   //�˷�ԭ��
    BSH: Boolean;   //�Ƿ����
    CJZBJ: string;  //���˱��
    BMZFY: Boolean;  //�Ƿ��������
    DRQ: TDateTime; //��������
    DDYSJ: TDateTime; //��ӡʱ��
    ISL: double; //����
    CSFR: string; //�շ�Ա����
    CTXR: string; //������
    CSSBH: string; //��������
    CSFRGH: string; //�շ��˹���
    BICUFY: boolean; //ICU����
    CYJTJ: string;
    CCWTJ: string; //����ͳ������
    CFYTJ: string; //����ͳ������

    DYJSHRQ: TDateTime;
    CYJSHRGH: string;
    CYJSHR: string;
    DFYSJ: TDateTime; ///����ʵ��ʱ��
    constructor CREATE;
    procedure Clear;
  end;

  TZYFYMX = class
  private
    FTBFYMX: string; //סԺ������ϸ��
    Alist: TList;
    function GetItem(Index: integer): TZYFYMXITEM;
    function GetZJE: Currency;
    function GetZsj: currency;
  public
    Aitem: TZYFymxitem;
    IID: INTEGER; //��������
    CZYH: string; //סԺ��
    CYLH: string; //ҽ�ƿ���
    CXM: string; //����
    CXB: string; //�Ա�
    CNL: string; //����
    IDYLB: INTEGER; //����������
    CDYLB: string; //�����������

    IZTJZ: INTEGER; //��;���ʴ���
    IZYKS: Integer; /////סԺ���ұ���
    CZYKS: string; /////סԺ��������
    IZYBQ: INTEGER; //סԺ��������
    IDQBQ: Integer; //��ǰסԺ��������(�˷���ʱ��)
    CZYBQ: string; //סԺ��������
    IZYYS: integer; //סԺҽ������
    CZYYS: string; //סԺҽ������
    ////////////////////////////////////////
    //// 2000-12-30  ҽ���ӿ�
    CBAH: string; // ������
    CYBH: string; // ҽ����
    CJYSXHFycd: string; ////�����ֶ�
    CJYSXHFZJS: string; ////�����ֶ�
    IFYTJCODE: INTeGER; ///����ͳ�Ʋ���
    COtherName: string; //����
    BSW: Boolean; //��ʱ��
    DSWSJ: TDateTime; //��ʱ��
    IGCYS: Integer; //
    CGCYS: string; //�ܴ�ҽ��
    CBRCW: string; //���˴�λ
    CZRHSBM: string; //���λ�ʿ����
    CZRHSMC: string; //���λ�ʿ����
    /////////////////////////////////////////

    property Items[Index: integer]: TZYFYMXITEM read GetItem;
    property MZJE: Currency read GETZJE; // �շѵ��ܽ��
    property MZSJ: Currency read GetZsj; // �շѵ���ʵ�ʼ۸�
    constructor Create;
    destructor Destroy; override;
    //////�������Ŀ
    procedure AddItem;
    ////ɾ������Ŀ
    procedure DeleteItem(Index: integer);
    /////// �����������Ŀ
    procedure ClearItems;
    function Count: Integer;
  end;

implementation

constructor TMZFYMXITEM.Create;
begin
  inherited Create;
  ICFYPS := 0;
  MTYJZ := 0;
end;

procedure TMZFYMXITEM.Clear;
begin
  IGRYH := 0; //�����Żݱ���
  IXMYH := 0; //��Ŀ�Żݱ���
  CXMBM := ''; //�շ���Ŀ����
  CXMMC := ''; //�շ���Ŀ����
  CZXRBM := ''; //ִ���˱���
  CZXRMC := ''; //ִ��������
  CDW := ''; //�շ���Ŀ��λ
  ISL := 0.00; //�շ���Ŀ����
  MDJ := 0; //�շ���Ŀ����
  //IKS := 0; //������ұ���
  //CKS := ''; //�����������
  CZXKSBM := '';
  CZXKSMC := '';
  IYS := 0; //����ҽ������
  MYSJE := 0; //Ӧ�ս��
  MSSJE := 0; //ʵ�۽��
  MJZJE := 0; //���ʽ��
  MSJJZ := 0; //ʵ�ʼ��ʽ��
  MYHZF := 0;
  MYBZF := 0;
  DJZRQ := Now; //��������
  CBZ := ''; //��ע
  CDJH := ''; //�շѶ�Ӧ���ݺ�
  CHJYF := '';
  IHJYF := 0;
  MYBZFJE := 0;
  CZHSFXMBM := '';
  CZHSFXMMC := '';
  CSBXX := '';
  IXZJYPKBX := 0;
  BTY := False;
  BTYTBF := False;
  BTF := False;
  MTYYE := 0.0;
  MTYJZYE := 0.0;
  CXCFH := '';
  CJLRGH := '';
  CWPBM := '';
  IWPKC := '0';
  IWPKW := 0;
  CSSBH := '';
  CJZRGH := '';
  CJZR := '';
  IYKT := 0;
  DYKTJS := 0;
  ICFYPS := 0;
  CYSFD := '';
  CYJZD := '';
  DYJZRQ := 0;
  MTYJZ := 0;
end;

constructor TMZFYMX.Create;
var
  CSQL: string;
begin
  inherited Create;
  Alist := TList.Create;
  Aitem := TMZFYMXitem.Create;
end;

destructor TMZFYMX.Destroy;
begin
  Clearitems;
  FreeAndNil(Aitem);
  FreeAndNil(AList);
  inherited Destroy;
end;

function TMZBR.ReadFromQry(AQry: TFDQuery): Boolean;
begin
  Result := False;
  if AQry.IsEmpty then
    Exit;
  if AQry.RecordCount > 1 then
    Exit;
  with AQry do
  begin
    try
      CMZH := FieldByName('CMZH').AsString;
      CBRID := FieldByName('CBRID').AsString;
      CYLH := FieldByName('CYLH').AsString;
      CYBH := FieldByName('CYBH').AsString;
      CXM := FieldByName('CXM').AsString;
      CXB := FieldByName('CXB').AsString;
      CNL := FieldByName('CNL').AsString;
      DCSNY := FieldByName('DCSNY').AsDateTime;
      IKSBM := FieldByName('IKSBM').AsInteger;
      CKSMC := FieldByName('CKSMC').AsString;
      ISFZL := FieldByName('ISFZL').AsInteger;
      CSFZL := FieldByName('CSFZL').AsString;
      IYSBM := FieldByName('IYSBM').AsInteger;
      CYSMC := FieldByName('CYSMC').AsString;
      CPYM := FieldByName('CPYM').AsString;
      DGH := FieldByName('DGH').AsDateTime;
    except
    end;

  end;
  Result := True;
end;

function TMZFYMX.GetItem(Index: Integer): TMZFYMXitem;
begin
  if Index > Alist.count - 1 then
  begin
    result := nil;
    exit
  end;
  result := Tmzfymxitem(AList.Items[Index]);
end;

function TMZFYMX.RoundFloat(F: Double; i: Integer): double;
var
  s: string;
  e: Extended;
begin
  s := '#.' + StringOfChar('0', i);
  e := StrToFloat(FloatToStr(F));
  Result := StrToFloat(FormatFloat(s, e));
end;

function TMZFYMX.GetSumZJEYS: currency;
var
  i: integer;
begin
  result := 0;
  for i := 0 to Alist.count - 1 do
    Result := Result + items[i].mysje;
end;

function TMZFYMX.GetYSZE: currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + Items[I].MYSJE;
  end;
end;

function TMZFYMX.GetJZZE: currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + Items[I].MJZJE;
  end;
end;

function TMZFYMX.GetSSZE: currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + Items[I].MSSJE;
  end;
end;

function TMZFYMX.GetYBZE: Currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + Items[I].MYBZF;
  end;
end;

function TMZFYMX.GetYHJE: Currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + RoundFloat((Items[I].MYSJE * (1 - Items[I].IXMYH * Items[I].IGRYH)),
      2);
  end;
end;

function TMZFYMX.GetYHZE: Currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + Items[I].MYHZF;
  end;
end;

function TMZFYMX.GetSJJZ: currency;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to AList.Count - 1 do
  begin
    Result := Result + Items[I].MSJJZ;
  end;
end;

procedure TMZFYMX.AddItem;
var
  Pos: integer;
begin
  Pos := Alist.IndexOf(Aitem);
  if Pos <> -1 then
  begin
    Aitem := TMZFYMXitem.Create;
    Exit;
  end
  else
  begin
    Alist.Add(Aitem);
    Aitem := TMZFYMXitem.Create;
    exit;
  end;
end;

procedure TMZFYMX.DeleteItem(Index: integer);
var
  pos: integer;
begin
  if (Index >= 0) and (Index <= Alist.Count - 1) then
  begin
    items[Index].Free;
    Alist.Delete(Index);
    alist.Pack;
  end;
end;

procedure TMZFYMX.ClearItems;
var
  i: integer;
begin
  if Alist.IndexOf(Aitem) = -1 then
    Aitem.Free;
  for i := 0 to Alist.Count - 1 do
    TMZFYMXItem(Alist.Items[i]).Free;
  Alist.Clear;
  Alist.Pack;
  aitem := TMZFymxitem.Create;
end;

function TMZFYMX.Count: Integer;
begin
  Result := AList.Count;
end;

constructor TZYFYMXITEM.Create;
begin
  inherited Create;
end;

procedure TZYFYMXITEM.Clear;
begin
  CXSE := '';
  CJZD := ''; //���˵���
  CYJZD := '';
  CSFXMBM := ''; //�շ���Ŀ����
  CSFXM := ''; //�շ���Ŀ����
  FSL := 0.0; //����
  CDW := ''; //��λ
  MDJ := 0.0; //����
  FBL := 0.0; //����
  CBZ := ''; //��ע
  CDJH := ''; //������ϸ��ϵ��
  ICWTJ := 0; //����ͳ�Ʊ���
  IFYTJ := 0; //����ͳ�Ʊ���
  IBATJ := 0; //����ͳ�Ʊ���
  CSYMD := '';
  CYJZD := ''; //ԭ���˵�
  //IZYYS := 0; //סԺҽ������
  //CZYYS := ''; //סԺҽ������

  CQMYS := ''; //����ǩ��ҽ��
  ITYPE := 0; //0 ��������Ŀ  1 �������� 2 �����������ӷ�
  CZXKSMC := ''; /////ִ�пɿ���
  CZXKSBM := ''; /////ִ�п��ұ���
  //IZYKS := 0; /////ִ�п��ұ���
  //CZYKS := ''; /////ִ�пɿ���
  BTF := False;
  CZHXMBM := '';
  CZHXMMC := '';
  BVisited := false;
  CWPBM := '';
  IWPKC := '0';
  IWPKW := 0;
  DYJZRQ := 0;
  ILB := 0;
  CBJFYBZ := '';
  CTXM := '';
  CHRPHCXX := '';
  CYWFYBZ := '';
  CSBXX := '';
  CNBTXM := '';
end;

function TZYFYMX.GetItem(Index: Integer): TZYFYMXITEM;
begin
  if Index > Alist.count - 1 then
  begin
    result := nil;
    exit
  end;
  result := TZYFYMXITEM(AList.Items[Index]);
end;

function TZYFYMX.GetZJE: Currency;
var
  i: integer;
  HJJE: Currency;
begin
  HJJE := 0;
  if Alist.Count = 0 then
  begin
    result := 0;
    exit;
  end;
  for i := 0 to Alist.Count - 1 do
  begin
    HJJE := HJJE + Items[i].MJE;
  end;
  Result := HJJE;
end;

function TZYFYMX.GetZSJ: Currency;
var
  i: integer;
  HJJE: Currency;
begin
  HJJE := 0;
  if Alist.Count = 0 then
  begin
    result := 0;
    exit;
  end;
  for i := 0 to Alist.Count - 1 do
  begin
    HJJE := HJJE + Items[i].MSJ;
  end;
  Result := HJJE;
end;

constructor TZYFYMX.Create;
begin
  inherited Create;
  AList := TList.Create;
  Aitem := TZYFymxItem.CREATE;
  IFYTJCODE := 0;
  COtherName := 'CMC';
end;

destructor TZYFYMX.Destroy;
begin
  ClearItems;
  FreeAndNil(Alist);
  FreeAndNil(Aitem);
  inherited destroy;
end;

procedure TZYFYMX.AddItem;
var
  Pos: integer;
begin
  Pos := Alist.IndexOf(Aitem);
  if Pos <> -1 then
  begin
    Aitem := TZYFYMXitem.Create;
    Exit;
  end
  else
  begin
    Alist.Add(Aitem);
    Aitem := TZYFYMXitem.Create;
    exit;
  end;
end;

procedure TZYFYMX.DeleteItem(Index: integer);
var
  pos: integer;
begin
  if (Index >= 0) and (Index <= Alist.Count - 1) then
  begin
    items[Index].Free;
    Alist.Delete(Index);
    alist.Pack;
  end;
end;

procedure TZYFYMX.ClearItems;
var
  i: integer;
begin
  if alist.IndexOf(Aitem) = -1 then
    aitem.Free;
  for i := 0 to alist.Count - 1 do
    TZYFYMXitem(Alist.Items[i]).free;
  Alist.Clear;
  Alist.Pack;
  aitem := TZYFYMXitem.Create;
end;

function TZYFYMX.Count: Integer;
begin
  Result := Alist.Count;
end;

function TZYBR.ReadFromQry(AQry: TFDQuery): Boolean;
begin
  Result := False;
  if AQry.IsEmpty then
    Exit;
  if AQry.RecordCount > 1 then
    Exit;
  with AQry do
  begin
    try
      CZYH := FieldByName('CZYH').AsString;
      IZTJZCS := FieldByName('IZTJZCS').AsInteger;
      CYLH := FieldByName('CYLH').AsString;
      CBAH := FieldByName('CBAH').AsString;
      CYBH := FieldByName('CYBH').AsString;
      CXM := FieldByName('CXM').AsString;
      CXB := FieldByName('CXB').AsString;
      CNL := FieldByName('CNL').AsString;
      DCSNY := FieldByName('DCSNY').AsDateTime;
      CGZDW := FieldByName('CGZDW').AsString;
      ISFZL := FieldByName('ISFZL').AsInteger;
      CSFZL := FieldByName('CSFZL').AsString;
      ISFFS := FieldByName('ISFFS').AsInteger;
      CSFFS := FieldByName('CSFFS').AsString;
      IZYBQ := FieldByName('IZYBQ').AsInteger;
      CZYBQ := FieldByName('CZYBQ').AsString;
      IZYKS := FieldByName('IZYKS').AsInteger;
      CZYKS := FieldByName('CZYKS').AsString;
      IMZKS := FieldByName('IMZKS').AsInteger;
      CMZKS := FieldByName('CMZKS').AsString;
      IZYYS := FieldByName('IZYYS').AsInteger;
      CZYYS := FieldByName('CZYYS').AsString;
      IMZYS := FieldByName('IMZYS').AsInteger;
      CMZYS := FieldByName('CMZYS').AsString;
      IZYCW := FieldByName('IZYCW').AsInteger;
      CZYCW := FieldByName('CZYCW').AsString;
      MJZXE := FieldByName('MJZXE').AsCurrency;
      MCKXE := FieldByName('MCKXE').AsCurrency;
      DJZRQ := FieldByName('DJZRQ').AsDateTime;
      IWCBJ := FieldByName('IWCBJ').AsInteger;
      CRYCZYGH := FieldByName('CRYCZYGH').AsString;
      CRYCZY := FieldByName('CRYCZY').AsString;
      CCYCZYGH := FieldByName('CCYCZYGH').AsString;
      CCYCZY := FieldByName('CCYCZY').AsString;
      CCZYGHWJZ := FieldByName('CCZYGHWJZ').AsString;
      CCZYWJZ := FieldByName('CCZYWJZ').AsString;
      CSJH := FieldByName('CSJH').AsString;
      DRYSJ := FieldByName('DRYSJ').AsDateTime;
      DCYSJ := FieldByName('DCYSJ').AsDateTime;
      DWJZCY := FieldByName('DWJZCY').AsDateTime;
      CPYM := FieldByName('CPYM').AsString;
      CWBM := FieldByName('CWBM').AsString;
      CFPH := FieldByName('CFPH').AsString;
      IRYCS := FieldByName('IRYCS').AsInteger;
      IBCCS := FieldByName('IBCCS').AsInteger;
      MBCJE := FieldByName('MBCJE').AsCurrency;
      ICYJSZL := FieldByName('ICYJSZL').AsInteger;
      CBZ := FieldByName('CBZ').AsString;
      DSCZTJZSJ := FieldByName('DSCZTJZSJ').AsDateTime;
      BDD := FieldByName('BDD').AsBoolean;
      CDBR := FieldByName('CDBR').AsString;
      MDBJE := FieldByName('MDBJE').AsCurrency;
      CRYBZ := FieldByName('CRYBZ').AsString;
      DDJSJ := FieldByName('DDJSJ').AsDateTime;
      CGSBM := FieldByName('CGSBM').AsString;
      CGSMC := FieldByName('CGSMC').AsString;
      CSJYSBM := FieldByName('CSJYSBM').AsString;
      CSJYSMC := FieldByName('CSJYSMC').AsString;
      CQFYY := FieldByName('CQFYY').AsString;
      BQFBZ := FieldByName('BQFBZ').AsBoolean;
      BJZFP := FieldByName('BJZFP').AsBoolean;
      MYGFY := FieldByName('MYGFY').AsCurrency;
      CBRTSBZ := FieldByName('CBRTSBZ').AsString;
    except
    end;

  end;
  Result := True;
end;

end.

