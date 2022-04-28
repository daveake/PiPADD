unit pi_gps;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, gps, WEBLib.MiletusRaspi,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls;

type
  TfrmPiGPS = class(TfrmGPS)
    MiletusRaspberryUART1: TMiletusRaspberryUART;
    tmrPoll: TWebTimer;
    tmrTimeout: TWebTimer;
    procedure MiletusRaspberryUART1Close(Sender: TObject);
    procedure MiletusRaspberryUART1Open(Sender: TObject);
    [async]
    procedure tmrPollTimer(Sender: TObject);
    procedure MiletusFormResize(Sender: TObject);
    procedure tmrTimeoutTimer(Sender: TObject);
  private
    { Private declarations }
    DeviceName: String;
    [async] procedure OpenPort;
  protected
    procedure SendCommand(Command: TBytes); override;
  public
    { Public declarations }
    procedure AfterLoad; override;
  end;

implementation

{$R *.dfm}

procedure TfrmPiGPS.AfterLoad;
begin
    OpenPort;
end;


procedure TfrmPiGPS.OpenPort;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        DeviceName := await(String, INIFile.ReadString('GPS', 'Device', ''));
    finally
        INIFile.Free;
    end;

    try
        if DeviceName = '' then begin
            // Use standard Pi serial port
            MiletusRaspberryUART1.PortNum := firstPL011;

            lblStatus.Caption := 'Open Standard Pi Serial Port ...';
        end else begin
            MiletusRaspberryUART1.PortNum := devUSB;
            MiletusRaspberryUART1.USBDevice := DeviceName;

            lblStatus.Caption := 'Open USB Serial Port ' + DeviceName + ' ...';
        end;

        MiletusRaspberryUART1.Open;
    except
        lblStatus.Caption := 'Missing GPS Device';
    end;
end;

procedure TfrmPiGPS.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmPiGPS.MiletusRaspberryUART1Close(Sender: TObject);
begin
    tmrPoll.Enabled := False;
end;

procedure TfrmPiGPS.MiletusRaspberryUART1Open(Sender: TObject);
begin
    if DeviceName = '' then begin
        lblStatus.Caption := 'Standard Pi Serial Port is open';
    end else begin
        lblStatus.Caption := 'USB Serial Port ' + DeviceName + ' is open';
    end;

    tmrPoll.Enabled := True;
    tmrTimeout.Enabled := True;
end;

procedure TfrmPiGPS.SendCommand(Command: TBytes);
begin
    MiletusRaspberryUART1.WriteBuffer(Command, Length(Command));
end;

procedure TfrmPiGPS.tmrPollTimer(Sender: TObject);
const
    Line: String = '';
var
    Buffer: TBytes;
    i, AvailLength, ReadLength: Integer;
begin
    tmrPoll.Enabled := False;

    AvailLength := await(Integer, MiletusRaspberryUART1.WaitingData);
    if AvailLength > 0 then begin
        ReadLength := await(Integer, MiletusRaspberryUART1.ReadBuffer(Buffer, AvailLength));

        for i := 0 to ReadLength-1 do begin
            if Buffer[i] = Ord('$') then begin
                Line := '$';
            end else if Buffer[i] = 10 then begin
                ProcessLine(Line);
                Line := '';
                tmrTimeout.Enabled := False;
            end else begin
                Line := Line + Chr(Buffer[i]);
            end;
        end;
    end;

    tmrPoll.Enabled := True;
end;

procedure TfrmPiGPS.tmrTimeoutTimer(Sender: TObject);
begin
    lblStatus.Caption := 'No data from GPS receiver';
    MiletusRaspberryUART1.Close;
end;

initialization
  RegisterClass(TfrmPiGPS);

end.