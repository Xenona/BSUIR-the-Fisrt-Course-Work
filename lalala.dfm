object FGallery: TFGallery
  Left = 549
  Top = 231
  Caption = #1043#1072#1083#1077#1088#1077#1103' '#1040#1083#1100#1092#1086#1085#1089#1072' '#1052#1091#1093#1080' '
  ClientHeight = 578
  ClientWidth = 975
  Color = clBtnFace
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 790
    Top = 0
    Width = 185
    Height = 578
    Margins.Bottom = 300
    Align = alRight
    BorderWidth = 20
    BorderStyle = bsSingle
    Caption = 'Panel1'
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 0
      Width = 101
      Height = 41
      Caption = 'Label1 '#1083#1072#1083#1072#1083#1072
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      WordWrap = True
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 790
    Height = 578
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    Align = alClient
    TabOrder = 1
    object FlowPanelPics: TFlowPanel
      Left = 0
      Top = 0
      Width = 769
      Height = 1000
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 20
      Align = alTop
      Caption = 'FlowPanel1'
      ShowCaption = False
      TabOrder = 0
      VerticalAlignment = taAlignTop
      ExplicitLeft = -3
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
