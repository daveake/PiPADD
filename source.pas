unit source;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls, WEBLib.FlexControls;

type
  TfrmSource = class(TfrmBase)
    lblStatus: TWebLabel;
    lblPosition: TWebLabel;
    lblSource: TWebLabel;
    WebLabel1: TWebLabel;
    procedure WebLabel1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    SettingsPageIndex: Integer;
  public
    { Public declarations }
    procedure Initialise; virtual;
  end;


implementation

{$R *.dfm}

uses Main;

procedure TfrmSource.Initialise;
begin
    // Virtual
end;

procedure TfrmSource.WebLabel1Click(Sender: TObject);
begin
    frmMain.ShowSettings(SettingsPageIndex);
end;

initialization
  RegisterClass(TfrmSource);

end.