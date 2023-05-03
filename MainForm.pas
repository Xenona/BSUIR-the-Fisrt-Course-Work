unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, Math,
  Vcl.Grids,  SharedTypes;


type
  TSortMethod = function(elem1, elem2: TData; direction: integer): integer;
  TEnumAlbs = array of array of PPicElem;


  TFGallery = class(TForm)
    PanelSideBar: TPanel;
    ScrollBoxPics: TScrollBox;
    MainMenu: TMainMenu;
    MenuAlbum: TMenuItem;
    MenuSavePage: TMenuItem;
    MenuDeleteAlbum: TMenuItem;
    MenuUpload: TMenuItem;
    MenuReset: TMenuItem;
    OpenPic: TOpenDialog;
    CmbBxAlbum: TComboBox;
    LabelAlbum: TLabel;
    LabelSearch: TLabel;
    LabelParam: TLabel;
    LabelFilter: TLabel;
    CmbBxSearchParam: TComboBox;
    CmbBxFilter: TComboBox;
    EditSearch: TEdit;
    ButtonSlideshow: TButton;
    CmbBxFiltVal: TComboBox;
    LabelFiltVal: TLabel;
    PanelAlbum: TPanel;
    PanelSearch: TPanel;
    PanelFilter: TPanel;
    PanelSort: TPanel;
    LabelSort: TLabel;
    CmbBxSort: TComboBox;
    LabelSortDir: TLabel;
    CmbBxSortDir: TComboBox;
    FlowPanelPics: TFlowPanel;
    MenuExportAlbum: TMenuItem;
    MenuImportAlbum: TMenuItem;
    MenuCreateAlbum: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CmbBxSortChange(Sender: TObject);
    procedure EditSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScrollBoxPicsMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure CmbBxFilterChange(Sender: TObject);
    procedure ShowBigPic(Sender: TObject);
    procedure DeleteNode(NodeToDelete: PPicElem; var NewHead: PPicElem);
    procedure MenuResetClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure MenuUploadClick(Sender: TObject);
    procedure ReCreateAllPanels(headToUse: PPicElem);
    procedure CreatePicture(var ImgToCreate: TImage; const PanelParent: TPanel; const APicLink: TPicture; const AMargin: Integer);
    procedure AddNewNode(elem: PPicElem; var head: PPicElem);
    procedure UploadAlbums();
    procedure FetchAllPics(var Head: PPicElem; const filePath: String);
    function CopyList(head: PPicElem): PPicElem;
    procedure LoadImages(Var PicList: PPicElem);
    procedure CmbBxAlbumChange(Sender: TObject);
  private
    { Private declarations }
  public
//     head: PPicElem;
//     sortedHead: PPicElem;
//     searchedHead: PPicElem;
//     changedHead: PPicElem;

     headsEnum: TEnumAlbs;
       newUploadNode: PPicElem;


     PicInfo: TData;


  end;

var
  FGallery: TFGallery;

implementation
   uses BigPic;


{$R *.dfm}
{$D+}

// --------------------------------------------------------------------------------
// VISUAL section BEGIN

procedure TFGallery.AddNewNode(elem: PPicElem; var head: PPicElem);
begin
  if (head = nil) then
  begin
    elem^.Next := nil;
    head := elem;
  end
  else
  begin
    elem^.Next := head;
    head := elem;
  end;
end;



// Delete a node from the linked list
procedure TFGallery.DeleteNode(NodeToDelete: PPicElem; var NewHead: PPicElem);
var
  Current, Prev: PPicElem;
begin
  Prev := nil;
  Current := NewHead;

  while (Current <> nil) and (Current.data.imgBuffer <> NodeToDelete.data.imgBuffer) do
  begin
    Prev := Current;
    Current := Current^.Next;
  end;

  if Current = NewHead then
    NewHead := Current^.Next
  else
    Prev^.Next := Current^.Next;

  Dispose(Current);
end;



