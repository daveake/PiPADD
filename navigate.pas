unit navigate;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  WEBLib.ExtCtrls;

type
  TfrmNavigate = class(TfrmBase)
    WebPanel1: TWebPanel;
    procedure MiletusFormResize(Sender: TObject);
    procedure WebPanel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNavigate: TfrmNavigate;

implementation

{$R *.dfm}

uses Main;

procedure TfrmNavigate.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmNavigate.WebPanel1Click(Sender: TObject);
begin
    frmMain.ShowRouteToPayload(1, False);
end;

initialization
  RegisterClass(TfrmNavigate);

end.