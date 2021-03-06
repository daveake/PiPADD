unit misc;

interface

type TFlightMode = (fmIdle, fmLaunched, fmDescending, fmLanded);

type
    THABPosition = record
        Updated:            Boolean;
        PayloadID:          String;
        Counter:            Integer;
        TimeStamp:          TDateTime;
        Latitude:           Double;
        Longitude:          Double;
        Altitude:           Double;
        MaxAltitude:        Double;
        Satellites:         Integer;
        ContainsPrediction: Boolean;
        PredictedLatitude:  Double;
        PredictedLongitude: Double;
        AscentRate:         Double;
        FlightMode:         TFlightMode;
        ReceivedLine:       String;
        Sentence:           String;
        DirectionValid:     Boolean;
        Distance:           Double;
        Direction:          Double;
        Elevation:          Double;
        PredictionDistance: Double;
        PredictionDirection:Double;
        DescentTime:        Double;
    end;

const
    GPS_SOURCE      =   0;
    CE0_SOURCE      =   1;
    CE1_SOURCE      =   2;
    USB_SOURCE      =   3;
    HABLINK_SOURCE  =   4;
    HABHUB_SOURCE   =   5;

    HABHUB_TARGET   =   1;
    HABLINK_TARGET  =   2;
    SSDV_TARGET     =   3;

var
    HABPositions: Array[0..5] of THABPosition;

function GetString(var Line: String; Delimiter1: String=','; Delimiter2: String=''): String;
function GetInteger(var Line: String; Delimiter: String = ','): Integer;
function GetFloat(var Line: String; Delimiter1: String=','; Delimiter2: String=''): Double;
function GetTime(var Line: String; Delimiter: String = ','): TDateTime;
function FixPosition(Position: Double): Double;
function DecodePosition(SourceIndex: Integer; Line: String): THABPosition;
function CalculateHorizonRadius(Altitude, Elevation: Double): Double;
function CalculateDistance(HABLatitude, HabLongitude, CarLatitude, CarLongitude: Double): Double;
function CalculateDirection(HABLatitude, HabLongitude, CarLatitude, CarLongitude: Double): Double;
function CalculateElevation(lat1, lon1, alt1, lat2, lon2, alt2: Double): Double;
function GetTimeTaken(Calculate: Boolean = True): String;
//function InsertDate(TimeStamp: TDateTime): TDateTime;
function CalculateDescentTime(Altitude, DescentRate, Land: Double): Double;

implementation

uses System.SysUtils, DateUtils, Math;

function GetTimeTaken(Calculate: Boolean = True): String;
const
    StartTime: TDateTime = 0;
    MaxTimeTaken: TDateTime = 0;
    Counter: Integer = 0;
var
    TimeTaken: TDateTime;
begin
    if Calculate then begin
        TimeTaken := Now - StartTime;
        if Counter > 0 then begin
            Dec(Counter);
        end else begin
            if TimeTaken > MaxTimeTaken then begin
                MaxTimeTaken := TimeTaken;
            end;
        end;

        Result := FormatDateTime('ss.zzz', TimeTaken) + ' (max ' + FormatDateTime('ss.zzz', MaxTimeTaken) + ')';
    end;

    StartTime := Now;
end;

function GetString(var Line: String; Delimiter1: String=','; Delimiter2: String=''): String;
var
    Position: Integer;
    Delimiter: String;
begin
    Delimiter := Delimiter1;
    Position := Pos(Delimiter, string(Line));

    if (Position = 0) and (Delimiter2 <> '') then begin
        Delimiter := Delimiter2;
        Position := Pos(Delimiter, string(Line));
    end;

    if Position > 0 then begin
        Result := Copy(Line, 1, Position-1);
        Line := Copy(Line, Position+Length(Delimiter), Length(Line));
    end else begin
        Result := Line;
        Line := '';
    end;
end;

function GetInteger(var Line: String; Delimiter: String = ','): Integer;
var
    Temp: String;
begin
    Temp := GetString(Line, Delimiter);

    Result := StrToIntDef(Temp, 0);
end;

function GetFloat(var Line: String; Delimiter1: String=','; Delimiter2: String=''): Double;
var
    Temp: String;
