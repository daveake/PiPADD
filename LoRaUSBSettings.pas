unit LoRaUSBSettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.StdCtrls,
  WEBLib.StdCtrls, Vcl.Controls, WEBLib.ExtCtrls, math;

type
  TfrmLoRaUSBSettings = class(TfrmSettingsBase)
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    edtFrequency: TWebEdit;
    btnAFC: TWebButton;
    WebLabel4: TWebLabel;
    btnLess: TWebButton;
    btnMore: TWebButton;
    btnMode: TWebEdit;
    btnSSDV: TWebButton;
    edtDevice: TWebEdit;
    btnUpload: TWebButton;
    procedure btnLessClick(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
    procedure btnMoreClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure edtDeviceChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  protected
    [async] procedure LoadSettings; override;
    procedure SaveSettings; override;
  public
    { Public declarations }
  end;

var
  frmLoRaUSBSettings: TfrmLoRaUSBSettings;

implementation

{$R *.dfm}

uses win_lora_serial, pi_lora_serial;

procedure TfrmLoRaUSBSettings.btnUploadClick(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmLoRaUSBSettings.btnLessClick(Sender: TObject);
begin
    btnMode.Text := IntToStr(Max(0, StrToIntDef(btnMode.Text, 1) - 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaUSBSettings.btnMoreClick(Sender: TObject);
begin
    btnMode.Text := IntToStr(Min(7, StrToIntDef(btnMode.Text, 0) + 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaUSBSettings.btnSaveClick(Sender: TObject);
begin
    inherited;

    if frmPiLoRaSerial <> nil then frmPiLoRaSerial.ProgramDevicesFromSettings;
    if frmWinLoRaSerial <> nil then frmWinLoRaSerial.ProgramDevicesFromSettings;
end;

procedure TfrmLoRaUSBSettings.edtDeviceChange(Sender: TObject);
begin
    SettingsHaveChanged;
end;

procedure TfrmLoRaUSBSettings.MiletusFormCreate(Sender: TObject);
begin
    //
end;

procedure TfrmLoRaUSBSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteString('LoRaUSB', 'Device', edtDevice.Text);

        INIFile.WriteString('LoRaUSB', 'Frequency', edtFrequency.Text);
        INIFile.WriteString('LoRaUSB', 'Mode', btnMode.Text);
        INIFile.WriteBool('LoRaUSB', 'AFC', SettingsButtonToBoolean(btnAFC));

        INIFile.WriteBool('LoRaUSB', 'Upload', SettingsButtonToBoolean(btnUpload));
        INIFile.WriteBool('LoRaUSB', 'SSDV', SettingsButtonToBoolean(btnSSDV));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmLoRaUSBSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        edtDevice.Text := await(String, INIFile.ReadString('LoRaUSB', 'Device', ''));

        edtFrequency.Text := await(String, INIFile.ReadString('LoRaUSB', 'Frequency', '434.250'));
        btnMode.Text := await(String, INIFile.ReadString('LoRaUSB', 'Mode', '1'));
        SetSettingsButtonFromBoolean(btnAFC, await(Boolean, INIFile.ReadBool('LoRaUSB', 'AFC', False)));

        SetSettingsButtonFromBoolean(btnUpload, await(Boolean, INIFile.ReadBool('LoRaUSB', 'Upload', False)));
        SetSettingsButtonFromBoolean(btnSSDV, await(Boolean, INIFile.ReadBool('LoRaUSB', 'SSDV', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;

initialization
  RegisterClass(TfrmLoRaUSBSettings);

end.