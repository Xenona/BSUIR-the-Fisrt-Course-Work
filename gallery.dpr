program gallery;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  BigPic in 'BigPic.pas' {FBigPic},

  SharedTypes in 'SharedTypes.pas' {$R *.res},
  MainMenu in 'MainMenu.pas' {TFMenu},
  Biography in 'Biography.pas' {Bio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Smokey Quartz Kamri');

  Application.CreateForm(TTFMenu, TFMenu);
  Application.CreateForm(TFGallery, FGallery);
  Application.CreateForm(TFBigPic, FBigPic);
  Application.CreateForm(TBio, Bio);
  Application.Run;
end.
