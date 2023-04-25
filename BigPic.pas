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
    EditGenre: TEdit;
    EditTheme: TEdit;
    EditMaterials: TEdit;
    EditDescr: TEdit;
    ChkBxFavourite: TCheckBox;
    EditUserComm: TEdit;
    CmbBxUserRate: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private


  public
    PicInfo: PPicElem;
  end;

var
  FBigPic: TFBigPic;

implementation

{$R *.dfm}




procedure TFBigPic.FormActivate(Sender: TObject);
begin

  EditTitle.Text := PicInfo.data.title;
  EditYoS.Text := IntToStr(PicInfo.data.yearOfStart);
  EditYoE.Text := IntToStr(PicInfo.data.yearOfEnd);
  EditYoW.Text := IntToStr(PicInfo.data.yearsOfWork);
  EditGenre.Text := PicInfo.data.genre;
  EditTheme.Text := PicInfo.data.theme;
  EditMaterials.Text := PicInfo.data.materials;
  EditDescr.Text := PicInfo.data.shortDescr;
  ChkBxFavourite.Checked := PicInfo.data.isFavourite;
  EditUserComm.Text := PicInfo.data.userComment;
  CmbBxUserRate.Text := IntToStr(PicInfo.data.userRate);
  ImageItSelf.Picture.Assign(PicInfo.data.imgBuffer);


end;

procedure TFBigPic.FormCreate(Sender: TObject);
begin
  CmbBxUserRate.Items.Add('Нет оценки');
  CmbBxUserRate.Items.Add('1');
  CmbBxUserRate.Items.Add('2');
  CmbBxUserRate.Items.Add('3');
  CmbBxUserRate.Items.Add('4');
  CmbBxUserRate.Items.Add('5');
end;

end.
