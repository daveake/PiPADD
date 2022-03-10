unit LoRaSettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls, Math;

type
  TfrmLoRaSettings = class(TfrmSettingsBase)
    WebLabel1: TWebLabel;
    edtDevice: TWebEdit;
    btnAFC: TWebButton;
    WebLabel4: TWebLabel;
    btnLess: TWebButton;
    btnMode: TWebEdit;
    btnMore: TWebButton;
    btnSSDV: TWebButton;
    btnHabitat: TWebButton;
    edtFrequency: TWebEdit;
    WebLabel2: TWebLabel;
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
    procedure TextChanged(Sender: TObject);
    procedure ButtonClicked(Sender: TObject);
    procedure btnLessClick(Sender: TObject);
    procedure btnMoreClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  protected
    [async]
    procedure LoadSettings; override;
    procedure SaveSettings; override;
  public
    { Public declarations }
  end;

var
  frmLoRaSettings: TfrmLoRaSettings;

implementation

{$R *.dfm}

uses win_lora_serial, lora_hat, pi_lora_serial;

procedure TfrmLoRaSettings.btnLessClick(Sender: TObject);
begin
    btnMode.Text := IntToStr(Max(0, StrToIntDef(btnMode.Text, 1) - 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaSettings.btnMoreClick(Sender: TObject);
begin
    btnMode.Text := IntToStr(Min(7, StrToIntDef(btnMode.Text, 0) + 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaSettings.btnSaveClick(Sender: TObject);
begin
    inherited;

    if frmPiLoRaSerial <> nil then frmPiLoRaSerial.ProgramDevicesFromSettings;
    if frmWinLoRaSerial <> nil then frmWinLoRaSerial.ProgramDevicesFromSettings;
end;

procedure TfrmLoRaSettings.ButtonClicked(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmLoRaSettings.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    //
end;

procedure TfrmLoRaSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmLoRaSettings.TextChanged(Sender: TObject);
begin
    SettingsHaveChanged;
end;

procedure TfrmLoRaSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteString('LoRaUSB', 'Device', edtDevice.Text);

        INIFile.WriteString('LoRaUSB', 'Frequency', edtFrequency.Text);
        INIFile.WriteString('LoRaUSB', 'Mode', btnMode.Text);
        INIFile.WriteBool('LoRaUSB', 'AFC', SettingsButtonToBoolean(btnAFC));

        INIFile.WriteBool('LoRaUSB', 'Habitat', SettingsButtonToBoolean(btnHabitat));
        INIFile.WriteBool('LoRaUSB', 'SSDV', SettingsButtonToBoolean(btnSSDV));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmLoRaSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        edtDevice.Text := await(String, INIFile.ReadString('LoRaUSB', 'Device', '434.250'));

        edtFrequency.Text := await(String, INIFile.ReadString('LoRaUSB', 'Frequency', '434.250'));
        btnMode.Text := await(String, INIFile.ReadString('LoRaUSB', 'Mode', '1'));
        SetSettingsButtonFromBoolean(btnAFC, await(Boolean, INIFile.ReadBool('LoRaUSB', 'AFC', False)));

        SetSettingsButtonFromBoolean(btnHabitat, await(Boolean, INIFile.ReadBool('LoRaUSB', 'Habitat', False)));
        SetSettingsButtonFromBoolean(btnSSDV, await(Boolean, INIFile.ReadBool('LoRaUSB', 'SSDV', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;


initialization
  RegisterClass(TfrmLoRaSettings);

end.