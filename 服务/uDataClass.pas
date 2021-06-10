unit uDataClass;

interface

uses
  classes, System.SysUtils, FireDAC.Comp.Client;

type
 ////////////////////门诊////////////////////////////////
 ///门诊病人类
  TMZBR = class
  private
  public
     //***********************
    CPYM: string; //拼音码
    CBRID: string;
    //***********Modify By Huanbang
    CHSMZH: string; //护士站调用挂号传给外部门诊号
    CMZH: string; //门诊挂号
    CMZYYH: string; //门诊预约号
    CFphHead: string; //发票号头字符串
    CFPH: string; //发票号
    CKSLSH: string; //科室流水号
    CDRLSH: string; //当日流水号
    CYSLSH: string; //医生流水号
    IGHZL: Integer; //挂号种类编码
    CGHZL: string; //挂号种类名称
    CGHFS: string; //挂号方式
    IKSBM: Integer; //科室编码
    CKSMC: string; //科室名称
    IYSBM: Integer; //医生编码
    CYSMC: string; //医生名称
    CXS: string; //显示信息,含挂号名称,附加费用名称及费用
    DGH: TDateTime; //挂号日期
    DYGH: TDateTime; //原挂号时间 解决不能找到跨月，年回写BTH ----zhm
    CYLH: string; //医疗号
    CXM: string; //病人姓名
    CXB: string; //病人性别
    IBRFL: string;
    CBRFL: string;
    CNL: string; //年龄
    DCSNY: TDateTime; //出生年月
    CDW: string; //单位
    CDZ: string; //地址
    CJHRXM: string; //监护人姓名
    CXXBJ: string; //学校班级
    CSQZZ: string; //社区转诊
   // IYH: Integer; //优惠标志
   // IYHBL: Extended; //优惠比例
    ISFZL: Integer; //收费种类编码
    CSFZL: string; //收费种类名称
    MJE: Currency; //挂号总金额,含附加费用
    MZLF: Currency; //诊疗费
    MBLF: Currency; //病历费
    MGHF: Currency; //号费
    MYLKF: Currency; //医疗卡费
    CCZYGH: string; //操作员工号
    CCZY: string; //操作员名称
    cyyczygh: string; //预约操作员工号
    cyyczy: string; //预约操作员
    DYY: TDateTime; // 预约时间
    CSFD: string; //收费单号
    IDYCS: Integer; //处方笺打印次数
    IXG: Integer; //修改次数
    IYXTS: Integer; //挂号有效天数
    CBZ: string; //备注
    CBZ1: string; //备注
    CYBH: string; //医保号
    ISFBZ: Integer; //挂号收费标志
                                      //0:还没有收费
                                      //1:已收过费
                                      //2:已收过处方
    CGHKH: string; //挂号卡号
    cmz: string; //民族
    CYYFS: string; //预约方式
    IYBBZ: integer; ///用限制一些收费种类不能收取某些药品，特别是医保收费种类不收自费药品等
    //IHKFS: integer; 门诊挂号划卡标记0没有卡，1医疗卡，2挂号卡或用医疗卡作挂号卡
    IHKFS: integer;  // 这个字段查了好多地方都没有用，全是赋值的0，我用它来存南充身心医院提出的是手动输入卡号挂号还是刷卡  1手动，2刷卡
    IYLKZL: Integer; //医疗卡类型，对应的是tbylkdkms.ibm
    IFZ: integer; //复诊标志
    CSFZH: string; //身份证号
    BTYLKF: BOOLEAN;
    CZY: string; //职业
    CLXDH: string; //联系电话
    CTFCZYGH: string;
    CTFCZYXM: string;
    CFYBM: string; //分院编码
    XMList: TStrings;
    IYHKBJ: integer; //优惠卡标记   0 否 1是
    FYMXBMGH: array of string; //挂号费用对应的项目明细编码 (2011年5月邓勇加的，现在作废不用 张森--2011-11)
    FYLKYH: Double; //医疗卡优惠比例
    BankCOM: string; //银行支付类接口字符串,主程序不写只读（由WebService写）
    IYYFS: integer; //-1：非预约；0：电话(非现场预约)，1：现场预约
    CMZYSBM: string; //门诊医生诊治后的医生编码
    CYKTMRZFFSMC: string; // 门诊一卡通默认支付方式
    CYKTMRZFFSBM: string; // 门诊一卡通默认支付方式
    BTH: boolean;
    CHZLY: string; //病人来源
    BLG: Boolean;  // 留观
    BLSTD: boolean; //绿色通道
    IBRJZZT: Integer; //病人就诊状态：0待诊 1取消接诊 2接诊 3取消已诊 4已诊  5急诊离院登记
    CYSPBH: string; //医生排班号
    IKSZY: Integer; //科室专业编码
    BJZBR: Boolean; //急诊病人标记
    CYSPBHN: string; //新医生排班号
    CBQJBBM: string; //病情级别编码
    CBQJBMC: string; //病情级别名称
    CGJ: string; //国籍
    CHY: string; //婚姻
    CCSD: string; //出生地
    CLXRGX: string; //联系人关系
    CLXR: string; //联系人
    CLXRDH: string; //联系人电话
    CZJMC: string; //证件名称
    CZJH: string; //证件号(暂不用)
    BJZFP: Boolean; //精准扶贫标记
    BJHRSFZH: BOOLEAN; //监护人身份证号
    CFXPG: string; //风险评估
    CRJBZ: string;
    CYX: string; //优先标记  三亚中医院优先病人
    CLSTD: string;
    BSMZ: Boolean; //实名制标记
    CTW: string; //体温
    BXGYQ: BOOLEAN; //是否去过新冠疫区
    BSYYQ: Boolean; //是否去过鼠疫疫区
    BFR: Boolean; //是否发热
    function ReadFromQry(AQry: TFDQuery): Boolean;
  end;

  TMZFYMXITEM = class
  private
  public
    IXH: Integer;
    IIXH: integer; //一卡通虚字段
    ISFFS: Integer; //收费方式编码
    CSFFS: string; //收费方式名称
    IGRYH: Double; //个人优惠比例
    IXMYH: Double; //项目优惠比例
    CXMBM: string; //收费项目编码
    CXMMC: string; //收费项目名称
    CDW: string; //收费项目单位
    ISL: Extended; //收费项目数量 {ZS modify }
    MDJ: Currency; //收费项目单价
    CZXKSBM: string; //执行科室编码
    CZXKSMC: string; //执行科室名称
    CZXRBM: string; //执行人编码
    CZXRMC: string; //执行人名称
    IYS: Integer; //申请医生编码
    CYS: string; //申请医生名称
    CJLRGH: string; //记录人工号
    CSFD: string; // 收费单
    CJZD: string; //记账单
    CFPH: string; // 发票号
    MYSJE: Currency; //应收金额
    MSSJE: Currency; //实价金额
    MJZJE: Currency; //记帐金额
    MSJJZ: Currency; //实际记帐金额
    myhje: Currency; //优惠金额
    MYHZF: Currency; //银行支付
    MYBZF: Currency; //医疗保险支付
    DJZRQ: TDateTime; //记账日期
    DYJZRQ: TDateTime; //原记账日期
    CBZ: string; //备注
    CDJH: string; //收费对应单据号
    MYBZFJE: CURRENCY; ////自费金额
    CHJYF: string; // 划价药房(辅助用)
    IHJYF: integer;
    ICWTJ: INTEGER; ///财务统计编码
    IFYTJ: INTEGER; ///费用统计编码
    CCWTJ: string; ///财务统计编码
    CFYTJ: string; ///费用统计编码
    CZHSFXMBM: string; //组套编码
    CZHSFXMMC: string; //组套名称
    CSBXX: string;
    //IKS: Integer; //申请科室编码
    //CKS: string; //申请科室名称
    CFYLX: string; //费用类型CF:处方，JY检查，JC：检查，YL:医疗药医嘱
    BTY: Boolean; //已退药标记
    BTYTBF: Boolean; //退药退部分标记
    MTYYE: Currency; //退药余额
    MTYJZYE: Currency; //退药记帐余额
    MTYJE: Currency; //临时使用，目前只有部分退药使得到
    MTYJZ: Currency; //临时使用，
    CXCFH: string; //新处方号
    BTF: Boolean; //需要退费标记
    BYBJS: boolean; //医保结算标记
    BYBTXJ: boolean; //医保记帐金额退现金标记
    BCFSFWFY: Boolean; //处方收费未发药标志
    CWPBM: string;  //物品编码
    IWPKC: string; //物品库存编码(多个批次以@分开)
    CWPSL: string; //物品数量(多个批次以@分开与IWPKC对应)
    IWPKW: integer;
    CYSFD: string; //原收费单号+原序号(临时用)
    CYJZD: string; //原记账单号+原序号(临时用)
    CSSBH: string; //手术编号
    CJZRGH: string; //记账人工号
    CJZR: string; //记账人
    IYKT: Integer; //一卡通费用0或NULL非一卡通费用，1：一卡通费用，2：一卡通已结算费用
    DYKTJS: TDateTime; //一卡通结算时间
    ICFYPS: Integer; //处方药品数，临时使用
    CSHRMC: string; //日结编号(日结时写)
    DSHRQ: TDateTime; //日结日期
    BSH: Boolean; //是否日结
    NTFSL: Currency; //退费数量(临时使用)
    MSSTF: Currency; //(临时使用)
    MJZTF: Currency; //(临时使用)
    BBFTF: Boolean; //医疗项目部分退费
    CWZPCTXM: string; //物资批次条形码
    CWZNBTXM: string; //物资内部条形码
    IXZJYPKBX: integer; //限制级药品可报销
    CHJR: string; //医疗划价操作员
    MZFZYBJE: Currency;
    {体检优惠金额 2019.7.25}
    MYHJETJ: Currency;
    BKSFZT: Boolean; //可收费状态
    CDYID: string; //
    CZHXMBM: string; //组套编码
    CZHXMMC: string; //组套名称
    constructor Create;
    procedure Clear;
  end;
