unit lalala;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, Math, DateUtils;

type
  PPicElem=^TPicElems;

  Tdata = packed record
    title: string[50];
    yearOfStart: integer;
    yearOfEnd: integer;
    yearsOfWork: integer;
    genre: string[10];
    theme: string[10];
    place: string[15];
    materials: string[15];
    shortDescr: string[100];
    userRate: integer;
    userComment: string[50];
    isToBeChanged: boolean;
    isFavourite: boolean;
    filename: string[25];
    imgBuffer: TPicture;
  end;


  TPicElems = record
    data: Tdata;
    Next: PPicElem;
  end;

  TSortMethod = function(elem1, elem2: TData; direction: integer): integer;


  TFGallery = class(TForm)
    PanelSideBar: TPanel;
    ScrollBox1: TScrollBox;
    FlowPanelPics: TFlowPanel;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    OpenFile: TMenuItem;
    SaveFile: TMenuItem;
    HelpMenu: TMenuItem;
    DeveloperMenu: TMenuItem;
    OpenDialog1: TOpenDialog;
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
    procedure OpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CmbBxSortChange(Sender: TObject);
    procedure EditSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
  public
     head: PPicElem;
     sortedHead: PPicElem;
     searchedHead: PPicElem;
     LastSearchTime: TDateTime;
  end;

var
  FGallery: TFGallery;

implementation

{$R *.dfm}
{$D+}

// --------------------------------------------------------------------------------
// VISUAL section BEGIN

// to fetch all pics from dataset.pic file
procedure FetchAllPics(var head: PPicElem);
var
  readPicList: PPicElem;
  storageFile: file of Tdata;
  current: TData;

begin

  // open a source file
  Reset(storageFile, 'dataset.pics');

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
procedure LoadImages(PicList: PPicElem);
var
  SearchRec: TSearchRec;
  FileName: string;
  BasePath: string;
  breakFlag: Boolean;
  CurrentPic: PPicElem;
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
            CurrentPic^.data.imgBuffer.LoadFromFile(BasePath + FileName);
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

// create a panel with a pic and a label
procedure CreatePicPanel(AOwner: TComponent; AFlowPanel: TFlowPanel; APic: TPicture; ATitle: string);
var
  Panel: TPanel;
  Image: TImage;
  LabelTitle: TLabel;
  Scale: Single;
  Margin: Integer;
begin
  Panel := TPanel.Create(AOwner);
  Panel.Parent := AFlowPanel;
  Margin := 10;
  Panel.Margins.Left := Margin;
  Panel.Margins.Top := Margin;
  Panel.Margins.Right := Margin;
  Panel.Margins.Bottom := Margin;
  Panel.BevelOuter := bvNone;
  Panel.Height := 270;
  Panel.Width := 210;
  // appear again in onResize
  Panel.ParentBackground := False;
  Panel.ParentColor := False;
  Panel.Visible := False;

  Image := TImage.Create(Panel);
  Image.Parent := Panel;
  Image.AutoSize := False;
  Image.Stretch := True;

  Scale := Min((Panel.ClientWidth - 2*Margin) / APic.Width, (Panel.ClientWidth - 2*Margin) / APic.Height);
  Image.Width := Round((APic.Width) * Scale);
  Image.Height := Round((APic.Height) * Scale);
  Image.Left := (Panel.Width - Image.Width + Margin) div 2;
  Image.Top := (Panel.Height - Image.Height - 20) div 2;
  Image.Picture.Assign(APic);

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

procedure ReCreateAllPanels(headToUse: PPicElem);
var
  i: integer;
  PrevNumOfCtrls: integer;
begin

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


// VISUAL section END
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
// SORT section BEGIN

function cmpYearStart(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.yearOfStart > elem2.yearOfStart) then
    result := 1*direction;
  if (elem1.yearOfStart < elem2.yearOfStart) then
    result := -1*direction;
  if (elem1.yearOfStart = elem2.yearOfStart) then
    result := 0;

end;

function cmpYearEnd(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.yearOfEnd > elem2.yearOfEnd) then
    result := 1*direction;
  if (elem1.yearOfEnd < elem2.yearOfEnd) then
    result := -1*direction;
  if (elem1.yearOfEnd = elem2.yearOfEnd) then
    result := 0;

end;

function cmpYearsWork(elem1, elem2: TData; direction: integer): integer;
begin


  if (elem1.yearsOfWork > elem2.yearsOfWork) then
    result := 1*direction;
  if (elem1.yearsOfWork < elem2.yearsOfWork) then
    result := -1*direction;
  if (elem1.yearsOfWork = elem2.yearsOfWork) then
    result := 0;

end;

function cmpTitle(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.title > elem2.title) then
    result := 1*direction;
  if (elem1.title < elem2.title) then
    result := -1*direction;
  if (elem1.title = elem2.title) then
    result := 0;

end;

function cmpUserRate(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.userRate > elem2.userRate) then
    result := 1*direction;
  if (elem1.userRate < elem2.userRate) then
    result := -1*direction;
  if (elem1.userRate = elem2.userRate) then
    result := 0;

end;