procedure DeleteAllNodes(HeadToCheck, MajorHead: PPicElem);
begin
  while headToCheck <> nil do
  begin
    if headToCheck.data.isToBeChanged then
      FGallery.DeleteNode(headToCheck, MajorHead);
    headToCheck := headToCheck^.Next;
  end;

end;



procedure TFGallery.uploadAlbums();
const
  enumerated: string = 'enumerate.albums';
var
  AppPath: string;
  enumPath: string;
  enumFile: textFile;
  currFile: string;


begin

  AppPath := ExtractFilePath(Application.ExeName);
  enumPath := AppPath + 'albums\';

  AssignFile(enumFile, enumPath + enumerated);

  SetLength(headsEnum, 0);
  Reset(enumFile);
  while not EoF(enumFile) do
  begin
    readln(enumFile, currFile);

    // Create a new element in the array
    SetLength(headsEnum, Length(headsEnum) + 1);
    // Initialize the new element with an array of two pointers
    SetLength(headsEnum[High(headsEnum)], 2);

    // Get the list of images
    FetchAllPics(headsEnum[High(headsEnum)][0], enumPath + currFile);
    LoadImages(headsEnum[High(headsEnum)][0]);

    // Create a copy of the list
    headsEnum[High(headsEnum)][1] := CopyList(headsEnum[High(headsEnum)][0]);





    CmbBxAlbum.Items.Add(Copy(currFile, 1, Pos('.', currFile)-1 ));

  end;

  CmbBxAlbum.ItemIndex := 0;
    CloseFile(enumFile);
end;


// to fetch all pics from dataset.pic file
procedure TFGallery.FetchAllPics(var head: PPicElem; const filePath: string);
var
  readPicList: PPicElem;
  storageFile: file of Tdata;
  current: TData;

begin

  // open a source file
  Reset(storageFile, filePath);

  // creation of list of pics
  new(readPicList);
  head := readPicList;
  repeat
    new(readPicList^.Next);
    readPicList := readPicList^.Next;
    Read(storageFile, Current);
    readPicList^.data.title := current.title;
    readPicList^.data.yearOfStart := current.yearOfStart;
    readPicList^.data.yearOfEnd := current.yearOfEnd;
    readPicList^.data.yearsOfWork := current.yearsOfWork;
    readPicList^.data.genre := current.genre;
    readPicList^.data.theme := current.theme;
    readPicList^.data.place := current.place;
    readPicList^.data.materials := current.materials;
    readPicList^.data.shortDescr := current.shortDescr;
    readPicList^.data.userRate := current.userRate;
    readPicList^.data.userComment := current.userComment;
    readPicList^.data.isToBeChanged := current.isToBeChanged;
    readPicList^.data.isFavourite := current.isFavourite;
    readPicList^.data.userComment := current.userComment;
    readPicList^.data.filename := current.filename;
    readPicList^.data.imgBuffer := current.imgBuffer;
  until Eof(storageFile);

  // saving head of a list;
  readPicList^.Next := nil;
  closeFile(storageFile);
  readPicList := head;
  head := readPicList^.Next;
  dispose(readPicList);

end;

// load imgs to buffer of aech record
procedure TFGallery.LoadImages(Var PicList: PPicElem);
var
  SearchRec: TSearchRec;
  FileName: string;
  BasePath: string;
  breakFlag: Boolean;
  CurrentPic: PPicElem;
  resPath: string;
begin
  BasePath := ExtractFilePath(ParamStr(0)) + 'src\';
  if FindFirst(BasePath + '*.bmp', faAnyFile, SearchRec) = 0 then
  begin
    try
      repeat
        breakFlag := False;
        FileName := SearchRec.Name;
        // Find the corresponding element in the list
        CurrentPic := PicList;
        while (not breakFlag) and (CurrentPic <> nil) do
        begin
          if CurrentPic^.data.filename = FileName then
          begin
            CurrentPic^.data.imgBuffer := TPicture.Create;
            // Load the image into the buffer
            resPath := BasePath+FileName;
            CurrentPic^.data.imgBuffer.LoadFromFile(resPath);
            breakFlag := True;
          end;
          CurrentPic := CurrentPic^.Next;
        end;
      until FindNext(SearchRec) <> 0;
    finally
      FindClose(SearchRec);
    end;
  end;