//门诊费用明细的声明部分

  TMZFYMX = class
  private
    AList: TList; //////存储收费项目LIST
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
    Aitem: TMZFYMXITEM; /////费用明细
    ///////////////////////////////////////////
    CTFCF: string;
    CFphHead: string; //发票号头字符串
    CFPH: string; //发票号
    //CSFD: string; //收费单号,收费单号的年分和门诊号的年分相同
    CSQDH: string; //申请单号
    CMZH: string; //门诊号
    CYLH: string; //医疗号
    CXM: string; //病人姓名
    CXB: string; //病人性别
    CNL: string; //病人年龄
    CPYM: string; //拼音码
    IBRDW: Integer; //病人单位编码
    CBRDW: string; //病人单位名称
    Msfzl: Currency; // 用于在修改收费种类时，产生的差额。
    ISFZL: Integer; //收费种类编码
    CSFZL: string; //收费种类名称
    IKS: Integer; //申请科室编码
    CKS: string; //申请科室名称
    CSFRGH: string; //收费人工号
    CSFR: string; //收费人名称
    IJBBM: INTEGER; // 级别编码
    IBJ: INTEGER; // 保健标志
    IXMFL: INTEGER; //  项目分类
    MZFJE: currency; //支付总金额
    MGRZHZF: currency; //个人帐户支付
    MXJZF: currency; //现金支付
    CYBH: string; //医保病人医保号
    IYBBJ: Integer; //医保标记
    COMCLASS: string; //接口类字符串
    BGRTF: Boolean; //隔日退费
    DJZRQ: TDateTime;
    ITXJ: integer; //是否将记帐金额退成现金
    BCur, BVisited: Boolean;
    BResetIndex: boolean; //是否重置费用的序号
    BLC: Boolean; //邻冲标志
    BTYLKF: BOOLEAN; //退医疗卡费
    CTFCZYGH: string; //退费操作员工号
    CTFCZYXM: string; //退费操作员姓名
    CFDBH: string; //分单编码
    ISYKT: Boolean; //一卡通标记
    IJS_YKT: Boolean; //一卡通已结算标记
    DGH: TDateTime; //急诊用 回写已发药处方信息收费单
    BankCOM: string; //银行支付COM类
    IBank: integer; //银行接口标记
    BBankTX: Boolean; //银行接口退现标记
    CFYBM: string; //分院编码
    CFYMC: string; //分院名称
    CJSX: string; //介绍信
    BYBAPPBJ: Boolean; //医保APP标记。  903医院退费使用
    CXJKH: string;  // 现金卡卡号
    IsLSTDBR: Boolean; //西藏绿色通道病人
    CSHRBM: string;
    CSHRXM: string;
    BZTDCSF: Boolean;
    property Items[Index: Integer]: TMZFYMXitem read GetItem;
    property MSumZJEYS: currency read GetSumZJEYS;
    property MYSZE: Currency read GetYSZE; //取应收总金额
    property MSSZE: Currency read GetSSZE; //取实收总金额
    property MJZZE: Currency read GetJZZE; //取记帐总金额
    /// <remarks>
    ///  时间：2019年3月23日14:16
    ///  说明：获得优惠金额
    ///  备注：优惠金额： 应收金额 * (1-项目优惠比例)
    /// </remarks>
    property MYHJE: Currency read GetYHJE;  //取优惠总金额
    property MSJJZZE: Currency read GetSJJZ; //取实际记帐总金额
    property MYHZE: Currency read GetYHZE; //取银行支付总金额
    property MYBZE: Currency read GetYBZE; //取医保支付总金额
    function RoundFloat(F: Double; i: Integer): double;
    /////////////////////////////////////
    constructor Create;
    destructor Destroy; override;

    //////添加子项目
    procedure AddItem;
    ////删除子项目
    procedure DeleteItem(Index: integer);
    /////// 清除所有子项目
    procedure ClearItems;
    function Count: Integer;
  end;

