unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TTFMenu = class(TForm)
    MainContainer: TPanel;
    ButtContainer: TPanel;
    ButtonExit: TButton;
    ButtonDeveloper: TButton;
    ButtonBiography: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    LabelTop: TLabel;
    Image1: TImage;
    Image2: TImage;
    ButtonOpenGallery: TButton;
    Panel4: TPanel;
    procedure Panel1Resize(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButtonOpenGalleryClick(Sender: TObject);
    procedure ButtonBiographyClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TFMenu: TTFMenu;

implementation

uses MainForm, Biography;

{$R *.dfm}

procedure TTFMenu.ButtonOpenGalleryClick(Sender: TObject);
begin
  TFMenu.Visible := False;
  FGallery.Show;
end;

procedure TTFMenu.ButtonBiographyClick(Sender: TObject);
begin
  TFMenu.Visible := False;
  Bio.Show;
end;

procedure TTFMenu.ButtonExitClick(Sender: TObject);
begin
  TFMenu.Close;
end;




procedure TTFMenu.Panel1Resize(Sender: TObject);
begin
  ButtContainer.Left := (TFMenu.Width - (ButtContainer.Width * 4 div 3)) div 2 - 50;
  ButtContainer.Top := (TFMenu.Height - ButtContainer.Height) * 2 div 3 + 50;
  labelTop.Left := ButtContainer.Left;
  labelTop.Top := ButtContainer.Top - LabelTop.Height - 100;

end;

end.
