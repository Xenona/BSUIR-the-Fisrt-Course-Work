unit BigPic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SharedTypes, Math, MainForm,
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
    procedure showHideMemo(Sender: TObject; status: Boolean);
    procedure showHideMenu(Sender: TObject; EditDeleteStatus, acceptCancelStatus: Boolean);
    procedure FormResize(Sender: TObject);
    procedure CmbBxUserRateChange(Sender: TObject);
    procedure ChkBxFavouriteClick(Sender: TObject);
    procedure MenuDeletePicClick(Sender: TObject);

  private


  public
    PicInfo: PPicElem;
    PrevPicInfo: PPicElem;
    header: PPicElem;

  end;

var
  FBigPic: TFBigPic;


implementation

{$R *.dfm}


procedure LoadImageToFitPanel(PanelPic: TPanel; Image: TImage; Picture: TPicture; Margin: Integer);
var
  Ratio, PanelRatio: Single;
begin

  Ratio := Picture.Width / Picture.Height;

  PanelRatio := PanelPic.ClientWidth / PanelPic.ClientHeight;

  if Ratio > PanelRatio then
  begin

    Image.Width := PanelPic.ClientWidth - 2 * Margin;
    Image.Height := Round((PanelPic.ClientWidth - 2 * Margin) / Ratio);
  end
  else
  begin

    Image.Height := PanelPic.ClientHeight - 2 * Margin;
    Image.Width := Round((PanelPic.ClientHeight - 2 * Margin) * Ratio);
  end;

  Image.Left := (PanelPic.ClientWidth - Image.Width) div 2;
  Image.Top := (PanelPic.ClientHeight - Image.Height) div 2;
end;



procedure TFBigPic.showHideMemo(Sender: TObject; status: Boolean);
begin

  MemoTitle.Visible := status;
  MemoYears.Visible := status;
  MemoGenre.Visible := status;
  MemoTheme.Visible := status;
  MemoMats.Visible := status;
  MemoPlace.Visible := status;
  MemoDescr.Visible := status;
  MemoUsrCmm.Visible := status;

end;

procedure TFBigPic.showHideMenu(Sender: TObject; EditDeleteStatus: Boolean; acceptCancelStatus: Boolean);
begin

  if EditDeleteStatus = False then
  begin
    MenuEditPic.Visible := EditDeleteStatus;
    MenuDeletePic.Visible := EditDeleteStatus;
    MenuAccept.Visible := acceptCancelStatus;
    MenuCancel.Visible := acceptCancelStatus;
  end
  else
  begin
    MenuAccept.Visible := acceptCancelStatus;
    MenuCancel.Visible := acceptCancelStatus;
    MenuEditPic.Visible := EditDeleteStatus;
    MenuDeletePic.Visible := EditDeleteStatus;
  end;

end;

procedure TFBigPic.ChkBxFavouriteClick(Sender: TObject);
begin
  PicInfo.data.isFavourite := ChkBxFavourite.Checked;
end;

procedure TFBigPic.CmbBxUserRateChange(Sender: TObject);
begin
  PicInfo.data.userRate := StrToInt(CmbBxUserRate.Text);
end;

procedure TFBigPic.FormActivate(Sender: TObject);
var
  Scale: Single;
  Margin: integer;
  Image: TImage;
  pic: TPicture;
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




  ImageItSelf.Picture.Assign(PicInfo.data.imgBuffer);
  ImageItself.AutoSize := False;
  ImageItself.Stretch := True;
  LoadImageToFitPanel(PanelPic, ImageItself, PicInfo.data.imgBuffer, Margin);





end;

procedure TFBigPic.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  showHideMemo(Self, False);
  showHideMenu(Self, True, False);


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

procedure TFBigPic.FormResize(Sender: TObject);
var
  Margin: Integer;
   pic: TPicture;
begin
  Margin := 50;
  if PicInfo <> nil then
    LoadImageToFitPanel(PanelPic, ImageItself, PicInfo.data.imgBuffer, Margin);
end;

procedure TFBigPic.MenuAcceptClick(Sender: TObject);
begin

  // save info from memos
  PicInfo.data.title := MemoTitle.Text;
  PicInfo.data.YearOfStart := StrToInt(Copy(MemoYears.Text, 1, 4));
  PicInfo.data.YearOfEnd := StrToInt(Copy(MemoYears.Text, 8, 11));
  PicInfo.data.yearsOfWork := PicInfo.data.yearOfEnd - PicInfo.data.yearOfStart;
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


  showHideMemo(self, false);

  showHideMenu(Self, True, False);


end;

procedure TFBigPic.MenuCancelClick(Sender: TObject);
begin
  showHideMemo(self, false);
  showHideMenu(Self, True, False);
end;

procedure TFBigPic.MenuDeletePicClick(Sender: TObject);
var
  Temp: PPicElem;
begin

 FGallery.DeleteNode(PicInfo, FGallery.head);

end;

procedure TFBigPic.MenuEditPicClick(Sender: TObject);
begin

  showHideMenu(Self, False, True);

  // to memos,  add text to edit
  MemoTitle.Text := LabelFieldTitle.Caption;
  MemoYears.Text := Copy(LabelFieldYears.Caption, 1, 11);
  MemoGenre.Text := LabelFieldGenre.Caption;
  MemoTheme.Text := LabelFieldTheme.Caption;
  MemoMats.Text := LabelFieldMats.Caption;
  MemoPlace.Text := LabelFieldPlace.Caption;
  MemoDescr.Text := LabelFieldDescr.Caption;
  MemoUsrCmm.Text := LabelFieldUsrCmm.Caption;


  showHideMemo(self, true);




end;

end.
