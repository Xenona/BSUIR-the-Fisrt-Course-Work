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
    procedure showHideMemo(Sender: TObject; status: Boolean);
    procedure showHideMenu(Sender: TObject; EditDeleteStatus, acceptCancelStatus: Boolean);
    procedure FormResize(Sender: TObject);

  private


  public
    PicInfo: PPicElem;
  end;

var
  FBigPic: TFBigPic;

implementation

{$R *.dfm}


procedure LoadImageToFitPanel(PanelPic: TPanel; Image: TImage; Picture: TPicture; Margin: Integer);
var
  Ratio, PanelRatio: Double;
begin

   Image.Picture.Assign(Picture);

  // Calculate the ratio of the Image
  Ratio := Image.Picture.Width / Image.Picture.Height;

  // Calculate the ratio of the Panel
  PanelRatio := PanelPic.ClientWidth / PanelPic.ClientHeight;

  if Ratio > PanelRatio then
  begin
    // The Image is wider than the Panel
    Image.Width := PanelPic.ClientWidth - 2 * Margin;
    Image.Height := Round((PanelPic.ClientWidth - 2 * Margin) / Ratio);
  end
  else
  begin
    // The Image is taller than the Panel
    Image.Height := PanelPic.ClientHeight - 2 * Margin;
    Image.Width := Round((PanelPic.ClientHeight - 2 * Margin) * Ratio);
  end;

  // Set the position of the Image to be centered within the Panel
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

  MenuEditPic.Visible := EditDeleteStatus;
  MenuDeletePic.Visible := EditDeleteStatus;
  MenuAccept.Visible := acceptCancelStatus;
  MenuCancel.Visible := acceptCancelStatus;
end;

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



//  ImageItSelf.Picture.Assign(PicInfo.data.imgBuffer);
  ImageItself.AutoSize := False;
  ImageItself.Stretch := True;
  LoadImageToFitPanel(PanelPic, ImageItself, PicInfo.data.imgBuffer, Margin);





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

  showHideMenu(Self, True, False);


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

procedure TFBigPic.FormResize(Sender: TObject);
var
  Margin: Integer;
begin
  Margin := 50;
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
