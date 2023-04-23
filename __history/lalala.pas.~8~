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
    Button1: TButton;
    ScrollBox1: TScrollBox;
    FlowPanel1: TFlowPanel;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    OpenFile: TMenuItem;
    SaveFile: TMenuItem;
    HelpMenu: TMenuItem;
    DeveloperMenu: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);

  private
    { Private declarations }
  public
     head: PPicElem;
  end;

var
  FGallery: TFGallery;

implementation

{$R *.dfm}


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
  readPicList := nil;
  closeFile(storageFile);
  readPicList := head;
  head := readPicList^.Next;
  dispose(readPicList);

end;

// load corresponding pics to imgBuffer field;
//procedure LoadImages(PicList: PPicElem);
//var
//  SearchRec: TSearchRec;
//  FileName: string;
//  BasePath: string;
//  breakFlag: Boolean;
//begin
//  BasePath := ExtractFilePath(ParamStr(0)) + 'src\';
//  if FindFirst(BasePath + '*.bmp', faAnyFile, SearchRec) = 0 then
//  begin
//    while not breakFlag and (FindNext(SearchRec) = 0) do
//    begin
//      breakFlag := False;
//      FileName := SearchRec.Name;
//      // Find the corresponding element in the list
//      while PicList <> nil do
//      begin
//        if SameText(PicList^.data.filename, FileName) then
//        begin
//          // Load the image into the buffer
//          PicList^.data.imgBuffer.LoadFromFile(BasePath + FileName);
//          breakFlag := True;
//        end;
//        PicList := PicList^.Next;
//      end;
//    end;
//  end;
//  FindClose(SearchRec);
//end;



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
  Panel.Height := 200;
  Panel.Width := 200;

  Image := TImage.Create(Panel);
  Image.Parent := Panel;
  Image.AutoSize := False;
  Scale := Min(Panel.ClientWidth / APic.Width, Panel.ClientHeight / APic.Height);
  Image.Width := Round(APic.Width * Scale);
  Image.Height := Round(APic.Height * Scale);
  Image.Left := (Panel.Width - Image.Width) div 2;
  Image.Top := (Panel.Height - Image.Height) div 2;
  Image.Picture.Assign(APic);

  LabelTitle := TLabel.Create(Panel);
  LabelTitle.Parent := Panel;
  LabelTitle.Caption := ATitle;
  LabelTitle.AutoSize := True;
  LabelTitle.Left := Margin;
  LabelTitle.Top := Panel.Height - Margin - LabelTitle.Height;
end;




procedure CreatePanelWithImageAndLabel(AOwner: TComponent; const ACaption, AImagePath, ALabelText: string; AParentFlowPanel: TFlowPanel);
var
  Panel: TPanel;
  Image: TImage;
  ImgLabel: TLabel;
  ImageWidth, ImageHeight: Integer;
begin
  // Create the panel
  Panel := TPanel.Create(AOwner);
  Panel.Parent := AParentFlowPanel;
  Panel.Align := alTop;
  Panel.Caption := ACaption;
  Panel.BevelOuter := bvNone;
  Panel.Height := 150;
  Panel.Color := clWhite;
  Panel.BorderStyle := bsNone;
  Panel.ParentBackground := False;
  Panel.Alignment := taCenter;

//
  ImgLabel := TLabel.Create(Panel);
  ImgLabel.Parent := Panel;

  ImgLabel.Height := ImgLabel.Canvas.TextHeight(ALabelText);


  // Create the image
  Image := TImage.Create(Panel);
  Image.Parent := Panel;
  Image.Align := alClient;
  Image.Picture.LoadFromFile(AImagePath);
  ImageWidth := Image.Picture.Width;
  ImageHeight := Image.Picture.Height;
  Image.Width := Round(ImageWidth*0.1);
  Image.Height := Round(ImageHeight*0.1);
  Image.Proportional := True;
  Image.Stretch := True;
  Image.Left := 10;
  Image.Top := 10;
  Image.Left := (Panel.Width - Image.Width) div 2;
  Image.Top := (Panel.Height - Image.Height - ImgLabel.Height) div 2;

  // Create the label


  ImgLabel.AutoSize := True;
  ImgLabel.WordWrap := True;
  ImgLabel.Caption := ALabelText;
  ImgLabel.Left := Image.Left;
  ImgLabel.Top := Panel.Height - 20; //Image.Top + ImageHeight + 100;
  ImgLabel.Width := Image.Width;
  ImgLabel.Left := (Panel.Width - ImgLabel.Width) div 2;
  ImgLabel.Top := Image.Top + Image.Height + 10;
end;




procedure TFGallery.Button1Click(Sender: TObject);
begin

//  CreatePanelWithImageAndLabel(Self, 'My Panel', 'C:\Users\HP\Desktop\uchebka\year1\OAIP\theCoursach\src\spring-1896.bmp', 'My label', FlowPanel1);
//
//  ChangeFileExt(OpenDialog1.FileName, '.dat');



//  FlowPanel1.Height := FlowPanel1.Height + 80;


//Caption := Application.Title;

  FetchAllPics(head);
//  LoadImages(head);
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
