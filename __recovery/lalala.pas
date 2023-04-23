unit lalala;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, Math;

type
  PPicElem=^TPicElems;

  Tdata = packed record
    title: string[20];
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
    FlowPanel1: TFlowPanel;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    OpenFile: TMenuItem;
    SaveFile: TMenuItem;
    HelpMenu: TMenuItem;
    DeveloperMenu: TMenuItem;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    procedure OpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

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
  Margin := 20;
  Panel.Margins.Left := Margin;
  Panel.Margins.Top := Margin;
  Panel.Margins.Right := Margin;
  Panel.Margins.Bottom := Margin;
  Panel.BevelOuter := bvNone;
  Panel.Height := 220;
  Panel.Width := 220;



  Image := TImage.Create(Panel);
  Image.Parent := Panel;
  Image.AutoSize := False;
  Image.Stretch := True;

  Scale := Min((Panel.ClientWidth - Margin) / APic.Width, (Panel.ClientHeight - Margin) / APic.Height);
  Image.Width := Round((APic.Width) * Scale);
  Image.Height := Round((APic.Height) * Scale);
  Image.Left := (Panel.Width - Image.Width + Margin) div 2;
  Image.Top := (Panel.Height - Image.Height) div 2;
  Image.Picture.Assign(APic);



  LabelTitle := TLabel.Create(Panel);
  LabelTitle.Parent := Panel;
  LabelTitle.Caption := ATitle;
  LabelTitle.AutoSize := True;
  LabelTitle.Left := Image.Left;
  LabelTitle.Font.Name := 'Montserrat';
  LabelTitle.Font.Size := 12;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Font.Color := clWhite;
  LabelTitle.Top := Image.Top + Image.Height;
  LabelTitle.Color := clWhite;




end;

procedure ShowAllPics(CurrentPic: PPicElem);
begin
  while (CurrentPic <> nil) do
  begin

    CreatePicPanel(FGallery, FGallery.FlowPanel1, CurrentPic^.data.imgBuffer, CurrentPic^.data.title);
    CurrentPic := CurrentPic^.Next;

  end;
end;


procedure TFGallery.FormCreate(Sender: TObject);
begin
  FetchAllPics(head);
  LoadImages(head);
  ShowAllPics(head);
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
