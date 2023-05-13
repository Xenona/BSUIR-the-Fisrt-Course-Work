program gallery;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  BigPic in 'BigPic.pas' {FBigPic},
  {$R}
  {$R}
  SharedTypes in 'SharedTypes.pas' {$R *.res},
  MainMenu in 'MainMenu.pas' {TFMenu},
  Biography in 'Biography.pas' {Bio},
  Developer in 'Developer.pas' {Form2},
  Stack in 'Stack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Smokey Quartz Kamri');

  Application.CreateForm(TFGallery, FGallery);
  Application.CreateForm(TTFMenu, TFMenu);
  Application.CreateForm(TFBigPic, FBigPic);
  Application.CreateForm(TBio, Bio);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
