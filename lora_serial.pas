unit lora_serial;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, lora, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls;

type
  TfrmLoRaSerial = class(TfrmLoRa)
    tmrCommands: TWebTimer;
    procedure tmrCommandsTimer(Sender: TObject);
  private
    { Private declarations }
  protected
    Connected: Boolean;
    procedure ProcessLine(Channel: Integer; Line: String);
    procedure AppendCommand(Command: String);
    procedure SendCommandNow(Command: String); virtual;
    procedure ProgramDevicesFromSettings; override;
  public
    lblGPS: TWebLabel;
    lstCommands: TWebListBox;
    { Public declarations }
    procedure SetFrequency(Channel: Integer; Frequency: Double); override;
    procedure SetMode(Channel, Mode: Integer); override;
    procedure MiletusFormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses Main, misc;

procedure TfrmLoRaSerial.SendCommandNow(Command: String);
begin
    // virtual
end;

procedure TfrmLoRaSerial.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    SourceOffset := USB_SOURCE;

    SettingsPageIndex := 3;
end;

procedure TfrmLoRaSerial.ProcessLine(Channel: Integer; Line: String);
var
    Command: String;
    Position: THABPosition;
begin
    try
        Command := GetString(Line, '=');

        if Command = 'GPS' then begin
            lblGPS.Caption := 'GPS: ' + Line;

            with Position do begin
                TimeStamp := GetTime(Line);
                Latitude := GetFloat(Line);
                Longitude := GetFloat(Line);
                Altitude := GetFloat(Line);
                Satellites := GetInteger(Line);
                Updated := True;
            end;

            if (Position.Latitude <> 0) or (Position.Longitude <> 0) then begin
                HABPositions[GPS_SOURCE] := Position;
            end;
        end else if Command = 'CurrentRSSI' then begin
        end else if Command = 'FreqErr' then begin
        end else if Command = 'PacketRSSI' then begin
        end else if Command = 'PacketSNR' then begin
        end else if Command = 'Message' then begin
            ProcessTelemetry(Channel, Line);
        end;
    finally
        //
    end;
end;

procedure TfrmLoRaSerial.AppendCommand(Command: String);
begin
    lstCommands.Items.Add(Command);
end;

procedure TfrmLoRaSerial.SetFrequency(Channel: Integer; Frequency: Double);
begin
    AppendCommand('~F' + FormatFloat('0.0000', Frequency));

    lblStatus.Caption := 'USB: Set to ' + FormatFloat('0.000#', Frequency) + 'MHz';
end;


procedure TfrmLoRaSerial.SetMode(Channel, Mode: Integer);
begin
    AppendCommand('~M' + IntToStr(Mode));

    lblStatus.Caption := lblStatus.Caption + ' Mode ' + IntToStr(Mode);
end;

procedure TfrmLoRaSerial.tmrCommandsTimer(Sender: TObject);
begin
    if Connected then begin
        if lstCommands.Items.Count > 0 then begin
            SendCommandNow(lstCommands.Items[0] + #13 + #10);
            lstCommands.Items.Delete(0);
        end;
    end;
end;

procedure TfrmLoRaSerial.ProgramDevicesFromSettings;
begin
    ProgramDeviceFromSettings(0);
end;

initialization
  RegisterClass(TfrmLoRaSerial);

end.