begin
    Temp := GetString(Line, Delimiter1, Delimiter2);

    try
        Result := StrToFloat(Temp);
    except
        Result := 0.0;
    end;
end;

function GetTime(var Line: String; Delimiter: String = ','): TDateTime;
var
    Temp: String;
begin
    Temp := GetString(Line, Delimiter);

    try
        if Pos(':', Temp) > 0 then begin
            Result := EncodeTime(StrToIntDef(Copy(Temp, 1, 2), 0),
                      StrToIntDef(Copy(Temp, 4, 2), 0),
                      StrToIntDef(Copy(Temp, 7, 2), 0),
                      0);
        end else begin
            Result := EncodeTime(StrToIntDef(Copy(Temp, 1, 2), 0),
                      StrToIntDef(Copy(Temp, 3, 2), 0),
                      StrToIntDef(Copy(Temp, 5, 2), 0),
                      0);
        end;
    except
        Result := 0;
    end;
end;

function FixPosition(Position: Double): Double;
var
    Minutes, Seconds: Double;
begin
	Position := Position / 100;

	Minutes := Trunc(Position);
	Seconds := Frac(Position);

	Result := Minutes + Seconds * 5 / 3;
end;

function RemoveDollars(Line: String): String;
var
    i: Integer;
begin
    for i := 1 to Length(Line) do begin
        if Line[i] <> '$' then begin
            Result := Copy(Line, i, Length(Line));
            Exit;
        end;
    end;

    Result := '';
end;

//function InsertDate(TimeStamp: TDateTime): TDateTime;
//begin
//    if TimeStamp < 1 then begin
//        // Add today's date
//        TimeStamp := TimeStamp + Trunc(TTimeZone.Local.ToUniversalTime(Now));
//
//        if (TimeStamp > 0.99) and (Frac(TTimeZone.Local.ToUniversalTime(Now)) < 0.01) then begin
//            // Just past midnight, but payload transmitted just before midnight, so use yesterday's date
//            TimeStamp := TimeStamp - 1;
//        end;
//    end;
//
//    Result := TimeStamp;
//end;

function DecodePosition(SourceIndex: Integer; Line: String): THABPosition;
var
    Value1, Value2: Double;
begin
    with HABPositions[SourceIndex] do begin
        Result.Sentence := Line;
        Line := RemoveDollars(Line);
        PayloadID := GetString(Line, ',');
        Counter := GetInteger(Line, ',');
        TimeStamp := GetTime(Line, ',');
        Latitude := GetFloat(Line, ',');
        Longitude := GetFloat(Line, ',');
        Altitude := GetFloat(Line, ',');
        Satellites := GetInteger(Line, ',');
        Updated := True;

        // Look for prediction
        if (Latitude <> 0) and (Longitude <> 0) then begin
            Value2 := 0;
            while Line <> '' do begin
                Value1 := Value2;
                Value2 := GetFloat(Line, ',', '*');

                if (abs(Value1 - Latitude) < 1) and (abs(Value2 - Longitude) < 1) then begin
                    PredictedLatitude := Value1;
                    PredictedLongitude := Value2;
                    ContainsPrediction := True;
                end;
            end;

        end;

    end;
end;

function CalculateHorizonRadius(Altitude, Elevation: Double): Double;
const
    Radius: Double = 6378.10;        // radius of earth
var
    Angle, Slant: Double;
begin
    // Altitude in metres
    // Elevation in degrees
    // Result in km

    if Elevation > 0 then begin
        Altitude := Altitude / 1000.0;      // km
        Angle := DegToRad(Elevation);

        Slant := Radius * (cos(Pi/2 + Angle) + sqrt(power(cos(Pi/2 + Angle),2) + Altitude * (2 * Radius + Altitude) / power(Radius,2)));

        Result := arccos((power(Radius,2) + power(Radius+Altitude,2) - power(Slant,2)) / (2 * Radius * (Radius + Altitude))) * Radius;
    end else begin
        Result := sqrt(12.756 * Altitude);
    end;
end;

