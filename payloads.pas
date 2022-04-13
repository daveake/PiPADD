unit payloads;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, target, Vcl.Controls,
  WEBLib.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCListBox,
  misc, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmPayloads = class(TfrmTarget)
    pnlPayload1: TWebPanel;
    pnlPayload3: TWebPanel;
    pnlPayload2: TWebPanel;
    lstPayload3: TTMSFNCListBox;
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
    Labels: Array[1..3, 1..6] of TWebLabel;
  public
    { Public declarations }
    procedure NewPosition(Index: Integer; Position: THABPosition); override;
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}

procedure TfrmPayloads.MiletusFormCreate(Sender: TObject);
var
    i, j: Integer;
begin
    inherited;


    for j := 1 to 3 do begin
        for i := 1 to 6 do begin
            Labels[j, i] := TWebLabel.Create(nil);
            with Labels[j, i] do begin
                Height := 45;
                Align := alTop;
                Alignment := taCenter;
                Font.Color := clWhite;
                Font.Height := -32;
                case j of
                    1:  Parent := pnlPayload1;
                    2:  Parent := pnlPayload2;
                    3:  Parent := pnlPayload3;
                end;
            end;
        end;
    end;

//
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


procedure TfrmPayloads.NewPosition(Index: Integer; Position: THABPosition);
begin
    if Index in [1..3] then begin
        Labels[Index, 1].Caption := Position.PayloadID;
        Labels[Index, 2].Caption := FormatDateTime('hh:nn:ss', Position.TimeStamp);
        Labels[Index, 3].Caption := FormatFloat('0.00000', Position.Latitude);
        Labels[Index, 4].Caption := FormatFloat('0.00000', Position.Longitude);
        Labels[Index, 5].Caption := FormatFloat('0', Position.Altitude) + ' m';
        Labels[Index, 6].Caption := IntToStr(Position.Satellites) + ' sats';
    end;
end;

initialization
  RegisterClass(TfrmPayloads);

end.