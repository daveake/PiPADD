unit gpssettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmGPSSettings = class(TfrmSettingsBase)
    WebLabel1: TWebLabel;
    edtCallsign: TWebEdit;
    btnUpload: TWebButton;
    WebLabel2: TWebLabel;
    edtPeriod: TWebEdit;
    WebLabel3: TWebLabel;
    edtDevice: TWebEdit;
    procedure TextChanged(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
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
  frmGPSSettings: TfrmGPSSettings;

implementation

{$R *.dfm}

procedure TfrmGPSSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteString('GPS', 'Device', edtDevice.Text);
        INIFile.WriteString('Chase', 'Callsign', edtCallsign.Text);
        INIFile.WriteString('Chase', 'Period', edtPeriod.Text);
        INIFile.WriteBool('Chase', 'Enabled', SettingsButtonToBoolean(btnUpload));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmGPSSettings.TextChanged(Sender: TObject);
begin
    SettingsHaveChanged;
end;

procedure TfrmGPSSettings.ButtonClick(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmGPSSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        edtDevice.Text := await(String, INIFile.ReadString('GPS', 'Device', ''));
        edtCallsign.Text := await(String, INIFile.ReadString('Chase', 'Callsign', ''));
        edtPeriod.Text := await(String, INIFile.ReadString('Chase', 'Period', ''));
        SetSettingsButtonFromBoolean(btnUpload, await(Boolean, INIFile.ReadBool('Chase', 'Enabled', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;

initialization
  RegisterClass(TfrmGPSSettings);

end.