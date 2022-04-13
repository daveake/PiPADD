unit habitat;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, source, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls, WEBLib.REST, Misc,
  DateUtils;

type
  TfrmHabitat = class(TfrmSource)
    httpPoll: TWebHttpRequest;
    tmrPoll: TWebTimer;
    httpCar: TWebHttpRequest;
    httpPayload: TWebHttpRequest;
    procedure tmrPollTimer(Sender: TObject);
    procedure httpPayloadError(Sender: TObject;
      ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
      var Handled: Boolean);
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
    [async]
    procedure PollServer;
    function ProcessHabitatResponse(Response: String): Integer;
  public
    { Public declarations }
    procedure UploadCarPosition(Callsign: String; Position: THABPosition);
    procedure UploadHABPosition(Callsign, Sentence: String);
  end;

var
  frmHabitat: TfrmHabitat;

implementation

{$R *.dfm}

uses Main;

procedure TfrmHabitat.tmrPollTimer(Sender: TObject);
begin
    tmrPoll.Enabled := False;

    try
        PollServer;
    finally
        tmrPoll.Interval := 15000;
        tmrPoll.Enabled := True;
    end;
end;

function GetJSONString(Line: String; FieldName: String; StringChar: String = '"'): String;
var
    Position: Integer;
begin
    // {"class":"POSN","payload":"NOTAFLIGHT","time":"13:01:56","lat":52.01363,"lon":-2.50647,"alt":5507,"rate":7.0}
    // "callsign": "R3330018"

    Position := Pos(StringChar + FieldName + StringChar + ':', Line);

    if Position > 0 then begin
        // Remove fieldname in quotes and ':'
        Line := Copy(Line, Position + Length(FieldName) + 3, 999);

        // Remove up to first quote

        Position := Pos(StringChar, Line);
        if (Position > 0) and (Position <= 2) then begin
            // Remove first quote
            Line := Copy(Line, Position+1, 999);

            // Find and trim to next quote
            Position := Pos(StringChar, Line);
            Result := Copy(Line, 1, Position-1);
        end else begin
            Position := Pos(',', Line);
            if Position = 0 then begin
                Position := Pos('}', Line);
            end;

            Result := Copy(Line, 1, Position-1);
        end;
    end else begin
        Result := '';
    end;
end;

function GetJSONFloat(Line: String; FieldName: String; StringChar: String = '"'): Double;
var
    Position: Integer;
begin
    // {"class":"POSN","payload":"NOTAFLIGHT","time":"13:01:56","lat":52.01363,"lon":-2.50647,"alt":5507,"rate":7.0}

    Position := Pos(StringChar + FieldName + StringChar + ':', Line);

    if Position > 0 then begin
        Line := Copy(Line, Position + Length(FieldName) + 3, 999);

        Position := Pos(',', Line);
        if Position = 0 then begin
            Position := Pos('}', Line);
        end else if Pos('}', Line) < Position then begin
            Position := Pos('}', Line);
        end;


        Line := Copy(Line, 1, Position-1);

        if Copy(Line, 1, 1) = StringChar then begin
            Line := Copy(Line,2, Length(Line)-2);
        end;

        try
            Result := StrToFloat(Line);
        except
            Result := 0;
        end;
    end else begin
        Result := 0;
    end;
end;

function GetJSONInteger(Line: String; FieldName: String; StringChar: String = '"'): LongInt;
var
    Position: Integer;
begin
    // {"class":"POSN","payload":"NOTAFLIGHT","time":"13:01:56","lat":52.01363,"lon":-2.50647,"alt":5507,"rate":7.0}

    Position := Pos(StringChar + FieldName + StringChar + ':', Line);

    if Position > 0 then begin
        Line := Copy(Line, Position + Length(FieldName) + 3, 999);

        Position := Pos(',', Line);
        if Position = 0 then begin
            Position := Pos('}', Line);
        end;

        Line := Copy(Line, 1, Position-1);

        if Copy(Line, 1, 1) = StringChar then begin
            Line := Copy(Line,2, Length(Line)-2);
        end;

        Result := StrToIntDef(Line, 0);
    end else begin
        Result := 0;
    end;
end;

function TfrmHabitat.ProcessHabitatResponse(Response: String): Integer;
var
    Strings: TStringList;
    i: Integer;
    Line, Temp: String;
