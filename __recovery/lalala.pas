unit lalala;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, Math;

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
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    FlowPanelPics: TFlowPanel;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    OpenFile: TMenuItem;
    SaveFile: TMenuItem;
    HelpMenu: TMenuItem;
    DeveloperMenu: TMenuItem;
    OpenDialog1: TOpenDialog;
    ComboBoxAlbum: TComboBox;
    LabelAlbum: TLabel;
    LabelSearch: TLabel;
    LabelParam: TLabel;
    LabelFilter: TLabel;
    ComboBoxParam: TComboBox;
    ComboBoxFilter: TComboBox;
    Bevel1: TBevel;
    EditSearch: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    ButtonSlideshow: TButton;
    procedure OpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
  public
     head: PPicElem;
  end;

var
  FGallery: TFGallery;

implementation

{$R *.dfm}
{$D+}



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
  Panel.ParentBackground := False;
  Panel.ParentColor := False;
  // appear again in onResize



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

procedure ShowAllPics(CurrentPic: PPicElem);
begin
  while (CurrentPic <> nil) do
  begin

    CreatePicPanel(FGallery, FGallery.FlowPanelPics, CurrentPic^.data.imgBuffer, CurrentPic^.data.title);
    CurrentPic := CurrentPic^.Next;

  end;
end;

procedure TFGallery.FormShow(Sender: TObject);
begin
  ActiveControl := Panel1 ; // Set focus to form
end;

procedure TFGallery.FormCreate(Sender: TObject);
begin
  FetchAllPics(head);
  LoadImages(head);
  ShowAllPics(head);


  ComboBoxFilter.Items.Add('Option 1');
  ComboBoxFilter.Items.Add('Option 2');
  ComboBoxFilter.Items.Add('Option 3');






end;

procedure TFGallery.FormResize(Sender: TObject);
var
  currNumOfPics: Integer;
begin

  // appear again in CreatePicPanel
  currNumOfPics := FlowPanelPics.ControlCount;
  try
    FlowPanelPics.Height := Max(270*(currNumOfPics div (FlowPanelPics.Width div 210) + 1), Panel1.Height);
  finally

  end;
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
