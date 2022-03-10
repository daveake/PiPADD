unit uplink;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  WEBLib.ExtCtrls;

type
  TfrmUplink = class(TfrmBase)
    WebPanel1: TWebPanel;
    procedure MiletusFormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUplink: TfrmUplink;

implementation

{$R *.dfm}

procedure TfrmUplink.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

initialization
  RegisterClass(TfrmUplink);

end.