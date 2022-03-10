unit LoRaHATSettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls, Math;

type
  TfrmLoRaHATSettings = class(TfrmSettingsBase)
    WebLabel1: TWebLabel;
    edtFrequency0: TWebEdit;
    btnAFC0: TWebButton;
    btnLess0: TWebButton;
    btnMode0: TWebEdit;
    WebLabel3: TWebLabel;
    btnMore0: TWebButton;
    WebLabel2: TWebLabel;
    edtFrequency1: TWebEdit;
    btnAFC1: TWebButton;
    WebLabel4: TWebLabel;
    btnLess1: TWebButton;
    btnMode1: TWebEdit;
    btnMore1: TWebButton;
    btnSSDV: TWebButton;
    btnHabitat: TWebButton;
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
    procedure TextChanged(Sender: TObject);
    procedure ButtonClicked(Sender: TObject);
    procedure btnLess0Click(Sender: TObject);
    procedure btnLess1Click(Sender: TObject);
    procedure btnMore0Click(Sender: TObject);
    procedure btnMore1Click(Sender: TObject);
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
  frmLoRaHATSettings: TfrmLoRaHATSettings;

implementation

{$R *.dfm}

uses lora_hat;

procedure TfrmLoRaHATSettings.btnLess0Click(Sender: TObject);
begin
    btnMode0.Text := IntToStr(Max(0, StrToIntDef(btnMode0.Text, 1) - 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaHATSettings.btnLess1Click(Sender: TObject);
begin
    btnMode1.Text := IntToStr(Max(0, StrToIntDef(btnMode1.Text, 1) - 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaHATSettings.btnMore0Click(Sender: TObject);
begin
    btnMode0.Text := IntToStr(Min(7, StrToIntDef(btnMode0.Text, 0) + 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaHATSettings.btnMore1Click(Sender: TObject);
begin
    btnMode1.Text := IntToStr(Min(7, StrToIntDef(btnMode1.Text, 0) + 1));
    SettingsHaveChanged;
end;

procedure TfrmLoRaHATSettings.btnSaveClick(Sender: TObject);
begin
    inherited;

    if frmLoRaHAT <> nil then frmLoRaHAT.ProgramDevicesFromSettings;
end;

procedure TfrmLoRaHATSettings.ButtonClicked(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmLoRaHATSettings.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    //
end;

procedure TfrmLoRaHATSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmLoRaHATSettings.TextChanged(Sender: TObject);
begin
    SettingsHaveChanged;
end;

procedure TfrmLoRaHATSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteString('LoRaHAT', 'Frequency0', edtFrequency0.Text);
        INIFile.WriteString('LoRaHAT', 'Mode0', btnMode0.Text);
        INIFile.WriteBool('LoRaHAT', 'AFC0', SettingsButtonToBoolean(btnAFC0));

        INIFile.WriteString('LoRaHAT', 'Frequency1', edtFrequency1.Text);
        INIFile.WriteString('LoRaHAT', 'Mode1', btnMode1.Text);
        INIFile.WriteBool('LoRaHAT', 'AFC1', SettingsButtonToBoolean(btnAFC1));

        INIFile.WriteBool('LoRaHAT', 'Habitat', SettingsButtonToBoolean(btnHabitat));
        INIFile.WriteBool('LoRaHAT', 'SSDV', SettingsButtonToBoolean(btnSSDV));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmLoRaHATSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        edtFrequency0.Text := await(String, INIFile.ReadString('LoRaHAT', 'Frequency0', '434.250'));
        btnMode0.Text := await(String, INIFile.ReadString('LoRaHAT', 'Mode0', '1'));
        SetSettingsButtonFromBoolean(btnAFC0, await(Boolean, INIFile.ReadBool('LoRaHAT', 'AFC0', False)));

        edtFrequency1.Text := await(String, INIFile.ReadString('LoRaHAT', 'Frequency1', '434.450'));
        btnMode1.Text := await(String, INIFile.ReadString('LoRaHAT', 'Mode1', '1'));
        SetSettingsButtonFromBoolean(btnAFC1, await(Boolean, INIFile.ReadBool('LoRaHAT', 'AFC1', False)));

        SetSettingsButtonFromBoolean(btnHabitat, await(Boolean, INIFile.ReadBool('LoRaHAT', 'Habitat', False)));
        SetSettingsButtonFromBoolean(btnSSDV, await(Boolean, INIFile.ReadBool('LoRaHAT', 'SSDV', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;


initialization
  RegisterClass(TfrmLoRaHATSettings);

end.