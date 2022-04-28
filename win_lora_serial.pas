unit win_lora_serial;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, lora_serial, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.USB, WEBLib.ExtCtrls;

type
  TfrmWinLoRaSerial = class(TfrmLoRaSerial)
    WebUSBSerial1: TWebUSBSerial;
    procedure lblStatusClick(Sender: TObject);
    procedure lblPositionClick(Sender: TObject);
    procedure WebUSBSerial1Connected(Sender: TObject; APort: TSerialPort);
    procedure WebUSBSerial1OpenPort(Sender: TObject; APort: TSerialPort);
    procedure WebUSBSerial1ReadData(Sender: TObject; AData: TJSUint8Array;
      ADone: Boolean);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OpenPort;
  protected
    procedure SendCommandNow(Command: String); override;
  public
    { Public declarations }
  end;

var
  frmWinLoRaSerial: TfrmWinLoRaSerial;

implementation

{$R *.dfm}

procedure TfrmWinLoRaSerial.lblPositionClick(Sender: TObject);
begin
    WebUSBSerial1.SelectedPort := WebUSBSerial1.Ports.Items[0];

    WebUSBSerial1.OpenPort;
end;

procedure TfrmWinLoRaSerial.lblStatusClick(Sender: TObject);
begin
    OpenPort;
end;

procedure TfrmWinLoRaSerial.MiletusFormCreate(Sender: TObject);
begin
    inherited;
    SettingsPageIndex := 3;
end;

procedure TfrmWinLoRaSerial.OpenPort;
begin
    if WebUSBSerial1.HasSerial then begin
        lblStatus.Caption := 'Requesting Port';
        WebUSBSerial1.RequestPorts;

        lblStatus.Caption := 'Initialising Port';
        WebUSBSerial1.InitPorts;
    end;
end;

procedure TfrmWinLoRaSerial.SendCommandNow(Command: String);
var
    Buffer: TJSUint8Array;
    i: Integer;
begin
    Buffer := TJSUint8Array.New(Length(Command));

    for i := 1 to Length(Command) do begin
        Buffer[i-1] := Ord(Command[i]);
    end;

    WebUSBSerial1.Write(Buffer);
end;


procedure TfrmWinLoRaSerial.WebUSBSerial1Connected(Sender: TObject;
  APort: TSerialPort);
begin
    lblStatus.Caption := 'Connected OK';
end;

procedure TfrmWinLoRaSerial.WebUSBSerial1OpenPort(Sender: TObject;
  APort: TSerialPort);
begin
    WebUSBSerial1.Read;
end;

procedure TfrmWinLoRaSerial.WebUSBSerial1ReadData(Sender: TObject;
  AData: TJSUint8Array; ADone: Boolean);
const
    Line: String = '';
var
    i: Integer;
begin
    for i := 1 to AData.length do begin
        if Adata.values[i-1] = 10 then begin
            ProcessLine(0, Line);
            Line := '';
        end else begin
            Line := Line + Chr(Adata.values[i-1]);
        end;
    end;

    WebUSBSerial1.Read;
end;

initialization
  RegisterClass(TfrmWinLoRaSerial);

end.