unit lora_serial;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, lora, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmLoRaSerial = class(TfrmLoRa)
  private
    { Private declarations }
  protected
    procedure ProcessLine(Channel: Integer; Line: String);
    procedure SendCommand(Command: String); virtual;
    procedure ProgramDevicesFromSettings; override;;
  public
    lblGPS: TWebLabel;
    { Public declarations }
    procedure SetFrequency(Channel: Integer; Frequency: Double); override;
    procedure SetMode(Channel, Mode: Integer); override;
    procedure MiletusFormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses Main, misc;

procedure TfrmLoRaSerial.SendCommand(Command: String);
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
begin
    try
        Command := GetString(Line, '=');

        if Command = 'GPS' then begin
            lblGPS.Caption := 'GPS: ' + Line;

            with HABPositions[GPS_SOURCE] do begin
                TimeStamp := GetTime(Line);
                Latitude := GetFloat(Line);
                Longitude := GetFloat(Line);
                Altitude := GetFloat(Line);
                Satellites := GetInteger(Line);
                Updated := True;
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

procedure TfrmLoRaSerial.SetFrequency(Channel: Integer; Frequency: Double);
begin
    SendCommand('~F' + FormatFloat('0.0000', Frequency) + #13);
end;

procedure TfrmLoRaSerial.SetMode(Channel, Mode: Integer);
begin
    SendCommand('~M' + IntToStr(Mode) + #13);
end;

procedure TfrmLoRaSerial.ProgramDevicesFromSettings;
begin
    ProgramDeviceFromSettings(0);
end;

initialization
  RegisterClass(TfrmLoRaSerial);

end.