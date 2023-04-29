unit BigPic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SharedTypes, Math,
  Vcl.Menus;

type



  TFBigPic = class(TForm)
    PanelPic: TPanel;
    MainMenuBigPic: TMainMenu;
    PanelInfo: TPanel;
    LabelFieldYears: TLabel;
    LabelDescr: TLabel;
    LabelFieldDescr: TLabel;
    LabelFieldGenre: TLabel;
    LabelFieldMats: TLabel;
    LabelFieldTheme: TLabel;
    LabelFieldTitle: TLabel;
    LabelFieldUsrCmm: TLabel;
    LabelGenre: TLabel;
    LabelMaterials: TLabel;
    LabelTheme: TLabel;
    LabelUserComm: TLabel;
    LabelUserRate: TLabel;
    ChkBxFavourite: TCheckBox;
    CmbBxUserRate: TComboBox;
    MenuEditPic: TMenuItem;
    MenuDeletePic: TMenuItem;
    ImageItself: TImage;
    LabelPlace: TLabel;
    LabelFieldPlace: TLabel;
    MemoTitle: TMemo;
    MemoYears: TMemo;
    MemoGenre: TMemo;
    MemoTheme: TMemo;
    MemoMats: TMemo;
    MemoPlace: TMemo;
    MemoDescr: TMemo;
    MemoUsrCmm: TMemo;
    MenuAccept: TMenuItem;
    MenuCancel: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuEditPicClick(Sender: TObject);
    procedure MenuAcceptClick(Sender: TObject);
    procedure MenuCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
  Image: TImage;
begin

  Margin := 50;

  LabelFieldTitle.Caption := PicInfo.data.title;
  LabelFieldYears.Caption := intToStr(PicInfo.data.yearOfStart) + ' � ' + IntToStr(PicInfo.data.yearOfEnd) + ' (' + IntToStr(PicInfo.data.yearsOfWork) + ')';
  LabelFieldGenre.Caption := PicInfo.data.genre;
  LabelFieldTheme.Caption := PicInfo.data.theme;
  LabelFieldMats.Caption := PicInfo.data.materials;
  LabelFieldPlace.Caption := PicInfo.data.place;
  LabelFieldDescr.Caption := PicInfo.data.shortDescr;
  ChkBxFavourite.Checked := PicInfo.data.isFavourite;
  LabelFieldUsrCmm.Caption := PicInfo.data.userComment;
  CmbBxUserRate.Text := IntToStr(PicInfo.data.userRate);


//  CreatePicture(Image, PanelPic, PicInfo.data.imgBuffer, Margin);

  ImageItSelf.Picture.Assign(PicInfo.data.imgBuffer);
  ImageItself.AutoSize := False;
  ImageItself.Stretch := True;
  Scale := Min((PanelPic.ClientWidth - 2*Margin) / PicInfo.data.imgBuffer.Width, (PanelPic.ClientHeight - 2*Margin) / PicInfo.data.imgBuffer.Width);
  ImageItself.Width := Round((PicInfo.data.imgBuffer.Width) * Scale);
  ImageItself.Height := Round((PicInfo.data.imgBuffer.Height) * Scale);
  ImageItself.Left := (PanelPic.Width - ImageItself.Width) div 2;
  ImageItself.Top := (PanelPic.Height - ImageItself.Height) div 2;




end;

procedure TFBigPic.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   // hide memos
  MemoTitle.Visible := False;
  MemoYears.Visible := False;
  MemoGenre.Visible := False;
  MemoTheme.Visible := False;
  MemoMats.Visible := False;
  MemoPlace.Visible := False;
  MemoDescr.Visible := False;
  MemoUsrCmm.Visible := False;

  // hide unnecessary and show necessary menus
  MenuEditPic.Visible := True;
  MenuDeletePic.Visible := True;
  MenuAccept.Visible := False;
  MenuCancel.Visible := False;
end;

procedure TFBigPic.FormCreate(Sender: TObject);
var
  Scale: Single;
  Margin: integer;
  Image: TImage;
  i: integer;
begin
  CmbBxUserRate.Items.Add('��� ������');
  CmbBxUserRate.Items.Add('1');
  CmbBxUserRate.Items.Add('2');
  CmbBxUserRate.Items.Add('3');
  CmbBxUserRate.Items.Add('4');
  CmbBxUserRate.Items.Add('5');
