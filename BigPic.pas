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
    MemoGenre: TMemo;
    MemoTheme: TMemo;
    MemoMats: TMemo;
    MemoPlace: TMemo;
    MemoDescr: TMemo;
    MemoUsrCmm: TMemo;
    MenuAccept: TMenuItem;
    MenuCancel: TMenuItem;
    MenuCreatePic: TMenuItem;
    MenuRejectPic: TMenuItem;
    EditYears: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuEditPicClick(Sender: TObject);
    procedure MenuAcceptClick(Sender: TObject);
    procedure MenuCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure showHideMemo(status: Boolean);
    procedure showHideMenu(EditDeleteStatus, acceptCancelStatus: Boolean; CreateRejectStatus: Boolean);
    procedure FormResize(Sender: TObject);
    procedure CmbBxUserRateChange(Sender: TObject);
    procedure ChkBxFavouriteClick(Sender: TObject);
    procedure MenuDeletePicClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure MenuRejectPicClick(Sender: TObject);
    procedure MenuCreatePicClick(Sender: TObject);
    procedure updatePicInfo(var picToUpdate: PPicElem);

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

procedure TFBigPic.showHideMemo(status: Boolean);
begin

  MemoTitle.Visible := status;
  EditYears.Visible := status;
  MemoGenre.Visible := status;
  MemoTheme.Visible := status;
  MemoMats.Visible := status;
  MemoPlace.Visible := status;
  MemoDescr.Visible := status;
  MemoUsrCmm.Visible := status;

end;

procedure TFBigPic.showHideMenu(EditDeleteStatus: Boolean; acceptCancelStatus: Boolean; CreateRejectStatus: Boolean);
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
  MenuCreatePic.Visible :=  CreateRejectStatus;
  MenuRejectPic.Visible := CreateRejectStatus;

end;

procedure TFBigPic.ChkBxFavouriteClick(Sender: TObject);
begin
  PicInfo.data.isFavourite := ChkBxFavourite.Checked;
end;

procedure TFBigPic.CmbBxUserRateChange(Sender: TObject);
begin
  PicInfo.data.userRate := (CmbBxUserRate.ItemIndex);
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
  LabelFieldYears.Caption := intToStr(PicInfo.data.yearOfStart) + ' – ' + IntToStr(PicInfo.data.yearOfEnd) + ' (' + IntToStr(PicInfo.data.yearsOfWork) + ')';
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

  showHideMemo(False);
  showHideMenu(True, False, False);
//  FBigPic.Free;

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

procedure TFBigPic.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ShowMessage('lflflf');
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

procedure TFBigPic.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  If Msg.CharCode = VK_ESCAPE Then
    Close;
end;

procedure TFBigPic.updatePicInfo(var picToUpdate: PPicElem);
begin
  // save info from memos

  picToUpdate.data.title := MemoTitle.Text;
  picToUpdate.data.YearOfStart := StrToInt(Copy(EditYears.Text, 1, 4));
  picToUpdate.data.YearOfEnd := StrToInt(Copy(EditYears.Text, 8, 11));
  picToUpdate.data.yearsOfWork := PicInfo.data.yearOfEnd - PicInfo.data.yearOfStart;
  picToUpdate.data.genre := MemoGenre.Text;
  picToUpdate.data.theme := MemoTheme.Text;
  picToUpdate.data.materials := MemoMats.Text;
  picToUpdate.data.place := MemoPlace.Text;
  picToUpdate.data.shortDescr := MemoDescr.Text;
  picToUpdate.data.userComment := MemoUsrCmm.Text;


  // update labels from changed .data
  LabelFieldTitle.Caption := picToUpdate.data.title;
  LabelFieldYears.Caption := intToStr(picToUpdate.data.yearOfStart) + ' – ' + IntToStr(picToUpdate.data.yearOfEnd) + ' (' + IntToStr(picToUpdate.data.yearsOfWork) + ')';
  LabelFieldGenre.Caption := picToUpdate.data.genre;
  LabelFieldTheme.Caption := picToUpdate.data.theme;
  LabelFieldMats.Caption := picToUpdate.data.materials;
  LabelFieldPlace.Caption := picToUpdate.data.place;
  LabelFieldDescr.Caption := picToUpdate.data.shortDescr;
  ChkBxFavourite.Checked := picToUpdate.data.isFavourite;
  LabelFieldUsrCmm.Caption := picToUpdate.data.userComment;
  CmbBxUserRate.Text := IntToStr(picToUpdate.data.userRate);
end;

procedure TFBigPic.MenuAcceptClick(Sender: TObject);
begin

  updatePicInfo(PicInfo);


  showHideMemo(False);

  showHideMenu(True, False, False);
  FGallery.ReCreateAllPanels(FGallery.ChangedHead);


end;

procedure TFBigPic.MenuCancelClick(Sender: TObject);
begin
  showHideMemo(False);
  showHideMenu(True, False, False);
end;

procedure TFBigPic.MenuCreatePicClick(Sender: TObject);
begin

  updatePicInfo(PicInfo);
  FGallery.AddNewNode(PicInfo, FGallery.changedHead);
  FGallery.AddNewNode(PicInfo, FGallery.head);
end;

procedure TFBigPic.MenuRejectPicClick(Sender: TObject);
begin


  ShowHideMemo(False);
  ShowHideMenu(True, False, False);
end;

procedure TFBigPic.MenuDeletePicClick(Sender: TObject);
var
  Temp: PPicElem;
begin
  FGallery.DeleteNode(PicInfo, FGallery.changedHead);
  FGallery.DeleteNode(PicInfo, FGallery.head);
  Close;
  FGallery.ReCreateAllPanels(FGallery.ChangedHead);

end;

procedure TFBigPic.MenuEditPicClick(Sender: TObject);
begin

  showHideMenu(False, True, False);

  // to memos,  add text to edit
  MemoTitle.Text := LabelFieldTitle.Caption;
  EditYears.Text := Copy(LabelFieldYears.Caption, 1, 11);
  MemoGenre.Text := LabelFieldGenre.Caption;
  MemoTheme.Text := LabelFieldTheme.Caption;
  MemoMats.Text := LabelFieldMats.Caption;
  MemoPlace.Text := LabelFieldPlace.Caption;
  MemoDescr.Text := LabelFieldDescr.Caption;
  MemoUsrCmm.Text := LabelFieldUsrCmm.Caption;


  showHideMemo(True);




end;

end.
