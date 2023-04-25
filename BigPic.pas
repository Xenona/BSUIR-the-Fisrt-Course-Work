unit BigPic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SharedTypes;

type



  TFBigPic = class(TForm)
    ImageItself: TImage;
    PanelPic: TPanel;
    LabelTitle: TLabel;
    LabelGenre: TLabel;
    LabelTheme: TLabel;
    LabelMaterials: TLabel;
    LabelDescr: TLabel;
    LabelUserRate: TLabel;
    LabelUserComm: TLabel;
    LabelIsFavourite: TLabel;
    EditTitle: TEdit;
    EditYoS: TEdit;
    EditYoE: TEdit;
    EditYoW: TEdit;
  private


  public
    PicInfo: PPicElem;
  end;

var
  FBigPic: TFBigPic;

implementation

{$R *.dfm}

end.