////////////////////住院////////////////////////////////
///  住院病人类
  TZYBR = class
  private
  public
    CZYH: string;       //住院号
    IZTJZCS: Integer;   //中途结账次数
    CYLH: string;       //医疗号
    CBAH: string;       //病案号
    CYBH: string;       //医保号
    CBRID: string;      //病人ID
    CXM: string;        //姓名
    CXB: string;        //性别
    CNL: string;        //年龄
    DCSNY: TDateTime;    //出生年月
    CGZDW: string;       //工作单位
    ISFZL: Integer;      //收费种类编码
    CSFZL: string;       //收费种类名称
    ISFFS: Integer;       //收费方式编码
    CSFFS: string;        //收费方式名称
    IZYBQ: Integer;       //住院病区
    CZYBQ: string;
    IZYKS: Integer;        //住院科室
    CZYKS: string;
    IMZKS: Integer;        //门诊科室
    CMZKS: string;
    IZYYS: Integer;         //住院医生
    CZYYS: string;
    IMZYS: Integer;         //门诊医生
    CMZYS: string;
    IZYCW: Integer;          //住院床位
    CZYCW: string;
    MJZXE: Currency;         //记账限额
    MCKXE: Currency;         //催款限额
    DJZRQ: TDateTime;        //结账日期
    IWCBJ: Integer;          //无床病人标记
    CRYCZYGH: string;        //入院操作员
    CRYCZY: string;
    CCYCZYGH: string;        //出院操作员
    CCYCZY: string;
    CCZYGHWJZ: string;      //未结账出院操作员
    CCZYWJZ: string;
    CSJH: string;           //出院收据号
    DRYSJ: TDateTime;        //入院时间
    DCYSJ: TDateTime;        //出院时间
    DWJZCY: TDateTime;       //未结账出院时间
    CPYM: string;            //拼音码
    CWBM: string;            //五笔码
    CFPH: string;            //发票号
    IRYCS: Integer;          //入院次数
    IBCCS: Integer;          //包床床数
    MBCJE: Currency;        //包床金额
    ICYJSZL: Integer;       //出院结算种类
    CBZ: string;             //备注
    DSCZTJZSJ: TDateTime;    //上次中途结账时间
    BDD: Boolean;            //调用标记 1：申请出院
    CDBR: string;            //最近担保人
    MDBJE: Currency;         //担保金额
    CRYBZ: string;           //入院备注
    DDJSJ: TDateTime;        //登记时间
    CGSBM: string;           //管辖病区
    CGSMC: string;
    CSJYSBM: string;        //上级医生
    CSJYSMC: string;
    CQFYY: string;          //出院欠费原因
    BQFBZ: Boolean;         //欠费结算标记
    BJZFP: Boolean;         //精准扶贫标记
    MYGFY: Currency;        // 预估费用
    CBRTSBZ: string;         //病人特殊信息
    function ReadFromQry(AQry: TFDQuery): Boolean;
  end;

  TZYFYMXITEM = class
  private
  public
    CJZD: string; //记账单号
    CSFXM: string; //收费项目
    CSFXMBM: string; //收费项目编码
    FSL: double; //数量
    CDW: string; //单位
    MDJ: currency; //单价
    FBL: double; //比例
    CBZ: string; //备注
    CDJH: string; //费用明细关系号
    ICWTJ: integer; //财务统计编码
    IFYTJ: integer; //费用统计编码
    IBATJ: integer; //病案统计编码
    CSYMD: string; //
    CYJZD: string; //原记账单
    DYJZRQ: TDateTime; //原记帐日期(退费临时用到)
    //IZYYS: integer; //住院医生编码
    //CZYYS: string; //住院医生名称
    CQMYS: string; //费用签名医生
    ITYPE: integer; //0 非联网项目  1 联网处方 2 联网处方附加费
    CZXKSMC: string; /////执行可科室
    CZXKSBM: string; /////执行科室编码
    //IZYKS: Integer; /////住院科室编码
    //CZYKS: string; /////住院科室
    CXSE: string; ///新生儿
    CZXRBM: string; //执行人编码
    CZXRMC: string; //执行人名称
    /////////////////////////////////////////////
    CYBJB: string;
    BTF: Boolean;
    IID: Integer;
    CZHXMBM: string; //组合项目编码
    CZHXMMC: string; //组合项目名称
    CKDKSBM: string; //开单科室编码
    CKDKSMC: string; //开单科室名称
    CLJBH: string; //路径编号
    CWPBM: string; //物品编码：物资接口临时用到
    IWPKC: string; //物品库位编码(有可能是多个库存编码以逗号分开的)
    IWPKW: Integer; //物品库位编码
    CWPSL: string; //物品数量(临时使用)
    CBJFYBZ: string; //补记费用备注
    /////////////////////////////////////////////
    ITXBJ: integer; //特项标记 (护士站用费用检查时用)
    BVisited: Boolean;
    FOBJECT: TOBJECT;
    ILB: Integer; //自费类别：0：不是，1：是自费标记
    CTXM: string;    //条形码  暂时为六安加的 20141127 XL
    CHRPHCXX: string; //hrp耗材信息  获取hrp返回来的耗材信息，在存盘的时候又传回接口
    IYBBJ: INTEGER;
    CYWFYBZ: string;  //院外费用标志
    CSBXX: string; //设备信息
    CNBTXM: string; //高值耗材内部条形码
    MJE: Currency;  //实价
    MSJ: currency;  //实际价
    DYRQ: TDateTime;           //打印日期
    ICWBM: string;   //财务编码
    IFYBM: string;   //费用编码
    CTFYY: string;   //退费原因
    BSH: Boolean;   //是否审核
    CJZBJ: string;  //结账标记
    BMZFY: Boolean;  //是否门诊费用
    DRQ: TDateTime; //记帐日期
    DDYSJ: TDateTime; //打印时间
    ISL: double; //数量
    CSFR: string; //收费员名称
    CTXR: string; //特许人
    CSSBH: string; //手术编码
    CSFRGH: string; //收费人工号
    BICUFY: boolean; //ICU费用
    CYJTJ: string;
    CCWTJ: string; //财务统计名称
    CFYTJ: string; //费用统计名称

    DYJSHRQ: TDateTime;
    CYJSHRGH: string;
    CYJSHR: string;
    DFYSJ: TDateTime; ///费用实际时间
    constructor CREATE;
    procedure Clear;
  end;

  TZYFYMX = class
  private
    FTBFYMX: string; //住院费用明细表
    Alist: TList;
    function GetItem(Index: integer): TZYFYMXITEM;
    function GetZJE: Currency;
    function GetZsj: currency;
  public
    Aitem: TZYFymxitem;
    IID: INTEGER; //记账批号
    CZYH: string; //住院号
    CYLH: string; //医疗卡号
    CXM: string; //姓名
    CXB: string; //性别
    CNL: string; //年龄
    IDYLB: INTEGER; //待遇类别编码
    CDYLB: string; //待遇类别名称

    IZTJZ: INTEGER; //中途结帐次数
    IZYKS: Integer; /////住院科室编码
    CZYKS: string; /////住院科室名称
    IZYBQ: INTEGER; //住院病区编码
    IDQBQ: Integer; //当前住院病区编码(退费临时用)
    CZYBQ: string; //住院病区名称
    IZYYS: integer; //住院医生编码
    CZYYS: string; //住院医生名称
    ////////////////////////////////////////
    //// 2000-12-30  医保接口
    CBAH: string; // 病案号
    CYBH: string; // 医保号
    CJYSXHFycd: string; ////缓冲字段
    CJYSXHFZJS: string; ////缓冲字段
    IFYTJCODE: INTeGER; ///费用统计参数
    COtherName: string; //别名
    BSW: Boolean; //临时用
    DSWSJ: TDateTime; //临时用
    IGCYS: Integer; //
    CGCYS: string; //管床医生
    CBRCW: string; //病人床位
    CZRHSBM: string; //责任护士编码
    CZRHSMC: string; //责任护士姓名
    /////////////////////////////////////////

    property Items[Index: integer]: TZYFYMXITEM read GetItem;
    property MZJE: Currency read GETZJE; // 收费单总金额
    property MZSJ: Currency read GetZsj; // 收费单总实际价格
    constructor Create;
    destructor Destroy; override;
    //////添加子项目
    procedure AddItem;
    ////删除子项目
    procedure DeleteItem(Index: integer);
    /////// 清除所有子项目
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
  IGRYH := 0; //个人优惠比例
  IXMYH := 0; //项目优惠比例
  CXMBM := ''; //收费项目编码
  CXMMC := ''; //收费项目名称
  CZXRBM := ''; //执行人编码
  CZXRMC := ''; //执行人名称
  CDW := ''; //收费项目单位
  ISL := 0.00; //收费项目数量
  MDJ := 0; //收费项目单价
  //IKS := 0; //申请科室编码
  //CKS := ''; //申请科室名称
  CZXKSBM := '';
  CZXKSMC := '';
  IYS := 0; //申请医生编码
  MYSJE := 0; //应收金额
  MSSJE := 0; //实价金额
  MJZJE := 0; //记帐金额
  MSJJZ := 0; //实际记帐金额
  MYHZF := 0;
  MYBZF := 0;
  DJZRQ := Now; //记账日期
  CBZ := ''; //备注
  CDJH := ''; //收费对应单据号
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
  CJZD := ''; //记账单号
  CYJZD := '';
  CSFXMBM := ''; //收费项目编码
  CSFXM := ''; //收费项目名称
  FSL := 0.0; //数量
  CDW := ''; //单位
  MDJ := 0.0; //单价
  FBL := 0.0; //比例
  CBZ := ''; //备注
  CDJH := ''; //费用明细关系号
  ICWTJ := 0; //财务统计编码
  IFYTJ := 0; //费用统计编码
  IBATJ := 0; //病案统计编码
  CSYMD := '';
  CYJZD := ''; //原记账单
  //IZYYS := 0; //住院医生编码
  //CZYYS := ''; //住院医生名称

  CQMYS := ''; //费用签名医生
  ITYPE := 0; //0 非联网项目  1 联网处方 2 联网处方附加费
  CZXKSMC := ''; /////执行可科室
  CZXKSBM := ''; /////执行科室编码
  //IZYKS := 0; /////执行科室编码
  //CZYKS := ''; /////执行可科室
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

