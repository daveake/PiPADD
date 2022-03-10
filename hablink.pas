unit hablink;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, source, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.WebSocketClient, WEBLib.ExtCtrls,
  Misc;

type
  TfrmHABLink = class(TfrmSource)
    WebSocketClient1: TWebSocketClient;
    tmrCheckConnection: TWebTimer;
    procedure MiletusFormResize(Sender: TObject);
    procedure WebSocketClient1Disconnect(Sender: TObject);
    procedure WebSocketClient1DataReceived(Sender: TObject; Origin: string;
      SocketData: TJSObjectRecord);
    [async]
    procedure WebSocketClient1Connect(Sender: TObject);
    [async]
    procedure tmrCheckConnectionTimer(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
    DownloadEnabled, UploadEnabled, ConnectingToServer, ConnectedToServer: Boolean;
    procedure ProcessHABPosition(Parameters: String);
    procedure ProcessLine(Line: String);
    [async]
    procedure ConnectToServer;
  public
    { Public declarations }
    procedure SendGPSPosition(Callsign: String; Position: THABPosition);
    procedure SendPayloadPosition(Sentence: String);
    procedure AfterLoad; override;
  end;

var
  frmHABLink: TfrmHABLink;

implementation

{$R *.dfm}

uses Main;

function GetCommand(Line: String; var Parameters: String): String;
var
    Position: Integer;
begin
    Position := Pos(':', Line);
    if Position > 0 then begin
        Result := Copy(Line, 1, Position-1);
        Parameters := Copy(Line, Position, Length(Line));
    end else begin
        Result := Line;
        Parameters := '';
    end;
end;

function GetParameter(Line, ParameterName: String): String;
var
    Position: Integer;
begin
    Position := Pos(',' + ParameterName + '=', Line);
    if Position = 0 then begin
        Position := Pos(':' + ParameterName + '=', Line);
    end;

    if Position > 0 then begin
        Line := Copy(Line, Position + Length(ParameterName) + 2, 999);
        Position := Pos(',', Line);
        if Position > 0 then begin
            Result := Copy(Line, 1, Position-1);
        end else begin
            Result := Line;
        end;
    end else begin
        Result := '';
    end;
end;

function GetRestOfLine(Line, ParameterName: String): String;
var
    Position: Integer;
begin
    Position := Pos(',' + ParameterName + '=', Line);
    if Position = 0 then begin
        Position := Pos(':' + ParameterName + '=', Line);
    end;

    if Position > 0 then begin
        Result := Copy(Line, Position + Length(ParameterName) + 2, 999);
    end else begin
        Result := '';
    end;
end;

procedure TfrmHABLink.MiletusFormCreate(Sender: TObject);
begin
    inherited;
    SettingsPageIndex := 4;
end;

procedure TfrmHABLink.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmHABLink.tmrCheckConnectionTimer(Sender: TObject);
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');

    DownloadEnabled := await(Boolean, INIFile.ReadBool('Download', 'HablinkEnabled', False));
    UploadEnabled := await(Boolean, INIFile.ReadBool('Upload', 'HablinkEnabled', False));

    INIFile.Free;

    if DownloadEnabled or UploadEnabled then begin
        if (not ConnectingToServer) and (not ConnectedToServer) then begin
            ConnectToServer;
        end;
    end else begin
        if ConnectedToServer then begin
            ConnectedToServer := False;
            WebSocketClient1.Disconnect;
        end;

        lblStatus.Caption := 'Not enabled in settings';
    end;

    frmMain.ShowTargetStatus(HABLINK_SOURCE, UploadEnabled, ConnectedToServer);
end;

procedure TfrmHABLink.ConnectToServer;
begin
    lblStatus.Caption := 'Connecting ...';

    WebSocketClient1.HostName := 'hab.link';
    WebSocketClient1.Port := 8888;

    ConnectingToServer := True;

    WebSocketClient1.Connect;
end;

procedure TfrmHABLink.AfterLoad;
begin
    ConnectToServer;
end;

procedure TfrmHABLink.WebSocketClient1Connect(Sender: TObject);
var
    PayloadList: String;
    INIFile: TMiletusINIFile;
begin
    ConnectedToServer := True;
    ConnectingToServer := False;

    frmMain.ShowSourceStatus(HABLINK_SOURCE, DownloadEnabled, True, False);

    frmMain.ShowTargetStatus(HABLINK_TARGET, UploadEnabled, ConnectedToServer);

    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    PayloadList := await(String, INIFile.ReadString('Download', 'WhiteList', ''));
    INIFile.Free;

    lblStatus.Caption := 'Connected: Listening for ' + PayloadList;

    WebSocketClient1.Send('PAYLOADS:' + PayloadList);
end;

procedure TfrmHABLink.WebSocketClient1DataReceived(Sender: TObject;
  Origin: string; SocketData: TJSObjectRecord);
var
    s: String;
begin
    s := SocketData.jsobject.toString;

    ProcessLine(s);
end;

procedure TfrmHABLink.WebSocketClient1Disconnect(Sender: TObject);
begin
    ConnectedToServer := False;
    ConnectingToServer := False;

    lblStatus.Caption := 'Disconnected';

    frmMain.ShowSourceStatus(HABLINK_SOURCE, DownloadEnabled, False, False);

    frmMain.ShowTargetStatus(HABLINK_TARGET, UploadEnabled, ConnectedToServer);
end;

procedure TfrmHABLink.ProcessLine(Line: String);
const
    SSDVList: String = '';
var
    Command, Parameters: String;
begin
    if DownloadEnabled then begin
        Command := GetCommand(Line, Parameters);

        if Command = 'PAYLOAD' then begin
            ProcessHABPosition(Parameters);
    //    end else if Command = 'CHASE' then begin
    //        ProcessChasePosition(Parameters);
    //    end else if Command = 'WEATHER' then begin
    //        ProcessWeather(Parameters);
    //    end else if Command = 'LOG' then begin
    //        lblLog.Caption := Copy(Parameters,2,999);
    //        frmLog.AddToLog(Copy(Parameters,2,999));
    //    end else if Command = 'FLIGHTINFO' then begin
    //        ProcessFlightInfo(Parameters);
    //    end else if Command = 'FLIGHTS' then begin
    //        frmFlight.ShowFlightList(Copy(Parameters,2,999));
        end;
    end;
end;

procedure TfrmHABLink.ProcessHABPosition(Parameters: String);
const
    ColourTexts: Array[0..3] of String = ('blue', 'red', 'green', 'yellow');
    FirstTime: Boolean = True;
var
    TimeStamp: String;
    UTC: TDateTime;
    Start: Integer;
    Position: THABPosition;
begin
    Position := default(Position);
    Position.PayloadID := GetParameter(Parameters, 'ID');
    Position.TimeStamp := StrToTime(GetParameter(Parameters, 'TIME'));
    Position.Counter := StrToIntDef(GetParameter(Parameters, 'COUNT'), 0);
    Position.Latitude := StrToFloat(GetParameter(Parameters, 'LAT'));
    Position.Longitude := StrToFloat(GetParameter(Parameters, 'LON'));
    Position.Altitude := StrToFloat(GetParameter(Parameters, 'ALT'));
    Position.Satellites := StrToIntDef(GetParameter(Parameters, 'SATS'), 0);

    // Landing prediction ?
    if GetParameter(Parameters, 'PRED_LAT') > '' then begin
        Position.ContainsPrediction := True;
        Position.PredictedLatitude := StrToFloat(GetParameter(Parameters, 'PRED_LAT'));
        Position.PredictedLongitude := StrToFloat(GetParameter(Parameters, 'PRED_LON'));
    end else begin
        Position.ContainsPrediction := False;
    end;

    Position.Line := GetRestOfLine(Parameters, 'SENTENCE');
    lblPosition.Caption := Position.Line;

    frmMain.NewPosition(HABLINK_SOURCE, Position);
end;

procedure TfrmHABLink.SendGPSPosition(Callsign: String; Position: THABPosition);
begin
    if ConnectedToServer then begin
        WebSocketClient1.Send('CHASE:POSITION=' + Callsign + '_Chase,' +
                              FormatDateTime('hh:nn:ss', Position.TimeStamp) + ',' +
                              Format('%2.5f', [Position.Latitude]) + ',' +
                              Format('%2.5f', [Position.Longitude]) + ', ' +
                              Format('%.0f', [Position.Altitude]));
    end;
end;

procedure TfrmHABLink.SendPayloadPosition(Sentence: String);
begin
    if ConnectedToServer then begin
        WebSocketClient1.Send('POSITION:SENTENCE=' + Sentence);
    end;
end;

initialization
  RegisterClass(TfrmHABLink);

end.