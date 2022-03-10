unit direction;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, target, Vcl.Controls,
  WEBLib.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWidgetGauge,
  Vcl.StdCtrls, WEBLib.StdCtrls, misc;

type
  TfrmDirection = class(TfrmTarget)
    pnlPosition: TWebPanel;
    WebPanel2: TWebPanel;
    pnlDistance: TWebPanel;
    WebPanel4: TWebPanel;
    WebPanel3: TWebPanel;
    pnlAltitude: TWebPanel;
    WebPanel6: TWebPanel;
    pnlAscentRate: TWebPanel;
    WebPanel8: TWebPanel;
    pnlTTL: TWebPanel;
    WebPanel10: TWebPanel;
    pnlElevation: TWebPanel;
    Compass: TTMSFNCWidgetGauge;
    WebTimer1: TWebTimer;
    procedure MiletusFormResize(Sender: TObject);
    procedure CompassGetValueText(Sender: TObject; value: Double;
      var str: string);
    procedure MiletusFormCreate(Sender: TObject);
    procedure WebTimer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure DoDistanceAndDirection;
  public
    { Public declarations }
    procedure AfterShow; override;
    procedure NewPosition(PayloadIndex: Integer; Position: THABPosition); override;
  end;

var
  frmDirection: TfrmDirection;

implementation

{$R *.dfm}

uses Main;

procedure TfrmDirection.CompassGetValueText(Sender: TObject; value: Double;
  var str: string);
begin
    if value = 270 then begin
        str := 'N';
    end else if value = 315 then begin
        str := 'NE';
    end else if value = 360 then begin
        str := 'E';
    end else if value = 45 then begin
        str := 'SE';
    end else if value = 90 then begin
        str := 'S';
    end else if value = 135 then begin
        str := 'SW';
    end else if value = 180 then begin
        str := 'W';
    end else if value = 225 then begin
        str := 'NW';
    end;
end;

procedure TfrmDirection.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    pnlPosition.ElementClassName := 'RoundedLabel';
    pnlDistance.ElementClassName := 'RoundedLabel';
    pnlAltitude.ElementClassName := 'RoundedLabel';
    pnlAscentRate.ElementClassName := 'RoundedLabel';
    pnlTTL.ElementClassName := 'RoundedLabel';
    pnlElevation.ElementClassName := 'RoundedLabel';
end;

procedure TfrmDirection.MiletusFormResize(Sender: TObject);
begin
//    Compass.Visible := True;

    //Compass.
//
//    Compass.Width := WebPanel4.Left;    // Height;
end;

procedure TfrmDirection.AfterShow;
begin
    inherited;

    WebTimer1.Enabled := True;
end;

procedure TfrmDirection.NewPosition(PayloadIndex: Integer; Position: THABPosition);
begin
    if PayloadIndex > 0 then begin
        pnlPosition.Caption := FormatFloat('0.00000', Position.Latitude) + ', ' + FormatFloat('0.00000', Position.Longitude);
        pnlAltitude.Caption := FormatFloat('0', Position.Altitude) + 'm';
        pnlAscentRate.Caption := FormatFloat('0.0', Position.AscentRate) + 'm/s';
    end;

    DoDistanceAndDirection;
end;

procedure TfrmDirection.WebTimer1Timer(Sender: TObject);
begin
    WebTimer1.Enabled := False;
    Compass.Visible := True;
end;

procedure TfrmDirection.DoDistanceAndDirection;
var
    Distance, Direction, Elevation: Double;
begin
    inherited;

    if frmMain.SelectedIndex > 0 then begin
    //    if LCARSLabelIsChecked(chkPrediction) and Positions[SelectedIndex].Position.ContainsPrediction then begin
    //        Distance := Positions[SelectedIndex].Position.PredictionDistance;
    //        Direction := Positions[SelectedIndex].Position.PredictionDirection;
    //    end else begin
            Distance := frmMain.Payloads[frmMain.SelectedIndex].Position.Distance;
            Direction := frmMain.Payloads[frmMain.SelectedIndex].Position.Direction;
    //    end;

        Direction := Direction * 180 / Pi + 90;
        if Direction > 360 then Direction := Direction - 360;
        if Direction < 0 then Direction := Direction + 360;

//        Compass.Value := Direction;

        if Distance >= 1000 then begin
            pnlDistance.Caption := FormatFloat('0.0', Distance/1000) + ' km';
        end else begin
            pnlDistance.Caption := FormatFloat('0', Distance) + ' m';
        end;

        Elevation := frmMain.Payloads[frmMain.SelectedIndex].Position.Elevation;

        // Altitude, or vertical distance to payload, as appropriate
    //    if not IsNan(Positions[0].Position.Altitude) then begin
    //        if Positions[SelectedIndex].Position.Altitude >= (Positions[0].Position.Altitude + 2000) then begin
    //            lblRelativeAltitude.Text := '';
    //        end else if Positions[SelectedIndex].Position.Altitude >= Positions[0].Position.Altitude then begin
    //            lblRelativeAltitude.Text := '+' + IntToStr(Round(Positions[SelectedIndex].Position.Altitude - Positions[0].Position.Altitude)) + 'm';
    //        end else begin
    //            lblRelativeAltitude.Text := IntToStr(Round(Positions[SelectedIndex].Position.Altitude - Positions[0].Position.Altitude)) + 'm';
    //        end;
    //    end;

        if frmMain.Payloads[frmMain.SelectedIndex].Position.FlightMode = fmDescending then begin
            pnlTTL.Caption := FormatDateTime('nn:ss', frmMain.Payloads[frmMain.SelectedIndex].Position.DescentTime);
        end else begin
            pnlTTL.Caption := '';
        end;

        pnlElevation.Caption := FormatFloat('0', Elevation) + ' °';
    end;
end;


initialization
  RegisterClass(TfrmDirection);

end.