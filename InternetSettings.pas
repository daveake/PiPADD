unit InternetSettings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, settingsbase, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmInternetSettings = class(TfrmSettingsBase)
    WebLabel1: TWebLabel;
    edtWhiteList: TWebEdit;
    btnHabitat: TWebButton;
    btnHabLink: TWebButton;
    procedure MiletusFormResize(Sender: TObject);
    procedure TextChanged(Sender: TObject);
    procedure buttonClicked(Sender: TObject);
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
  frmInternetSettings: TfrmInternetSettings;

implementation

{$R *.dfm}

procedure TfrmInternetSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmInternetSettings.SaveSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        INIFile.WriteString('Download', 'WhiteList', edtWhiteList.Text);
        INIFile.WriteBool('Download', 'HabitatEnabled', SettingsButtonToBoolean(btnHabitat));
        INIFile.WriteBool('Download', 'HablinkEnabled', SettingsButtonToBoolean(btnHabLink));
    finally
        INIFile.Free;
    end;

    inherited;
end;

procedure TfrmInternetSettings.TextChanged(Sender: TObject);
begin
    SettingsHaveChanged;
end;

procedure TfrmInternetSettings.buttonClicked(Sender: TObject);
begin
    ToggleButton(TWebButton(Sender));
end;

procedure TfrmInternetSettings.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        edtWhiteList.Text := await(String, INIFile.ReadString('Download', 'WhiteList', ''));
        SetSettingsButtonFromBoolean(btnHabitat, await(Boolean, INIFile.ReadBool('Download', 'HabitatEnabled', False)));
        SetSettingsButtonFromBoolean(btnHabLink, await(Boolean, INIFile.ReadBool('Download', 'HablinkEnabled', False)));
    finally
        INIFile.Free;
    end;

    inherited;
end;


initialization
  RegisterClass(TfrmInternetSettings);

end.