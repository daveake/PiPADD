unit fake_gps;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, gps, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls;

type
  TfrmFakeGPS = class(TfrmGPS)
    WebTimer1: TWebTimer;
    procedure WebTimer1Timer(Sender: TObject);
    procedure MiletusFormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFakeGPS: TfrmFakeGPS;

implementation

{$R *.dfm}

procedure TfrmFakeGPS.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmFakeGPS.WebTimer1Timer(Sender: TObject);
begin
    ProcessLine('$GPGGA,' + FormatDateTime('hhnnss', Now) + '.00,5157.01015,N,00232.65175,W,1,10,0.85,147.5,M,48.6,M,,*4E');
end;

initialization
  RegisterClass(TfrmFakeGPS);

end.