object FBigPic: TFBigPic
  Left = 0
  Top = 0
  ClientHeight = 670
  ClientWidth = 1019
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTitle: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 13
    Width = 241
    Height = 20
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelGenre: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 120
    Width = 88
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1046#1072#1085#1088':'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelTheme: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 176
    Width = 169
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1058#1077#1084#1072#1090#1080#1082#1072':'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelMaterials: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 240
    Width = 145
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099':'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelDescr: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 304
    Width = 217
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1050#1086#1088#1086#1090#1082#1086#1077' '#1086#1087#1080#1089#1072#1085#1080#1077': '
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelUserRate: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 584
    Width = 353
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1072#1103' '#1086#1094#1077#1085#1082#1072': '
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelUserComm: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 504
    Width = 422
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1081' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelIsFavourite: TLabel
    AlignWithMargins = True
    Left = 503
    Top = 448
    Width = 337
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = False
    Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1088#1090#1080#1085#1091' '#1082#1072#1082' '#1048#1079#1073#1088#1072#1085#1085#1091#1102':'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object PanelPic: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 670
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object ImageItself: TImage
      Left = 32
      Top = 35
      Width = 449
      Height = 598
    end
  end
  object EditTitle: TEdit
    Left = 687
    Top = 8
    Width = 228
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object EditYoS: TEdit
    Left = 631
    Top = 49
    Width = 90
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object EditYoE: TEdit
    Left = 740
    Top = 49
    Width = 90
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
  object EditYoW: TEdit
    Left = 852
    Top = 49
    Width = 90
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object EditGenre: TEdit
    Left = 607
    Top = 114
    Width = 90
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object EditTheme: TEdit
    Left = 630
    Top = 170
    Width = 90
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object EditMaterials: TEdit
    Left = 654
    Top = 234
    Width = 90
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object EditDescr: TEdit
    Left = 699
    Top = 298
    Width = 243
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object ChkBxFavourite: TCheckBox
    Left = 871
    Top = 434
    Width = 18
    Height = 58
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object EditUserComm: TEdit
    Left = 607
    Top = 532
    Width = 243
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    TextHint = #1074#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090
  end
  object CmbBxUserRate: TComboBox
    Left = 697
    Top = 612
    Width = 228
    Height = 35
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
end
