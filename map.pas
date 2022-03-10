unit map;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, target, VCL.TMSFNCTypes,
  VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCMapsCommonTypes, Vcl.Controls, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser, VCL.TMSFNCMaps, WEBLib.TMSFNCDirections,
  misc, Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls,
  VCL.TMSFNCGoogleMaps;

type
  TMapFollowMode = (mmIdle, mmInit, mmHome, mmFree, mmCar, mmPayload);

type
  TMapPayload = record
      Marker, Landing:  TTMSFNCMapsMarker;
      MarkerName:       String;
      Track:            TTMSFNCMapsPolyline;
      Horizon:          Array[0..1] of TTMSFNCMapsCircle;
  end;

type
  TfrmMap = class(TfrmTarget)
    FNCMap: TTMSFNCGoogleMaps;
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
    procedure FNCMapElementContainers0Actions0Execute(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure FNCMapElementContainers0Actions1Execute(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure FNCMapElementContainers0Actions2Execute(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure FNCMapElementContainers0Actions3Execute(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
  private
    { Private declarations }
    Balloons: Array[0..3] of TMapPayload;
    FollowMode: TMapFollowMode;
    procedure AddOrUpdateBalloon(PayloadIndex: Integer; PayloadID: String; Latitude: Double; Longitude: Double; ImageName: String; Landing: Boolean);
    procedure AddOrUpdateMapMarker(PayloadIndex: Integer; PayloadID: String; Latitude: Double; Longitude: Double; ImageName: String);
    procedure DrawHorizon(PayloadIndex: Integer; Position: THABPosition);
    procedure DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor);
    procedure ShowSelectedMapButton(ElementID: String);
  public
    { Public declarations }
    procedure NewPosition(PayloadIndex: Integer; Position: THABPosition); override;
  end;

var
  frmMap: TfrmMap;

implementation

{$R *.dfm}

uses Main;

// IF THE FOLLOWING LINE GIVES AN ERROR

{$INCLUDE 'key.pas'}

(* THEN CREATE A FILE key.pas CONTAINING:

const GoogleMapsAPIKey = '<YOUR_GOOGLE_API_KEY>';

THIS FILE IS SPECIFICALLY EXCLUDED in .gitignore TO AVOID SHARING API KEYS
*)

procedure TfrmMap.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    FNCMap.APIKey := GoogleMapsAPIKey;
end;

procedure TfrmMap.MiletusFormResize(Sender: TObject);
begin
    inherited;

//    FNCMap.Width := Width;
//    FNCMap.Height := Height;
end;

function BalloonIconName(PayloadIndex: Integer; FlightMode: TFlightMode; Target: Boolean=False): String;
const
    ColourNames: Array[0..2] of String = ('blue', 'red', 'green');
var
    ColourName: String;
begin
    ColourName := ColourNames[(PayloadIndex - 1) mod 3];

    if Target then begin
        Result := 'x-' + ColourName;
    end else begin
        Result := 'balloon-' + ColourName;

        case FlightMode of
            fmIdle:         Result := 'payload-' + ColourName;
            fmLaunched:     Result := 'balloon-' + ColourName;
            fmDescending:   Result := 'parachute-' + ColourName;
            fmLanded:       Result := 'payload-' + ColourName;
        end;
    end;
end;


procedure TfrmMap.AddOrUpdateMapMarker(PayloadIndex: Integer; PayloadID: String; Latitude: Double; Longitude: Double; ImageName: String);
var
    MarkerIndex: Integer;
begin
    if Balloons[PayloadIndex].Marker = nil then begin
        Balloons[PayloadIndex].Marker := FNCMap.Markers.Add;
        Balloons[PayloadIndex].Marker.Title := PayloadID;
    end;

    Balloons[PayloadIndex].Marker.Latitude := Latitude;
    Balloons[PayloadIndex].Marker.Longitude := Longitude;

    if ImageName <> Balloons[PayloadIndex].MarkerName then begin
        Balloons[PayloadIndex].MarkerName := ImageName;
        Balloons[PayloadIndex].Marker.IconURL := 'https://hab.daveakerman.com/markers/' + ImageName + '.png';
    end;
end;

procedure TfrmMap.AddOrUpdateBalloon(PayloadIndex: Integer; PayloadID: String; Latitude: Double; Longitude: Double; ImageName: String; Landing: Boolean);
var
    MarkerIndex: Integer;
begin
    if Landing then begin
        if Balloons[PayloadIndex].Landing = nil then begin
            Balloons[PayloadIndex].Landing := FNCMap.Markers.Add;
            Balloons[PayloadIndex].Landing.Title := PayloadID;
            Balloons[PayloadIndex].Landing.IconURL := 'https://hab.daveakerman.com/markers/' + ImageName + '.png';
        end;

        Balloons[PayloadIndex].Landing.Latitude := Latitude;
        Balloons[PayloadIndex].Landing.Longitude := Longitude;
    end else begin
        if Balloons[PayloadIndex].Marker = nil then begin
            Balloons[PayloadIndex].Marker := FNCMap.Markers.Add;
            Balloons[PayloadIndex].Marker.Title := PayloadID;
        end;

        Balloons[PayloadIndex].Marker.Latitude := Latitude;
        Balloons[PayloadIndex].Marker.Longitude := Longitude;

        if ImageName <> Balloons[PayloadIndex].MarkerName then begin
            Balloons[PayloadIndex].MarkerName := ImageName;
            Balloons[PayloadIndex].Marker.IconURL := 'https://hab.daveakerman.com/markers/' + ImageName + '.png';
        end;
    end;
end;

function BalloonColour(PayloadIndex: Integer): TColor;
const
    Colours: Array[0..2] of TColor = (clblue, clRed, clGreen);
begin
    Result := Colours[(PayloadIndex - 1) mod 3];
end;

procedure TfrmMap.NewPosition(PayloadIndex: Integer; Position: THABPosition);
begin
    if PayloadIndex = 0 then begin
        AddOrUpdateMapMarker(PayloadIndex, 'Car', Position.Latitude, Position.Longitude, 'car-blue');
        if FollowMode = mmCar then begin
            FNCMap.SetCenterCoordinate(Position.Latitude, Position.Longitude);

        end;
    end else begin
        AddOrUpdateBalloon(PayloadIndex,
                           Position.PayloadID,
                           Position.Latitude,
                           Position.Longitude,
                           BalloonIconName(PayloadIndex, Position.FlightMode),
                           False);

        DrawPath(PayloadIndex, Position, BalloonColour(PayloadIndex));

        DrawHorizon(PayloadIndex, Position);


        if (FollowMode = mmPayload) and (PayloadIndex = frmMain.SelectedIndex) then begin
            FNCMap.SetCenterCoordinate(frmMain.Payloads[PayloadIndex].Position.Latitude, frmMain.Payloads[PayloadIndex].Position.Longitude);
        end;

        if Position.ContainsPrediction then begin
            AddOrUpdateBalloon(PayloadIndex,
                               Position.PayloadID + '-X',
                               Position.PredictedLatitude,
                               Position.PredictedLongitude,
                               BalloonIconName(PayloadIndex, fmIdle, True),
                               True);
        end;
    end;
end;

procedure TfrmMap.DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor);
begin
    FNCMap.BeginUpdate;

    if Balloons[PayloadIndex].Track = nil then begin
        Balloons[PayloadIndex].Track := FNCMap.Polylines.Add;
        Balloons[PayloadIndex].Track.StrokeOpacity := 1;
        Balloons[PayloadIndex].Track.StrokeWidth := 2;
        Balloons[PayloadIndex].Track.StrokeColor := Colour;
    end;

    with Balloons[PayloadIndex].Track.Coordinates.Add do begin
        Latitude := Position.Latitude;
        Longitude := Position.Longitude;
    end;

    Balloons[PayloadIndex].Track.Visible := False;
    Balloons[PayloadIndex].Track.Visible := True;

    FNCMap.EndUpdate;
end;

procedure TfrmMap.FNCMapElementContainers0Actions0Execute(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
    ShowSelectedMapButton('btnCar');
    FollowMode := mmCar;
    FNCMap.SetCenterCoordinate(frmMain.Car.Position.Latitude, frmMain.Car.Position.Longitude);
end;

procedure TfrmMap.FNCMapElementContainers0Actions1Execute(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
    ShowSelectedMapButton('btnHAB');
    FollowMode := mmPayload;
    FNCMap.SetCenterCoordinate(frmMain.Payloads[frmMain.SelectedIndex].Position.Latitude, frmMain.Payloads[frmMain.SelectedIndex].Position.Longitude);
end;

procedure TfrmMap.FNCMapElementContainers0Actions2Execute(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
    ShowSelectedMapButton('btnFree');
    FollowMode := mmFree;
end;

procedure TfrmMap.FNCMapElementContainers0Actions3Execute(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
    with frmMain do begin
        if SelectedIndex > 0 then begin
            with Payloads[SelectedIndex].Position do begin
//            if UsePrediction then begin
//                ShowRouteOnMap(PredictedLatitude, PredictedLongitude, Car.Position.Latitude, Car.Position.Longitude);
//            end else begin
                FNCMap.AddDirections(Car.Position.Latitude, Car.Position.Longitude, Latitude, Longitude);
//            end;
            end;
        end;
    end;
end;

procedure TfrmMap.DrawHorizon(PayloadIndex: Integer; Position: THABPosition);
const
    Colors: Array[0..1] of TColor = (clBlue, clLime);
    Radius: Array[0..1] of Double = (0.0, 5.0);
var
    i: Integer;
begin
    for i := 0 to 1 do begin
        if Balloons[PayloadIndex].Horizon[i] = nil then begin
            Balloons[PayloadIndex].Horizon[i] := FNCMap.Circles.Add;
            Balloons[PayloadIndex].Horizon[i].StrokeColor := Colors[i];
            Balloons[PayloadIndex].Horizon[i].FillOpacity := 0;
            Balloons[PayloadIndex].Horizon[i].StrokeWidth := 2;
        end;

        Balloons[PayloadIndex].Horizon[i].Radius := Round(1000.0 * CalculateHorizonRadius(Position.Altitude, Radius[i]));
        Balloons[PayloadIndex].Horizon[i].Center.Latitude := Position.Latitude;
        Balloons[PayloadIndex].Horizon[i].Center.Longitude := Position.Longitude;
    end;
end;

procedure TfrmMap.ShowSelectedMapButton(ElementID: String);
begin
    FNCMap.ExecuteJavaScript('document.getElementById("btnCar").disabled = false');
    FNCMap.ExecuteJavaScript('document.getElementById("btnHAB").disabled = false');
    FNCMap.ExecuteJavaScript('document.getElementById("btnFree").disabled = false');

    FNCMap.ExecuteJavaScript('document.getElementById("' + ElementID + '").disabled = true');
end;

initialization
  RegisterClass(TfrmMap);

end.