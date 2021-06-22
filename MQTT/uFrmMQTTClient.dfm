object FrmMQTTClient: TFrmMQTTClient
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MQTT'#23458#25143#31471#27979#35797
  ClientHeight = 534
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object MMLog: TMemo
    Left = 0
    Top = 241
    Width = 857
    Height = 274
    Align = alClient
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -14
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    Lines.Strings = (
      'mmLog')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 241
    Align = alTop
    TabOrder = 1
    object lbl2: TLabel
      Left = 8
      Top = 71
      Width = 68
      Height = 17
      Caption = #21457#36865#28040#24687
    end
    object lbl1: TLabel
      Left = 8
      Top = 41
      Width = 68
      Height = 17
      Caption = #21457#36865#20027#39064
    end
    object lbl3: TLabel
      Left = 8
      Top = 10
      Width = 68
      Height = 17
      Caption = #35746#38405#20027#39064
    end
    object btnPublish: TButton
      Left = 455
      Top = 188
      Width = 67
      Height = 54
      Caption = #21457#36865
      TabOrder = 0
      OnClick = btnPublishClick
    end
    object EdtPubTopic: TEdit
      Left = 80
      Top = 37
      Width = 369
      Height = 25
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      Text = 'YxCisSvrRet'
    end
    object mmo1: TMemo
      Left = 80
      Top = 68
      Width = 369
      Height = 174
      Lines.Strings = (
        'Copy That'#65281)
      TabOrder = 2
    end
    object EdtSubTopic: TEdit
      Left = 80
      Top = 6
      Width = 369
      Height = 25
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
      Text = 'YxCisSvr'
    end
    object btnSub: TButton
      Left = 455
      Top = 4
      Width = 67
      Height = 29
      Caption = #35746#38405
      TabOrder = 4
      OnClick = btnSubClick
    end
    object btnDisSub: TButton
      Left = 528
      Top = 4
      Width = 67
      Height = 29
      Caption = #21462#28040
      TabOrder = 5
      OnClick = btnDisSubClick
    end
  end
  object stat1: TStatusBar
    Left = 0
    Top = 515
    Width = 857
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 80
      end
      item
        Width = 260
      end
      item
        Width = 50
      end>
  end
end
