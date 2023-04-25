program gallery;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  BigPic in 'BigPic.pas' {FBigPic};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Smokey Quartz Kamri');
  Application.CreateForm(TFGallery, FGallery);
  Application.CreateForm(TFBigPic, FBigPic);
  Application.Run;
end.
