unit splash;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls, Vcl.Imaging.jpeg;

type
  TfrmSplash = class(TfrmBase)
    WebImageControl1: TWebImageControl;
    lblSplash: TWebLabel;
    lblStatus: TWebLabel;
    procedure MiletusFormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.MiletusFormResize(Sender: TObject);
begin
    inherited;

    lblSplash.Left := (Width - lblSplash.Width) div 2;
    lblSplash.Top := (Height - lblSplash.Height) div 2;

    lblStatus.Left := (Width - lblStatus.Width) div 2;
    lblStatus.Top := 5 * (Height - lblStatus.Height) div 6;
end;

initialization
  RegisterClass(TfrmSplash);

end.