end;


procedure TFGallery.CreatePicture( var ImgToCreate: TImage; const PanelParent: TPanel; const APicLink: TPicture; const AMargin: Integer);
var
  Scale: Single;
begin

  ImgToCreate := TImage.Create(PanelParent);
  ImgToCreate.Parent := PanelParent;
  ImgToCreate.AutoSize := False;
  ImgToCreate.Stretch := True;
  Scale := Min((PanelParent.ClientWidth - 2*AMargin) / APicLink.Width, (PanelParent.ClientWidth - 2*AMargin) / APicLink.Height);
  ImgToCreate.Width := Round((APicLink.Width) * Scale);
  ImgToCreate.Height := Round((APicLink.Height) * Scale);
  ImgToCreate.Left := (PanelParent.Width - ImgToCreate.Width + AMargin) div 2;
  ImgToCreate.Top := (PanelParent.Height - ImgToCreate.Height - 2*AMargin) div 2;
  ImgToCreate.Picture.Assign(APicLink);


end;


// create a panel with a pic and a label
procedure CreatePicPanel(AOwner: TComponent; AFlowPanel: TFlowPanel; APic: TPicture; ATitle: string);
var
  Panel: TPanel;
  Image: TImage;
  LabelTitle: TLabel;
  Scale: Single;
  Margin: Integer;
begin
  Margin := 10;

  Panel := TPanel.Create(AOwner);
  Panel.Parent := AFlowPanel;

  Panel.Margins.Left := Margin;
  Panel.Margins.Top := Margin;
  Panel.Margins.Right := Margin;
  Panel.Margins.Bottom := Margin;
  Panel.BevelOuter := bvNone;
  Panel.Height := 270;
  Panel.Width := 230;
  // appear again in onResize
  Panel.ParentBackground := False;
  Panel.ParentColor := False;
  Panel.Visible := False;

  FGallery.CreatePicture(Image, Panel, APic, Margin);
  Image.OnClick := FGallery.ShowBigPic;

  LabelTitle := TLabel.Create(Panel);
  LabelTitle.Parent := Panel;
  LabelTitle.Caption := ATitle;
  LabelTitle.Left := Image.Left;
  LabelTitle.Font.Name := 'Montserrat';
  LabelTitle.Font.Size := 10;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Font.Color := clWhite;
  LabelTitle.Top := Image.Top + Image.Height;
  LabelTitle.WordWrap := True;
  LabelTitle.Width := Image.Width + Margin;
  LabelTitle.Height := 100;


end;

procedure TFGAllery.ReCreateAllPanels(headToUse: PPicElem);
var
  i: integer;
  PrevNumOfCtrls: integer;
begin

 if headToUse = nil then
    begin
      FGallery.FlowPanelPics.Margins.Top := 500;
      FGallery.FlowPanelPics.Height := FGallery.PanelSideBar.Height;
      FGallery.FlowPanelPics.ShowCaption := True;
    end
    else
      FGallery.FlowPanelPics.ShowCaption := False;

  // saving how many panels're gonna be deleted
  PrevNumOfCtrls := FGallery.FlowPanelPics.ControlCount - 1;

  // creating new unvisible panels
  while (headToUse <> nil) do
  begin
    CreatePicPanel(FGallery, FGallery.FlowPanelPics, headToUse^.data.imgBuffer, headToUse^.data.title);
    headToUse := headToUse^.Next;
  end;

  // deleting saved num of old panels
  for i := PrevNumOfCtrls downto 0 do
    FGallery.FlowPanelPics.Controls[i].Free;

  // making visible new panels;
  for i := 0 to FGallery.FlowPanelPics.ControlCount - 1 do
    FGallery.FlowPanelPics.Controls[i].Visible := True;
end;


procedure TFGallery.MenuResetClick(Sender: TObject);
begin
  ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][0]);
end;
// VISUAL section END
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// SORT section BEGIN