begin
    Result := 0;

    Strings := TStringList.Create;
    Strings.Text := Response;

    for i := 0 to Strings.Count-1 do begin
        Line := Strings[i];
        if GetJSONInteger(Line, 'position_id') > 0 then begin
            with HABPositions[HABHUB_SOURCE] do begin
                // "position_id":"21593335","vehicle":"PTE2"
                PayloadID := GetJSONString(Line, 'vehicle');

                // "gps_time":"2018-09-19 11:14:58",
                Temp := GetJSONString(Line, 'gps_time');

                TimeStamp := EncodeDateTime(StrToIntDef(Copy(Temp, 1, 4), 0),
                                            StrToIntDef(Copy(Temp, 6, 2), 0),
                                            StrToIntDef(Copy(Temp, 9, 2), 0),
                                            StrToIntDef(Copy(Temp, 12, 2), 0),
                                            StrToIntDef(Copy(Temp, 15, 2), 0),
                                            StrToIntDef(Copy(Temp, 18, 2), 0),
                                            0);

                // Ignore if old
                if TimeStamp > (Now - 120/86400) then begin
                    // "gps_lat":"51.95016","gps_lon":"-2.5446","gps_alt":"130"
                    Latitude := GetJSONFloat(Line, 'gps_lat');
                    Longitude := GetJSONFloat(Line, 'gps_lon');
                    Altitude := GetJSONFloat(Line, 'gps_alt');

                    // "data":{"landing_speed":"0.0","cda":"0.66","predicted_latitude":"0.0","temperature_internal":"40.1","ttl":0,"satellites":10,"predicted_longitude":"0.0"},"callsign":"M0RPI\/5","sequence":"50"},
                    // "predicted_latitude":"0.0","temperature_internal":"40.1","ttl":0,"satellites":10,"predicted_longitude":"0.0"},"callsign":"M0RPI\/5","sequence":"50"},
                    PredictedLatitude := GetJSONFloat(Line, 'predicted_latitude');
                    PredictedLongitude := GetJSONFloat(Line, 'predicted_longitude');
                    ContainsPrediction := (PredictedLatitude <> 0) or (PredictedLongitude <> 0);

                    ReceivedLine := ' ' + PayloadID + ': ' + FormatDateTime('hh:nn:ss', TimeStamp) + ',' + Latitude.ToString + ',' + Longitude.ToString + ',' + Altitude.ToString;

                    Updated := True;

                    Inc(Result);
                end;
            end;
        end;
    end;

    Strings.Free;
end;


procedure TfrmHabitat.httpPayloadError(Sender: TObject;
  ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
  var Handled: Boolean);
begin
    Handled := True;
end;

procedure TfrmHabitat.MiletusFormCreate(Sender: TObject);
begin
    inherited;
    SettingsPageIndex := 4;
end;

procedure TfrmHabitat.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmHabitat.PollServer;
var
    INIFile: TMiletusINIFile;
    Enabled: Boolean;
    PayloadList: String;
    Positions: Integer;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    Enabled := await(Boolean, INIFile.ReadBool('Download', 'HabitatEnabled', False));
    PayloadList := await(String, INIFile.ReadString('Download', 'WhiteList', ''));
    INIFile.Free;

    if Enabled then begin
        if PayloadList = '' then begin
            lblStatus.Caption := 'Enabled but no payload list';
        end else begin
            lblStatus.Caption := 'Polling for ' + PayloadList;

            httpPoll.URL := 'http://legacy-snus.habhub.org/tracker/datanew.php?mode=Position&type=positions&format=json&max_positions=10&vehicles=' + PayloadList;
            try
                lblPosition.Caption := 'Polling ...';
                httpPoll.Execute(
                    procedure(AResponse: string; AReq: TJSXMLHttpRequest)
                    begin
                        Positions := ProcessHabitatResponse(AResponse);

                        lblStatus.Caption := '';
                        lblPosition.Caption := FormatDateTime('hh:nn:ss', Now) + ': Downloaded ' + IntToStr(Positions) + ' positions';
                        // frmMain.ShowSourceStatus(HABHUB_SOURCE, True, True, True);
                    end);
                lblPosition.Caption := 'Poll Requested';
            except
                frmMain.ShowSourceStatus(HABHUB_SOURCE, True, True, False);
            end;
        end;
    end else begin
        lblStatus.Caption := 'Not enabled in settings';
        frmMain.ShowSourceStatus(HABHUB_SOURCE, False, False, False);
    end;
end;

procedure TfrmHabitat.UploadCarPosition(Callsign: String; Position: THABPosition);
var
    Password: String;
begin
    Password := 'aurora';

    httpCar.URL := 'http://legacy-snus.habhub.org/tracker/track.php' +
                   '?vehicle=' + Callsign + '_Chase' +
                    '&time=' + FormatDateTime('hhmmss', Position.TimeStamp) +
                    '&lat=' + FormatFloat('00.000000', Position.Latitude) +
                    '&lon=' + FormatFloat('00.000000', Position.Longitude) +
                    '&alt=' + FormatFloat('0', Position.Altitude) +
                    '&pass=' + Password;
    httpCar.Execute(
        procedure(AResponse: string; AReq: TJSXMLHttpRequest)
        begin
            frmMain.ShowTargetStatus(HABHUB_TARGET, True, True);
        end);
end;

procedure TfrmHabitat.UploadHABPosition(Callsign, Sentence: String);
begin
    httpPayload.URL := 'http://habitat.habhub.org/transition/payload_telemetry';

    httpPayload.PostData := 'callsign=' + Callsign + '&string_type=ascii&metadata={}&string=' + Sentence + #10;

    httpPayload.Headers.Clear;
    httpPayload.Headers.AddPair('Content-Type', 'application/x-www-form-urlencoded');

    lblStatus.Caption := 'Post ...';
    lblPosition.Caption := '<' + Sentence + '>';
    httpPayload.Execute;
end;


//Cache-Control=no-cache, no-store, must-revalidate

initialization
  RegisterClass(TfrmHabitat);

end.