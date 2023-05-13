unit SlideShow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFSlide = class(TForm)
    ImageSlide: TImage;
    PanelSlide: TPanel;
    procedure LoadSlide(PanelPic: TPanel; Image: TImage; Picture: TPicture; Margin: Integer);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSlide: TFSlide;

implementation

{$R *.dfm}


procedure TFSlide.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
      If Msg.CharCode = VK_ESCAPE Then
    Close;
end;

procedure TFSLide.LoadSlide(PanelPic: TPanel; Image: TImage; Picture: TPicture; Margin: Integer);
var
  Ratio, PanelRatio: Single;
begin

  Ratio := Picture.Width / Picture.Height;

  PanelRatio := PanelPic.ClientWidth / PanelPic.ClientHeight;

  if Ratio > PanelRatio then
  begin

    Image.Width := PanelPic.ClientWidth - 2 * Margin;
    Image.Height := Round((PanelPic.ClientWidth - 2 * Margin) / Ratio);
  end
  else
  begin

    Image.Height := PanelPic.ClientHeight - 2 * Margin;
    Image.Width := Round((PanelPic.ClientHeight - 2 * Margin) * Ratio);
  end;

  Image.Left := (PanelPic.ClientWidth - Image.Width) div 2;
  Image.Top := (PanelPic.ClientHeight - Image.Height) div 2;
end;






end.