function cmpYearStart(elem1, elem2: TData; direction: integer): integer;
begin
  Result := Sign(elem1.yearOfStart - elem2.yearOfStart)*direction;
end;

function cmpYearEnd(elem1, elem2: TData; direction: integer): integer;
begin
  Result := Sign(elem1.yearOfEnd - elem2.yearOfEnd)*direction;
end;

function cmpYearsWork(elem1, elem2: TData; direction: integer): integer;
begin
  Result := Sign(elem1.yearsOfWork - elem2.yearsOfWork)*direction;
end;

function cmpTitle(elem1, elem2: TData; direction: integer): integer;
begin
  Result := CompareText(elem1.title, elem2.title)*direction;
end;

function cmpUserRate(elem1, elem2: TData; direction: integer): integer;
begin
  Result := Sign(elem1.userRate - elem2.userRate)*direction;
end;

function cmpGenre(elem1, elem2: TData; direction: integer): integer;
begin
  Result := CompareText(elem1.genre, elem2.genre)*direction;
end;

function cmpTheme(elem1, elem2: TData; direction: integer): integer;
begin
  Result := CompareText(elem1.theme, elem2.theme)*direction;
end;

function cmpPlace(elem1, elem2: TData; direction: integer): integer;
begin
  Result := CompareText(elem1.place, elem2.place)*direction;
end;

function FindMiddle(headFind: PPicElem): PPicElem;
var
  slow, fast: PPicElem;
begin
  slow := headFind;
  fast := headFind^.Next;
  while (fast <> nil) do
  begin
    fast := fast^.Next;
    if (fast <> nil) then
    begin
      slow := slow^.Next;
      fast := fast^.Next;
    end;
  end;
  result := slow;
end;

function TFGallery.CopyList(head: PPicElem): PPicElem;
var
  current, newHead, newNode: PPicElem;
begin
  newHead := nil;
  current := head;

  while (current <> nil) do
  begin
    newNode := New(PPicElem);
    newNode^.data := current^.data;
    newNode^.Next := nil;

    if not (newHead = nil) then
    begin
      newNode^.Next := newHead;
    end;

    newHead := newNode;
    current := current^.Next;
  end;

  result := newHead;
end;


function MergeSort(head: PPicElem; sortDirection: integer; compare: TSortMethod): PPicElem;
var
  middle, right, left, newHead, tail, tempHead: PPicElem;
  isExit: boolean;
begin
  isExit := false;

  tempHead := FGallery.CopyList(head);

  if (tempHead = nil) or (tempHead^.Next = nil) then
  begin
    result := tempHead;
    isExit := true;
  end;

  if not isExit then
  begin
    middle := FindMiddle(tempHead);
    right := middle^.Next;
    middle^.Next := nil;
    left := tempHead;

    left := MergeSort(left, sortDirection, compare);
    right := MergeSort(right, sortDirection, compare);

    newHead := nil;
    tail := nil;

    while (left <> nil) and (right <> nil) do
    begin
      if compare(left^.data, right^.data, sortDirection) < 0 then
      begin
        if newHead = nil then
          newHead := left;
        if tail <> nil then
          tail^.Next := left;
        tail := left;
        left := left^.Next;
      end
      else
      begin
        if newHead = nil then
          newHead := right;
        if tail <> nil then
          tail^.Next := right;
        tail := right;
        right := right^.Next;
      end;
    end;
    if tail <> nil then
      tail^.Next := nil;

    if left <> nil then
    begin
      if newHead = nil then
        newHead := left;
      if tail <> nil then
        tail^.Next := left;
    end
    else
    begin
      if newHead = nil then
        newHead := right;
      if tail <> nil then
        tail^.Next := right;
    end;

    result := newHead;

    // Free the copied list
    while (tempHead <> nil) do
    begin
      tail := tempHead;
      tempHead := tempHead^.Next;
      Dispose(tail);
    end;
  end;
end;

// remove focus from combobox
procedure TFGallery.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  If Msg.CharCode = VK_ESCAPE Then
    Close;
