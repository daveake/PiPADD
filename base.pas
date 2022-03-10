
unit base;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs;

type
  TfrmBase = class(TMiletusForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterLoad; virtual;
    procedure AfterShow; virtual;
  end;

implementation

{$R *.dfm}

uses Main;

procedure TfrmBase.AfterLoad;
begin
    // virtual
end;

procedure TfrmBase.AfterShow;
begin
    // virtual
end;


initialization
  RegisterClass(TfrmBase);

end.