unit payloads;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, target, Vcl.Controls,
  WEBLib.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCListBox,
  misc;

type
  TfrmPayloads = class(TfrmTarget)
    pnlPayload1: TWebPanel;
    pnlPayload3: TWebPanel;
    pnlPayload2: TWebPanel;
    lstPayload2: TTMSFNCListBox;
    lstPayload1: TTMSFNCListBox;
    lstPayload3: TTMSFNCListBox;
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
    function ListBoxForIndex(Index: Integer): TTMSFNCListBox;
  public
    { Public declarations }
    procedure NewPosition(Index: Integer; Position: THABPosition); override;
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}

procedure TfrmPayloads.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    pnlPayload1.ElementClassName := 'ColumnRoundedCorners';
    pnlPayload2.ElementClassName := 'ColumnRoundedCorners';
    pnlPayload3.ElementClassName := 'ColumnRoundedCorners';
end;

procedure TfrmPayloads.MiletusFormResize(Sender: TObject);
begin
    inherited;

    pnlPayload1.Width := (Self.Width - (pnlPayload1.Margins.Left * 4)) div 3;
    pnlPayload2.Width := pnlPayload1.Width;
end;

function TfrmPayloads.ListBoxForIndex(Index: Integer): TTMSFNCListBox;
begin
    case Index of
        1:  Result := lstPayload1;
        2:  Result := lstPayload2;
        3:  Result := lstPayload3;
        else Result := nil;
    end;

end;

procedure TfrmPayloads.NewPosition(Index: Integer; Position: THABPosition);
var
    ListBox: TTMSFNCListBox;
begin
    ListBox := ListBoxForIndex(Index);

    if ListBox <> nil then begin
        ListBox.Items[0].Text := Position.PayloadID;
        ListBox.Items[1].Text := FormatDateTime('hh:nn:ss', Position.TimeStamp);
        ListBox.Items[2].Text := FormatFloat('0.00000', Position.Latitude);
        ListBox.Items[3].Text := FormatFloat('0.00000', Position.Longitude);
        ListBox.Items[4].Text := FormatFloat('0', Position.Altitude) + ' m';
        ListBox.Items[5].Text := IntToStr(Position.Satellites) + ' sats';
    end;
end;

initialization
  RegisterClass(TfrmPayloads);

end.