function cmpGenre(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.genre > elem2.genre) then
    result := 1*direction;
  if (elem1.genre < elem2.genre) then
    result := -1*direction;
  if (elem1.genre = elem2.genre) then
    result := 0;

end;

function cmpTheme(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.theme > elem2.theme) then
    result := 1*direction;
  if (elem1.theme < elem2.theme) then
    result := -1*direction;
  if (elem1.theme = elem2.theme) then
    result := 0;

end;

function cmpPlace(elem1, elem2: TData; direction: integer): integer;
begin

  if (elem1.place > elem2.place) then
    result := 1*direction;
  if (elem1.place < elem2.place) then
    result := -1*direction;
  if (elem1.place = elem2.place) then
    result := 0;

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

function CopyList(head: PPicElem): PPicElem;
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

    if (newHead = nil) then
    begin
      newHead := newNode;
    end
    else
    begin
      newNode^.Next := newHead;
      newHead := newNode;
    end;

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

  tempHead := CopyList(head);

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
procedure TFGallery.FormShow(Sender: TObject);
begin
  ActiveControl := PanelSideBar ; // Set focus to form
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
        sortedHead := MergeSort(head, sortDirection, cmpTitle);
        ReCreateAllPanels(sortedHead);
        sortDirection := 1;
      end;
      2: // year of start
      begin
        sortedHead := MergeSort(head, sortDirection, cmpYearStart);
        ReCreateAllPanels(sortedHead);
      end;
      3: // year of end
      begin
        sortedHead := MergeSort(head, sortDirection, cmpYearEnd);
        ReCreateAllPanels(sortedHead);
      end;
      4: // years of work
      begin
        sortedHead := MergeSort(head, sortDirection, cmpYearsWork);
        ReCreateAllPanels(sortedHead);
      end;
      5: // genre
      begin
        sortedHead := MergeSort(head, sortDirection, cmpGenre);
        ReCreateAllPanels(sortedHead);
      end;
      6: // theme
      begin
        sortedHead := MergeSort(head, sortDirection, cmpTheme);
        ReCreateAllPanels(sortedHead);
      end;
      7: // place
      begin
        sortedHead := MergeSort(head, sortDirection, cmpPlace);
        ReCreateAllPanels(sortedHead);
      end;
      8: // user rate
      begin
        sortedHead := MergeSort(head, sortDirection, cmpUserRate);
        ReCreateAllPanels(sortedHead);
      end;
    end;




  end;
end;



//---------------------------------------------------------------------------------
// SORT section END


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
  end;

 end;

function searchData(head: PPicElem; infoToSearch: string; fieldSearch: integer ): PPicElem;
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

  Result^.Next := nil

end;

procedure TFGallery.EditSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin



  // check if the user pressed the Enter key
  if Key = VK_RETURN then
  begin
    if (CmbBxSearchParam.Text <> '') and (Trim(EditSearch.Text) <> '')  then
    begin
      searchedHead := SearchData(head, EditSearch.Text, CmbBxSearchParam.ItemIndex);

      ReCreateAllPanels(searchedHead);
    end;
  end;


end;







// SEARCH section END


procedure TFGallery.FormCreate(Sender: TObject);
begin

  FetchAllPics(head);
  LoadImages(head);
  ReCreateAllPanels(head);

  // search params
  CmbBxSearchParam.Items.Add('');
  CmbBxSearchParam.Items.Add('Название');
  CmbBxSearchParam.Items.Add('Год начала');
  CmbBxSearchParam.Items.Add('Год конца');
  CmbBxSearchParam.Items.Add('Число лет');
  CmbBxSearchParam.Items.Add('Жанр');
  CmbBxSearchParam.Items.Add('Тематика');
  CmbBxSearchParam.Items.Add('Место написания');
  CmbBxSearchParam.Items.Add('Материалы');
  CmbBxSearchParam.Items.Add('Описание');
  CmbBxSearchParam.Items.Add('Комментарий');
  CmbBxSearchParam.Items.Add('Все');

  // filter params
  CmbBxFilter.Items.Add('');
  CmbBxFilter.Items.Add('Избранное');
  CmbBxFilter.Items.Add('Оценка');

  // sort params
  CmbBxSort.Items.Add('');
  CmbBxSort.Items.Add('Название');
  CmbBxSort.Items.Add('Год начала');
  CmbBxSort.Items.Add('Год конца');
  CmbBxSort.Items.Add('Число лет');
  CmbBxSort.Items.Add('Жанр');
  CmbBxSort.Items.Add('Тематика');
  CmbBxSort.Items.Add('Место написания');
  CmbBxSort.Items.Add('Оценка');


  // sort dir
  CmbBxSortDir.Items.Add('');
  CmbBxSortDir.Items.Add('По возрастанию');
  CmbBxSortDir.Items.Add('По убыванию');



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

procedure TFGallery.OpenFileClick(Sender: TObject);
Var
    GalleryFile: TextFile;
begin
    If OpenDialog1.Execute() Then
    begin
      AssignFile(GalleryFile, OpenDialog1.Files[0]);
      Try
        Reset(GalleryFile);
      Finally
        CloseFile(GalleryFile);
      End;
    end;




end;

end.
