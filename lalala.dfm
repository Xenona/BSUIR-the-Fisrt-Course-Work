object FGallery: TFGallery
  Left = 549
  Top = 231
  Caption = #1043#1072#1083#1077#1088#1077#1103' '#1040#1083#1100#1092#1086#1085#1089#1072' '#1052#1091#1093#1080' '
  ClientHeight = 578
  ClientWidth = 978
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 778
    Top = 0
    Width = 200
    Height = 578
    Margins.Bottom = 300
    Align = alRight
    BorderWidth = 20
    BorderStyle = bsSingle
    Caption = 'Panel1'
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 782
    object LabelAlbum: TLabel
      Left = 4
      Top = 9
      Width = 105
      Height = 32
      Caption = #1040#1083#1100#1073#1086#1084':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Montserrat'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSearch: TLabel
      Left = 4
      Top = 112
      Width = 106
      Height = 41
      Caption = #1048#1089#1082#1072#1090#1100'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Montserrat'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelParam: TLabel
      Left = 4
      Top = 192
      Width = 187
      Height = 32
      Caption = #1055#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1091':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Montserrat'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelFilter: TLabel
      Left = 4
      Top = 299
      Width = 143
      Height = 32
      Caption = #1060#1080#1083#1100#1090#1088' '#1087#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Montserrat'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = -14
      Top = 97
      Width = 215
      Height = 9
    end
    object Bevel2: TBevel
      Left = -9
      Top = 271
      Width = 215
      Height = 9
    end
    object Bevel3: TBevel
      Left = -11
      Top = 399
      Width = 215
      Height = 9
    end
    object ComboBoxAlbum: TComboBox
      Left = 4
      Top = 47
      Width = 189
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ' '
    end
    object ComboBoxParam: TComboBox
      Left = 4
      Top = 230
      Width = 189
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ComboBoxFilter: TComboBox
      Left = 4
      Top = 337
      Width = 189
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object EditSearch: TEdit
      Left = 4
      Top = 151
      Width = 189
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
    end
    object ButtonSlideshow: TButton
      Left = 4
      Top = 432
      Width = 189
      Height = 73
      Cursor = crHandPoint
      Hint = #1047#1072#1087#1091#1089#1082' '#1089#1083#1072#1081#1076'-'#1096#1086#1091' '#1080#1079' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1072#1083#1100#1073#1086#1084#1072
      Caption = #1053#1072#1095#1072#1090#1100' '#1089#1083#1072#1081#1076'-'#1096#1086#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Montserrat'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      WordWrap = True
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 778
    Height = 578
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    ExplicitWidth = 790
    object FlowPanelPics: TFlowPanel
      Left = 0
      Top = 0
      Width = 757
      Height = 1000
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 20
      Align = alTop
      Caption = 'FlowPanel1'
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      VerticalAlignment = taAlignTop
      ExplicitLeft = 2
      ExplicitTop = -2
    end
  end
  object MainMenu: TMainMenu
    Left = 934
    Top = 536
    object FileMenu: TMenuItem
      Caption = #1060#1072#1081#1083
      object OpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = OpenFileClick
      end
      object SaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      end
    end
    object HelpMenu: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
    object DeveloperMenu: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 886
    Top = 536
  end
end
