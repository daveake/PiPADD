unit ssdv;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  WEBLib.ExtCtrls, WEBLib.WebCtrls;

type
  TfrmSSDV = class(TfrmBase)
    Browser: TWebBrowserControl;
    procedure MiletusFormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterShow; override;
    procedure SetPayloadList(PayloadList: String);
  end;

var
  frmSSDV: TfrmSSDV;

implementation

{$R *.dfm}

procedure TfrmSSDV.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmSSDV.AfterShow;
begin
    inherited;
    SetPayloadList('');
end;

procedure TfrmSSDV.SetPayloadList(PayloadList: String);
begin
    Browser.Navigate('http://ssdv.habhub.org/' + PayloadList);
end;

initialization
  RegisterClass(TfrmSSDV);

end.