function CalculateDistance(HABLatitude, HABLongitude, CarLatitude, CarLongitude: Double): Double;
begin
    // Return distance in metres

    HABLatitude := HABLatitude * Pi / 180;
    HABLongitude := HABLongitude * Pi / 180;
    CarLatitude := CarLatitude * Pi / 180;
    CarLongitude := CarLongitude * Pi / 180;

    try
        Result := 6371000 * arccos(sin(CarLatitude) * sin(HABLatitude) +
                                   cos(CarLatitude) * cos(HABLatitude) * cos(HABLongitude-CarLongitude));
    except
        Result := 0.0;
    end;
end;

function CalculateDirection(HABLatitude, HabLongitude, CarLatitude, CarLongitude: Double): Double;
var
    x, y: Double;
begin
    HABLatitude := HABLatitude * Pi / 180;
    HabLongitude := HABLongitude * Pi / 180;
    CarLatitude := CarLatitude * Pi / 180;
    CarLongitude := CarLongitude * Pi / 180;

    y := sin(HABLongitude - CarLongitude) * cos(HABLatitude);
    x := cos(CarLatitude) * sin(HABLatitude) - sin(CarLatitude) * cos(HABLatitude) * cos(HABLongitude - CarLongitude);

    try
        Result := ArcTan2(y, x);
    except
        Result := 0.0;
    end;
end;

function CalculateElevation(lat1, lon1, alt1, lat2, lon2, alt2: Double): Double;
const
    Radius: Double = 6371000.0;
var
    d_lon, aa, ab, ea, eb, sa, sb, ta, tb, angle_at_centre: Double;
begin
    lat1 := DegToRad(lat1);
    lat2 := DegToRad(lat2);
    lon1 := DegToRad(lon1);
    lon2 := DegToRad(lon2);

    d_lon := lon2 - lon1;

    sa := cos(lat2) * sin(d_lon);
    sb := (cos(lat1) * sin(lat2)) - (sin(lat1) * cos(lat2) * cos(d_lon));

    aa := sqrt((sqr(sa)) + (sqr(sb)));
    ab := (sin(lat1) * sin(lat2)) + (cos(lat1) * cos(lat2) * cos(d_lon));

    angle_at_centre := arctan2(aa, ab);

    ta := radius + alt1;
    tb := radius + alt2;

    ea := (cos(angle_at_centre) * tb) - ta;
    eb := sin(angle_at_centre) * tb;

    Result := RadToDeg(arctan2(ea, eb));
end;

function CalculateAirDensity(alt: Double): Double;
var
    Temperature, Pressure: Double;
begin
    if alt < 11000.0 then begin
        // below 11Km - Troposphere
        Temperature := 15.04 - (0.00649 * alt);
        Pressure := 101.29 * power((Temperature + 273.1) / 288.08, 5.256);
    end else if alt < 25000.0 then begin
        // between 11Km and 25Km - lower Stratosphere
        Temperature := -56.46;
        Pressure := 22.65 * exp(1.73 - ( 0.000157 * alt));
    end else begin
        // above 25Km - upper Stratosphere
        Temperature := -131.21 + (0.00299 * alt);
        Pressure := 2.488 * power((Temperature + 273.1) / 216.6, -11.388);
    end;

    Result := Pressure / (0.2869 * (Temperature + 273.1));
end;

function CalculateDescentRate(Weight, Density, CDTimesArea: Double): Double;
begin
    Result := sqrt((Weight * 9.81)/(0.5 * Density * CDTimesArea));
end;

function CalculateCDA(Weight, Altitude, DescentRate: Double): Double;
var
	Density: Double;
begin
	Density := CalculateAirDensity(Altitude);

    Result := (Weight * 9.81)/(0.5 * Density * DescentRate * DescentRate);
end;

function CalculateDescentTime(Altitude, DescentRate, Land: Double): Double;
var
    Density, CDTimesArea, TimeAtAltitude, TotalTime, Step: Double;
begin
    Step := 100;

    CDTimesArea := CalculateCDA(1.0, Altitude, DescentRate);

    TotalTime := 0;

    while Altitude > Land do begin
        Density := CalculateAirDensity(Altitude);

        DescentRate := CalculateDescentRate(1.0, Density, CDTimesArea);

        TimeAtAltitude := Step / DescentRate;
        TotalTime := TotalTime + TimeAtAltitude;

        Altitude := Altitude - Step;
    end;

    Result := TotalTime;
end;

end.
