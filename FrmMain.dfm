object MainForm: TMainForm
  Left = 207
  Top = 87
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'YxCis'#24212#29992#26381#21153#22120
  ClientHeight = 92
  ClientWidth = 222
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Enabled = True
  GlassFrame.SheetOfGlass = True
  OldCreateOrder = True
  Position = poScreenCenter
  ScreenSnap = True
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 2
    Top = 40
    Width = 39
    Height = 13
    Caption = #29366#24577#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 47
    Top = 39
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 47
    Top = 58
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 2
    Top = 58
    Width = 39
    Height = 13
    Caption = #36816#34892#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 2
    Top = 76
    Width = 52
    Height = 13
    Caption = #35831#27714#25968#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 55
    Top = 75
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnStop: TBitBtn
    Left = 125
    Top = 8
    Width = 75
    Height = 25
    Caption = #20572#27490#26381#21153
    TabOrder = 0
    TabStop = False
    OnClick = btnStopClick
  end
  object btnStart: TBitBtn
    Left = 19
    Top = 8
    Width = 75
    Height = 25
    Caption = #24320#22987#26381#21153
    TabOrder = 1
    TabStop = False
    OnClick = btnStartClick
  end
  object pm1: TPopupMenu
    Left = 96
    Top = 16
    object N1: TMenuItem
      Caption = #24320#22987#26381#21153
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20572#27490#26381#21153
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #36824#21407
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #36864#20986
      OnClick = N4Click
    end
  end
  object Mag1: TFDManager
    WaitCursor = gcrHourGlass
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 96
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 298
    Top = 32
  end
end
