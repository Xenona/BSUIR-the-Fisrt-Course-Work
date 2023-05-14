program gallery;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  BigPic in 'BigPic.pas' {FBigPic},
  SharedTypes in 'SharedTypes.pas' {$R *.res},
  MainMenu in 'MainMenu.pas' {TFMenu},
  Biography in 'Biography.pas' {Bio},
  Developer in 'Developer.pas' {FDeveloper},
  Stack in 'Stack.pas',
  SlideShow in 'SlideShow.pas' {FSlide};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Smokey Quartz Kamri');


  Application.CreateForm(TFDeveloper, FDeveloper);
  Application.CreateForm(TTFMenu, TFMenu);
  Application.CreateForm(TBio, Bio);
  Application.CreateForm(TFGallery, FGallery);
  Application.CreateForm(TFBigPic, FBigPic);


  Application.CreateForm(TFSlide, FSlide);
  Application.Run;
end.