end;

procedure TFGallery.FormShow(Sender: TObject);
begin
  ActiveControl := PanelSideBar ; // Set focus to form
end;

function GenerateShortHash: string;
var
  randNum: Integer;
  nowDateTime: TDateTime;
begin
  Randomize;
  randNum := Random(1000); // generate a random number between 0 and 999
  nowDateTime := Now; // get the current date and time
  Result := FormatDateTime('yymmddhhnnss', nowDateTime) + IntToStr(randNum);
end;

procedure TFGallery.MenuUploadClick(Sender: TObject);
var
  pic: TPicture;
  UploadWindow: TFBigPic;
  uniPostfix: string;
  defaultTitle: string;
begin

  new(newUploadNode);
  FillChar(newUploadNode.data, SizeOf(newUploadNode.data), 0);
  if OpenPic.Execute() then
  begin
    newUploadNode.data.imgBuffer := TPicture.Create;
    newUploadNode.data.imgBuffer.LoadFromFile(OpenPic.FileName);
  end;

  try

    UploadWindow := TFBigPic.Create(nil);
    UploadWindow.showHideMenu(False, False, True);
    UploadWindow.showHideMemo(True);

    uniPostfix := GenerateShortHash();
    defaultTitle := UploadWindow.MemoTitle.Text;
    UploadWindow.MemoTitle.Text := Copy(defaultTitle, 1, length(defaultTitle)-1)  + Copy(uniPostfix, length(uniPostfix)-6, length(uniPostfix));

    UploadWindow.PicInfo := newUploadNode;

    UploadWindow.ShowModal;
  finally
    UploadWindow.Free;
  end;
end;

// for both of sort cmbBxes
procedure TFGallery.CmbBxSortChange(Sender: TObject);
var
  sortDirection: Integer;
begin

  if (CmbBxSortDir.Text <> '') and (CmbBxSort.Text <> '') then
  begin
    case CmbBxSortDir.ItemIndex of
      1: sortDirection := 1;
      2: sortDirection := -1;
    end;

    case CmbBxSort.ItemIndex of
      1: // title
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpTitle);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      2: // year of start
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpYearStart);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      3: // year of end
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpYearEnd);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      4: // years of work
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpYearsWork);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      5: // genre
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpGenre);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      6: // theme
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpTheme);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      7: // place
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpPlace);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
      8: // user rate
      begin
        headsEnum[CmbBxAlbum.ItemIndex][1] := MergeSort(headsEnum[CmbBxAlbum.ItemIndex][1], sortDirection, cmpUserRate);
        ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
      end;
    end;
  end;
end;



// SORT section END
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// SEARCH section BEGIN

function isRecordMatch(const data: Tdata; const searchStr: string; field: integer): boolean;
begin

  case field of
    1: Result := (Pos(searchStr, data.title) > 0);
    2: Result := (Pos(searchStr, IntToStr(data.yearOfStart)) > 0);
    3: Result := (Pos(searchStr, IntToStr(data.yearOfEnd)) > 0);
    4: Result := (Pos(searchStr, IntToStr(data.yearsOfWork)) > 0);
    5: Result := (Pos(searchStr, data.genre) > 0);
    6: Result := (Pos(searchStr, data.theme) > 0);
    7: Result := (Pos(searchStr, data.place) > 0)  ;
    8: Result := (Pos(searchStr, data.materials) > 0);
    9: Result := (Pos(searchStr, data.shortDescr) > 0);
    10: Result := (Pos(searchStr, data.userComment) > 0);
    11: Result :=
      (Pos(searchStr, data.title) > 0) or
      (Pos(searchStr, IntToStr(data.yearOfStart)) > 0) or
      (Pos(searchStr, IntToStr(data.yearOfEnd)) > 0) or
      (Pos(searchStr, IntToStr(data.yearsOfWork)) > 0) or
      (Pos(searchStr, data.genre) > 0) or
      (Pos(searchStr, data.theme) > 0) or
      (Pos(searchStr, data.place) > 0) or
      (Pos(searchStr, data.materials) > 0) or
      (Pos(searchStr, data.shortDescr) > 0) or
      (Pos(searchStr, data.userComment) > 0);
    12: Result := (data.isFavourite = (StrToInt(searchStr) = 1));
    13: Result := (Pos(searchStr, IntToStr(data.userRate)) > 0);
  end;

 end;

