unit BigPic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFBigPic = class(TForm)
    ImageItself: TImage;
    PanelPic: TPanel;
    LabelTitle: TLabel;
    LabelYoS: TLabel;
    LabelYoE: TLabel;
    LabelYoW: TLabel;
    LabelGenre: TLabel;
    LabelTheme: TLabel;
    LabelMaterials: TLabel;
    LabelDescr: TLabel;
    LabelUserRate: TLabel;
    LabelUserComm: TLabel;
    LabelIsFavourite: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBigPic: TFBigPic;

implementation

{$R *.dfm}

end.
