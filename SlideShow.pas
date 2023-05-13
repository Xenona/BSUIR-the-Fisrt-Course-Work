unit SlideShow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFSlide = class(TForm)
    ImageSlide: TImage;
    PanelSlide: TPanel;
    LabelBG: TLabel;
    procedure LoadSlide(PanelPic: TPanel; Image: TImage; Picture: TPicture; Margin: Integer);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure SetInterrupt(const Value: Boolean);
    function GetInterrupt: Boolean;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public

    isInterrupt: Boolean;
    property Interrupt: Boolean read GetInterrupt write SetInterrupt;
  end;

var
  FSlide: TFSlide;

implementation

{$R *.dfm}


function TFSlide.GetInterrupt: Boolean;
begin
  Result := isInterrupt;
end;

procedure TFSlide.SetInterrupt(const Value: Boolean);
begin
  isInterrupt := Value;
end;

procedure TFSlide.FormActivate(Sender: TObject);
begin
 isInterrupt := False;
end;

procedure TFSlide.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
      If Msg.CharCode = VK_SPACE Then
      begin
          Close;
          FSlide.Interrupt := True;
      end;

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