end;

procedure TFBigPic.MenuAcceptClick(Sender: TObject);
begin

  // save info from memos
  PicInfo.data.title := MemoTitle.Text;
  PicInfo.data.YearOfStart := StrToInt(Copy(MemoYears.Text, 1, 4));
  PicInfo.data.YearOfEnd := StrToInt(Copy(MemoYears.Text, 8, 11));
  PicInfo.data.yearsOfWork := PicInfo.data.yearOfStart - PicInfo.data.yearOfEnd;
  PicInfo.data.genre := MemoGenre.Text;
  PicInfo.data.theme := MemoTheme.Text;
  PicInfo.data.materials := MemoMats.Text;
  PicInfo.data.place := MemoPlace.Text;
  PicInfo.data.shortDescr := MemoDescr.Text;
  PicInfo.data.userComment := MemoUsrCmm.Text;


  // update labels from changed .data
  LabelFieldTitle.Caption := PicInfo.data.title;
  LabelFieldYears.Caption := intToStr(PicInfo.data.yearOfStart) + ' � ' + IntToStr(PicInfo.data.yearOfEnd) + ' (' + IntToStr(PicInfo.data.yearsOfWork) + ')';
  LabelFieldGenre.Caption := PicInfo.data.genre;
  LabelFieldTheme.Caption := PicInfo.data.theme;
  LabelFieldMats.Caption := PicInfo.data.materials;
  LabelFieldPlace.Caption := PicInfo.data.place;
  LabelFieldDescr.Caption := PicInfo.data.shortDescr;
  ChkBxFavourite.Checked := PicInfo.data.isFavourite;
  LabelFieldUsrCmm.Caption := PicInfo.data.userComment;
  CmbBxUserRate.Text := IntToStr(PicInfo.data.userRate);


  // hide memos
  MemoTitle.Visible := False;
  MemoYears.Visible := False;
  MemoGenre.Visible := False;
  MemoTheme.Visible := False;
  MemoMats.Visible := False;
  MemoPlace.Visible := False;
  MemoDescr.Visible := False;
  MemoUsrCmm.Visible := False;

  // hide unnecessary and show necessary menus
  MenuEditPic.Visible := True;
  MenuDeletePic.Visible := True;
  MenuAccept.Visible := False;
  MenuCancel.Visible := False;

end;

procedure TFBigPic.MenuCancelClick(Sender: TObject);
begin

  // hide memos
  MemoTitle.Visible := False;
  MemoYears.Visible := False;
  MemoGenre.Visible := False;
  MemoTheme.Visible := False;
  MemoMats.Visible := False;
  MemoPlace.Visible := False;
  MemoDescr.Visible := False;
  MemoUsrCmm.Visible := False;

  // hide unnecessary and show necessary menus
  MenuEditPic.Visible := True;
  MenuDeletePic.Visible := True;
  MenuAccept.Visible := False;
  MenuCancel.Visible := False;

end;

procedure TFBigPic.MenuEditPicClick(Sender: TObject);
begin

  // hide unnecessary and show necessary menus
  MenuEditPic.Visible := False;
  MenuDeletePic.Visible := False;
  MenuAccept.Visible := True;
  MenuCancel.Visible := True;

  // to memos,  add text to edit
  MemoTitle.Text := LabelFieldTitle.Caption;
  MemoYears.Text := LabelFieldYears.Caption;
  MemoGenre.Text := LabelFieldGenre.Caption;
  MemoTheme.Text := LabelFieldTheme.Caption;
  MemoMats.Text := LabelFieldMats.Caption;
  MemoPlace.Text := LabelFieldPlace.Caption;
  MemoDescr.Text := LabelFieldDescr.Caption;
  MemoUsrCmm.Text := LabelFieldUsrCmm.Caption;

  // show memos
  MemoTitle.Visible := True;
  MemoYears.Visible := True;
  MemoGenre.Visible := True;
  MemoTheme.Visible := True;
  MemoMats.Visible := True;
  MemoPlace.Visible := True;
  MemoDescr.Visible := True;
  MemoUsrCmm.Visible := True;



end;

end.
