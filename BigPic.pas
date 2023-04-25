unit BigPic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SharedTypes, Math;

type



  TFBigPic = class(TForm)
    ImageItself: TImage;
    PanelPic: TPanel;
    LabelGenre: TLabel;
    LabelTheme: TLabel;
    LabelMaterials: TLabel;
    LabelDescr: TLabel;
    LabelUserRate: TLabel;
    LabelUserComm: TLabel;
    ChkBxFavourite: TCheckBox;
    CmbBxUserRate: TComboBox;
    LabelFieldTitle: TLabel;
    LabelFieldYoS: TLabel;
    LabelFieldYoE: TLabel;
    LabelFieldYoW: TLabel;
    LabelFieldGenre: TLabel;
    LabelFieldTheme: TLabel;
    LabelFieldMats: TLabel;
    LabelFieldDescr: TLabel;
    LabelFieldUsrCmm: TLabel;
    LabelDash: TLabel;
    Label1: TLabel;
    Label2: TLabel;
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
var
  Scale: Single;
  Margin: integer;
begin

  Margin := 30;

  LabelFieldTitle.Caption := PicInfo.data.title;
  LabelFieldYoS.Caption := IntToStr(PicInfo.data.yearOfStart);
  LabelFieldYoE.Caption := IntToStr(PicInfo.data.yearOfEnd);
  LabelFieldYoW.Caption := IntToStr(PicInfo.data.yearsOfWork);
  LabelFieldGenre.Caption := PicInfo.data.genre;
  LabelFieldTheme.Caption := PicInfo.data.theme;
  LabelFieldMats.Caption := PicInfo.data.materials;
  LabelFieldDescr.Caption := PicInfo.data.shortDescr;
  ChkBxFavourite.Checked := PicInfo.data.isFavourite;
  LabelFieldUsrCmm.Caption := PicInfo.data.userComment;
  CmbBxUserRate.Text := IntToStr(PicInfo.data.userRate);

  ImageItSelf.Picture.Assign(PicInfo.data.imgBuffer);
  ImageItself.AutoSize := False;
  ImageItself.Stretch := True;
  Scale := Min((PanelPic.ClientWidth - 2*Margin) / PicInfo.data.imgBuffer.Width, (PanelPic.ClientWidth - 2*Margin) / PicInfo.data.imgBuffer.Width);
  ImageItself.Width := Round((PicInfo.data.imgBuffer.Width) * Scale);
  ImageItself.Height := Round((PicInfo.data.imgBuffer.Height) * Scale);
  ImageItself.Left := (PanelPic.Width - ImageItself.Width) div 2;
  ImageItself.Top := (PanelPic.Height - ImageItself.Height) div 2;




end;

procedure TFBigPic.FormCreate(Sender: TObject);
begin
  CmbBxUserRate.Items.Add('��� ������');
  CmbBxUserRate.Items.Add('1');
  CmbBxUserRate.Items.Add('2');
  CmbBxUserRate.Items.Add('3');
  CmbBxUserRate.Items.Add('4');
  CmbBxUserRate.Items.Add('5');


end;

end.
