unit pi_lora_serial;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, lora_serial, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.MiletusRaspi, WEBLib.ExtCtrls;

type
  TfrmPiLoRaSerial = class(TfrmLoRaSerial)
    MiletusRaspberryUART1: TMiletusRaspberryUART;
    tmrPoll: TWebTimer;
    procedure MiletusRaspberryUART1Close(Sender: TObject);
    procedure MiletusRaspberryUART1Open(Sender: TObject);
    [async]
    procedure tmrPollTimer(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
    [async] procedure OpenPort;
  public
    { Public declarations }
    procedure AfterLoad; override;
  end;

var
  frmPiLoRaSerial: TfrmPiLoRaSerial;

implementation

{$R *.dfm}

procedure TfrmPiLoRaSerial.AfterLoad;
begin
    OpenPort;
end;

procedure TfrmPiLoRaSerial.OpenPort;
var
    INIFile: TMiletusINIFile;
    DeviceName: String;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        DeviceName := await(String, INIFile.ReadString('LoRaUSB', 'Device', ''));
    finally
        INIFile.Free;
    end;

    if DeviceName = '' then begin
        lblStatus.Caption := 'No device configured in settings';
    end else begin
        try
            lblStatus.Caption := 'Open port ' + DeviceName + ' ...';
            MiletusRaspberryUART1.PortNum := devUSB;
            MiletusRaspberryUART1.USBDevice := DeviceName;
            MiletusRaspberryUART1.Open;
        except
            lblStatus.Caption := 'Missing LoRa USB Device ' + MiletusRaspberryUART1.USBDevice;
        end;
    end;
end;


procedure TfrmPiLoRaSerial.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    SettingsPageIndex := 3;
end;

procedure TfrmPiLoRaSerial.MiletusRaspberryUART1Close(Sender: TObject);
begin
    lblStatus.Caption := 'Port ' + MiletusRaspberryUART1.USBDevice + ' is closed';
    tmrPoll.Enabled := False;
end;

procedure TfrmPiLoRaSerial.MiletusRaspberryUART1Open(Sender: TObject);
begin
    lblStatus.Caption := 'Port ' + MiletusRaspberryUART1.USBDevice + ' is open';

    tmrPoll.Enabled := True;
end;

procedure TfrmPiLoRaSerial.tmrPollTimer(Sender: TObject);
const
    Line: String = '';
var
    Buffer: TBytes;
    i, AvailLength, ReadLength: Integer;
begin
    tmrPoll.Enabled := False;

    (*
    while await(Boolean, MiletusRaspberryUART1.CanRead(1)) do begin
        AvailLength := await(Integer, MiletusRaspberryUART1.WaitingData);

        ReadLength := await(Integer, MiletusRaspberryUART1.ReadBuffer(Buffer, AvailLength));

        for i := 0 to ReadLength-1 do begin
            if Buffer[i] = 10 then begin
                ProcessLine(3, Line);
                Line := '';
            end else begin
                Line := Line + Chr(Buffer[i]);
            end;
        end;
    end;
    *)

    repeat
        AvailLength := await(Integer, MiletusRaspberryUART1.WaitingData);
        if AvailLength > 0 then begin
            ReadLength := await(Integer, MiletusRaspberryUART1.ReadBuffer(Buffer, AvailLength));

            for i := 0 to ReadLength-1 do begin
                if Buffer[i] = 10 then begin
                    ProcessLine(3, Line);
                    Line := '';
                end else begin
                    Line := Line + Chr(Buffer[i]);
                end;
            end;
        end;
    until AvailLength = 0;

    tmrPoll.Enabled := True;
end;

initialization
  RegisterClass(TfrmPiLoRaSerial);

end.