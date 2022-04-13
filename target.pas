unit target;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, misc;

type
  TfrmTarget = class(TfrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NewPosition(PayloadIndex: Integer; Position: THABPosition); virtual;
  end;

implementation

{$R *.dfm}

procedure TfrmTarget.NewPosition(PayloadIndex: Integer; Position: THABPosition);
begin
    // virtual
end;

//initialization
//  RegisterClass(TfrmTarget);

end.