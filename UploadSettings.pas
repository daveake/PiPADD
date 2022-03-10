unit UploadSettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.StdCtrls,
  WEBLib.StdCtrls, Vcl.Controls, WEBLib.ExtCtrls;

type
  TfrmUploadSettings = class(TfrmSettingsBase)
    btnHabitat: TWebButton;
    btnHabLink: TWebButton;
    btnSSDV: TWebButton;
    procedure MiletusFormResize(Sender: TObject);
    procedure btnSSDVClick(Sender: TObject);
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
  frmUploadSettings: TfrmUploadSettings;

implementation

{$R *.dfm}

procedure TfrmUploadSettings.btnSSDVClick(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmUploadSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmUploadSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteBool('Upload', 'HabitatEnabled', SettingsButtonToBoolean(btnHabitat));
        INIFile.WriteBool('Upload', 'HabLinkEnabled', SettingsButtonToBoolean(btnHabLink));
        INIFile.WriteBool('Upload', 'SSDVEnabled', SettingsButtonToBoolean(btnSSDV));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmUploadSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        SetSettingsButtonFromBoolean(btnHabitat, await(Boolean, INIFile.ReadBool('Upload', 'HabitatEnabled', False)));
        SetSettingsButtonFromBoolean(btnHabLink, await(Boolean, INIFile.ReadBool('Upload', 'HabLinkEnabled', False)));
        SetSettingsButtonFromBoolean(btnSSDV, await(Boolean, INIFile.ReadBool('Upload', 'SSDVEnabled', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;


initialization
  RegisterClass(TfrmUploadSettings);

end.