function searchPrevTitle(const head: PPicElem; titleToSearch: string): PPicElem;
begin
  result := head;
  if not ((Result <> nil) and (Result^.Data.title = titleToSearch)) then
    while (result^.Next.data.title <> titleToSearch) and (result^.Next <> nil) do
    result := result^.Next;
end;



function searchData(head: PPicElem; infoToSearch: string; fieldSearch: integer): PPicElem;
var
  curElem: PPicElem;
  newList: PPicElem;


  // head of created list returns in 'return' var;
begin
  curElem := head;
  newList := nil;
  result := nil;

  while curElem <> nil do
  begin
    if isRecordMatch(curElem^.data, infoToSearch, fieldSearch) then
    begin
      if newList = nil then
      begin
        new(newList);
        newList^.data := curElem^.data;
        result := newList;
        Result^.Next := nil
      end
      else
      begin
        new(newList^.Next);
        newList := newList^.Next;
        newList^.data := CurElem^.data;
        newList^.Next := nil;
      end;
    end;
    curElem := curElem^.Next;
  end;


end;

procedure TFGallery.EditSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  // check if the user pressed the Enter key
  if Key = VK_RETURN then
  begin
    if (CmbBxSearchParam.Text <> '') and (Trim(EditSearch.Text) <> '')  then
    begin
      headsEnum[CmbBxAlbum.ItemIndex][1] := SearchData(headsEnum[CmbBxAlbum.ItemIndex][1], EditSearch.Text, CmbBxSearchParam.ItemIndex);

      if headsEnum[CmbBxAlbum.ItemIndex][1] = nil then
      begin
        FlowPanelPics.Margins.Top := 500;
        FlowPanelPics.Height := PanelSideBar.Height;
        FlowPanelPics.ShowCaption := True;
      end
      else
        FlowPanelPics.ShowCaption := False;

      ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
    end;
  end;


end;

// SEARCH section END
//---------------------------------------------------------------------------------

// FILTER section BEGIN
//---------------------------------------------------------------------------------

procedure TFGallery.CmbBxAlbumChange(Sender: TObject);
begin
 RecreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1])
end;

procedure TFGallery.CmbBxFilterChange(Sender: TObject);
begin

  if Sender = CmbBxFilter then
  case CmbBxFilter.ItemIndex of
    0:
    begin
      CmbBxFiltVal.Items.Clear;
      CmbBxFiltVal.Text := '';
      CmbBxFiltVal.Items.Add('');
    end;
    1:
    begin
      CmbBxFiltVal.Items.Clear;
      CmbBxFiltVal.Text := '';
      CmbBxFiltVal.Items.Add('');
      CmbBxFiltVal.Items.Add('��');
      CmbBxFiltVal.Items.Add('���');
    end;
    2:
    begin
      CmbBxFiltVal.Items.Clear;
      CmbBxFiltVal.Text := '';
      CmbBxFiltVal.Items.Add('');
      CmbBxFiltVal.Items.Add('��� ������');
      CmbBxFiltVal.Items.Add('1');
      CmbBxFiltVal.Items.Add('2');
      CmbBxFiltVal.Items.Add('3');
      CmbBxFiltVal.Items.Add('4');
      CmbBxFiltVal.Items.Add('5');
    end;
  end;



  if (CmbBxFilter.Text <> '') and (CmbBxFiltVal.Text <> '') then
  begin
    headsEnum[CmbBxAlbum.ItemIndex][1] := SearchData(headsEnum[CmbBxAlbum.ItemIndex][1], IntToStr(CmbBxFiltVal.ItemIndex), CmbBxFilter.ItemIndex+11);

    ReCreateAllPanels(headsEnum[CmbBxAlbum.ItemIndex][1]);
  end;

