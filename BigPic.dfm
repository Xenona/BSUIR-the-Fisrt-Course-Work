object FBigPic: TFBigPic
  Left = 0
  Top = 0
  ClientHeight = 870
  ClientWidth = 1210
  Color = clBtnFace
  Constraints.MinHeight = 870
  Constraints.MinWidth = 1210
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenuBigPic
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PanelPic: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 870
    Align = alClient
    Caption = 'Panel1'
    ParentBackground = False
    ParentColor = True
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = -6
    ExplicitTop = 696
    ExplicitWidth = 648
    object ImageItself: TImage
      Left = 72
      Top = 42
      Width = 545
      Height = 674
    end
  end
  object PanelInfo: TPanel
    Left = 651
    Top = 0
    Width = 559
    Height = 870
    Align = alRight
    Caption = 'Panel1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 648
    ExplicitTop = -8
    object LabelFieldYears: TLabel
      AlignWithMargins = True
      Left = 22
      Top = 82
      Width = 179
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = #8212
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelDescr: TLabel
      AlignWithMargins = True
      Left = 22
      Top = 378
      Width = 145
      Height = 70
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      BiDiMode = bdLeftToRight
      Caption = #1050#1086#1088#1086#1090#1082#1086#1077' '#1086#1087#1080#1089#1072#1085#1080#1077': '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldDescr: TLabel
      AlignWithMargins = True
      Left = 264
      Top = 386
      Width = 260
      Height = 225
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = 
        #1044#1072', '#1086#1095#1077#1085#1100' '#1080#1085#1090#1077#1088#1077#1089#1085#1086', '#1083#1102#1073#1083#1102' '#1082#1091#1088#1089#1072#1095' '#1090#1072#1082' '#1078#1077' '#1089#1080#1083#1100#1085#1086', '#1082#1072#1082' '#1080' '#1101#1090#1080' '#1076#1074#1077#1089#1090 +
        #1080' '#1089#1080#1084#1074#1086#1083#1086#1074' '#1084#1086#1077#1075#1086' '#1085#1077#1074#1077#1088#1086#1103#1090#1085#1086' '#1090#1088#1091#1076#1085#1086' '#1080' '#1076#1086#1083#1075#1086' '#1089#1086#1095#1080#1085#1103#1077#1084#1086#1075#1086' '#1090#1077#1082#1089#1090#1072', '#1086 +
        ' '#1076#1072', '#1089#1090#1072#1088#1072#1083#1072#1089#1100' '#1080#1079#1086' '#1074#1089#1077#1093' '#1089#1080#1083' '#1089#1086#1074#1077#1088#1096#1077#1085#1085#1086' '#1090#1086#1095#1085#1086' '#1085#1077' '#1083#1080#1090#1100' '#1074#1086#1076#1091', '#1087#1088#1080#1082#1086 +
        #1083#1100#1085#1086', '#1072'?'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldGenre: TLabel
      AlignWithMargins = True
      Left = 264
      Top = 134
      Width = 130
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = #1052#1086#1076#1077#1088#1085#1080#1079#1084#1072
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldMats: TLabel
      AlignWithMargins = True
      Left = 264
      Top = 241
      Width = 260
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = #1061#1086#1083#1089#1090', '#1084#1072#1089#1083#1086
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldTheme: TLabel
      AlignWithMargins = True
      Left = 264
      Top = 185
      Width = 130
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = #1051#1102#1076#1080
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldTitle: TLabel
      AlignWithMargins = True
      Left = 23
      Top = 12
      Width = 380
      Height = 70
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = 'Master Jan Hus Preaching at the Bethlehem Chapel'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldUsrCmm: TLabel
      AlignWithMargins = True
      Left = 264
      Top = 779
      Width = 260
      Height = 70
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = #1063#1090#1086' '#1074' '#1085#1072#1096#1077#1081' '#1078#1080#1079#1085#1080' '#1077#1089#1090#1100' '#1087#1103#1090#1100#1076#1077#1089#1103#1090' '#1089#1080#1084#1074#1086#1083#1086#1074'? '#1053#1080#1095#1090#1086'. '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelGenre: TLabel
      AlignWithMargins = True
      Left = 23
      Top = 126
      Width = 81
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = #1046#1072#1085#1088':'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelMaterials: TLabel
      AlignWithMargins = True
      Left = 21
      Top = 233
      Width = 160
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099':'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelTheme: TLabel
      AlignWithMargins = True
      Left = 22
      Top = 177
      Width = 133
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = #1058#1077#1084#1072#1090#1080#1082#1072':'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelUserComm: TLabel
      AlignWithMargins = True
      Left = 19
      Top = 779
      Width = 194
      Height = 70
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelUserRate: TLabel
      AlignWithMargins = True
      Left = 21
      Top = 684
      Width = 196
      Height = 70
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = #1054#1094#1077#1085#1082#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103': '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelPlace: TLabel
      AlignWithMargins = True
      Left = 21
      Top = 292
      Width = 153
      Height = 70
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = #1052#1077#1089#1090#1086' '#1085#1072#1087#1080#1089#1072#1085#1080#1103':'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 35
      Font.Name = 'Montserrat SemiBold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LabelFieldPlace: TLabel
      AlignWithMargins = True
      Left = 264
      Top = 300
      Width = 195
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      AutoSize = False
      Caption = #1055#1088#1072#1075#1072
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 25
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object ChkBxFavourite: TCheckBox
      Left = 517
      Top = 21
      Width = 18
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ChkBxFavouriteClick
    end
    object CmbBxUserRate: TComboBox
      Left = 264
      Top = 703
      Width = 120
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = CmbBxUserRateChange
    end
    object MemoTitle: TMemo
      Left = 23
      Top = 15
      Width = 380
      Height = 70
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'MemoTitle')
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
    object MemoYears: TMemo
      Left = 23
      Top = 85
      Width = 180
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object MemoGenre: TMemo
      Left = 263
      Top = 130
      Width = 130
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object MemoTheme: TMemo
      Left = 263
      Top = 185
      Width = 130
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
    object MemoMats: TMemo
      Left = 263
      Top = 241
      Width = 260
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 6
      Visible = False
    end
    object MemoPlace: TMemo
      Left = 263
      Top = 300
      Width = 195
      Height = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 7
      Visible = False
    end
    object MemoDescr: TMemo
      Left = 263
      Top = 382
      Width = 260
      Height = 299
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 8
      Visible = False
    end
    object MemoUsrCmm: TMemo
      Left = 263
      Top = 774
      Width = 260
      Height = 75
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 9
      Visible = False
    end
  end
  object MainMenuBigPic: TMainMenu
    Left = 528
    Top = 376
    object MenuEditPic: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1072#1088#1090#1080#1085#1091
      OnClick = MenuEditPicClick
    end
    object MenuDeletePic: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1072#1088#1090#1080#1085#1091
      OnClick = MenuDeletePicClick
    end
    object MenuAccept: TMenuItem
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Visible = False
      OnClick = MenuAcceptClick
    end
    object MenuCancel: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Visible = False
      OnClick = MenuCancelClick
    end
  end
end
