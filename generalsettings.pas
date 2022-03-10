unit generalsettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmGeneralSettings = class(TfrmSettingsBase)
    WebLabel1: TWebLabel;
    edtCallsign: TWebEdit;
    btnPositionBeeps: TWebButton;
    btnAlarmBeeps: TWebButton;
    btnSpeech: TWebButton;
    procedure MiletusFormResize(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure TextChanged(Sender: TObject);
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
  frmGeneralSettings: TfrmGeneralSettings;

implementation

{$R *.dfm}

procedure TfrmGeneralSettings.ButtonClick(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmGeneralSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmGeneralSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteString('General', 'Callsign', edtCallsign.Text);
        INIFile.WriteBool('General', 'PositionBeeps', SettingsButtonToBoolean(btnPositionBeeps));
        INIFile.WriteBool('General', 'AlarmBeeps', SettingsButtonToBoolean(btnAlarmBeeps));
        INIFile.WriteBool('General', 'Speech', SettingsButtonToBoolean(btnSpeech));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmGeneralSettings.TextChanged(Sender: TObject);
begin
    SettingsHaveChanged;
end;

procedure TfrmGeneralSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        edtCallsign.Text := await(String, INIFile.ReadString('General', 'Callsign', ''));
        SetSettingsButtonFromBoolean(btnPositionBeeps, await(Boolean, INIFile.ReadBool('General', 'PositionBeeps', False)));
        SetSettingsButtonFromBoolean(btnAlarmBeeps, await(Boolean, INIFile.ReadBool('General', 'AlarmBeeps', False)));
        SetSettingsButtonFromBoolean(btnSpeech, await(Boolean, INIFile.ReadBool('General', 'Speech', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;

initialization
  RegisterClass(TfrmGeneralSettings);

end.