end;

//---------------------------------------------------------------------------------
// FILTER section END

// BIG PIC section BEGIN
//---------------------------------------------------------------------------------

procedure TFGallery.ShowBigPic(Sender: TObject);
var
   Window: TFBigPic;
   LabelToSearch: String;
   pic: TPicture;
begin

  Window := TFBigPic.Create(nil);
  try
    Window.header := headsEnum[CmbBxAlbum.ItemIndex][1];

    LabelToSearch := TLabel(TPanel(TImage(Sender).Parent).Controls[1]).Caption;
    Window.PrevPicInfo := SearchPrevTitle(headsEnum[CmbBxAlbum.ItemIndex][1], LabelToSearch);

    if (Window.PrevPicInfo <> headsEnum[CmbBxAlbum.ItemIndex][1]) or (LabelToSearch <> headsEnum[CmbBxAlbum.ItemIndex][1].data.title) then
      Window.PicInfo := Window.PrevPicInfo^.Next
    else
      Window.PicInfo := Window.PrevPicInfo;

    pic := TImage(Sender).Picture;

    Window.Show;
  finally
//    Window.Free;
  end;


end;

//---------------------------------------------------------------------------------
// BIG PIC section END

procedure TFGallery.FormCreate(Sender: TObject);
begin

//  FetchAllPics(head, './albums/dataset.pics');

//  LoadImages(head);
    uploadAlbums();
  ReCreateAllPanels(headsEnum[0][0]);

  // search params
  CmbBxSearchParam.Items.Add('');
  CmbBxSearchParam.Items.Add('��������');
  CmbBxSearchParam.Items.Add('��� ������');
  CmbBxSearchParam.Items.Add('��� �����');
  CmbBxSearchParam.Items.Add('����� ���');
  CmbBxSearchParam.Items.Add('����');
  CmbBxSearchParam.Items.Add('��������');
  CmbBxSearchParam.Items.Add('����� ���������');
  CmbBxSearchParam.Items.Add('���������');
  CmbBxSearchParam.Items.Add('��������');
  CmbBxSearchParam.Items.Add('�����������');
  CmbBxSearchParam.Items.Add('���');
  // then goes user rate
  // then goes isFavourite

  // filter params
  CmbBxFilter.Items.Add('');
  CmbBxFilter.Items.Add('���������');
  CmbBxFilter.Items.Add('������');



  // sort params
  CmbBxSort.Items.Add('');
  CmbBxSort.Items.Add('��������');
  CmbBxSort.Items.Add('��� ������');
  CmbBxSort.Items.Add('��� �����');
  CmbBxSort.Items.Add('����� ���');
  CmbBxSort.Items.Add('����');
  CmbBxSort.Items.Add('��������');
  CmbBxSort.Items.Add('����� ���������');
  CmbBxSort.Items.Add('������');


  // sort dir
  CmbBxSortDir.Items.Add('');
  CmbBxSortDir.Items.Add('�� �����������');
  CmbBxSortDir.Items.Add('�� ��������');


//  ChangedHead := CopyList(head);


end;

procedure TFGallery.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
    Close;
end;

procedure TFGallery.FormResize(Sender: TObject);
var
  currNumOfPics: Integer;
begin

  // appear again in CreatePicPanel
  currNumOfPics := FlowPanelPics.ControlCount;
  if FlowPanelPics.Width >= 210 then
    FlowPanelPics.Height := Max(270*(currNumOfPics div (FlowPanelPics.Width div 210) + 1), PanelSideBar.Height);

end;

procedure TFGallery.ScrollBoxPicsMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

  Handled := True;
  if WheelDelta < 0 then
    ScrollBoxPics.VertScrollBar.Position := ScrollBoxPics.VertScrollBar.Position + ScrollBoxPics.VertScrollBar.Increment
  else
    ScrollBoxPics.VertScrollBar.Position := ScrollBoxPics.VertScrollBar.Position - ScrollBoxPics.VertScrollBar.Increment;
end;

end.
