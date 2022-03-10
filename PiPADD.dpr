program PiPADD;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  Main in 'Main.pas' {frmMain: TMiletusForm} {*.html},
  base in 'base.pas' {frmBase: TMiletusForm} {*.html},
  target in 'target.pas' {frmTarget: TMiletusForm} {*.html},
  payloads in 'payloads.pas' {frmPayloads: TMiletusForm} {*.html},
  source in 'source.pas' {frmSource: TMiletusForm} {*.html},
  gps in 'gps.pas' {frmGPS: TMiletusForm} {*.html},
  win_gps in 'win_gps.pas' {frmWinGPS: TMiletusForm} {*.html},
  pi_gps in 'pi_gps.pas' {frmPiGPS: TMiletusForm} {*.html},
  lora in 'lora.pas' {frmLoRa: TMiletusForm} {*.html},
  lora_hat in 'lora_hat.pas' {frmLoRaHAT: TMiletusForm} {*.html},
  lora_serial in 'lora_serial.pas' {frmLoRaSerial: TMiletusForm} {*.html},
  win_lora_serial in 'win_lora_serial.pas' {frmWinLoRaSerial: TMiletusForm} {*.html},
  pi_lora_serial in 'pi_lora_serial.pas' {frmPiLoRaSerial: TMiletusForm} {*.html},
  sources in 'sources.pas' {frmSources: TMiletusForm} {*.html},
  misc in 'misc.pas',
  map in 'map.pas' {frmMap: TMiletusForm} {*.html},
  direction in 'direction.pas' {frmDirection: TMiletusForm} {*.html},
  ssdv in 'ssdv.pas' {frmSSDV: TMiletusForm} {*.html},
  uplink in 'uplink.pas' {frmUplink: TMiletusForm} {*.html},
  settings in 'settings.pas' {frmSettings: TMiletusForm} {*.html},
  splash in 'splash.pas' {frmSplash: TMiletusForm} {*.html},
  hablink in 'hablink.pas' {frmHABLink: TMiletusForm} {*.html},
  fake_gps in 'fake_gps.pas' {frmFakeGPS: TMiletusForm} {*.html},
  settingsbase in 'settingsbase.pas' {frmSettingsBase: TMiletusForm} {*.html},
  generalsettings in 'generalsettings.pas' {frmGeneralSettings: TMiletusForm} {*.html},
  gpssettings in 'gpssettings.pas' {frmGPSSettings: TMiletusForm} {*.html},
  LoRaHATSettings in 'LoRaHATSettings.pas' {frmLoRaHATSettings: TMiletusForm} {*.html},
  InternetSettings in 'InternetSettings.pas' {frmInternetSettings: TMiletusForm} {*.html},
  log in 'log.pas' {frmLog: TMiletusForm} {*.html},
  UploadSettings in 'UploadSettings.pas' {frmUploadSettings: TMiletusForm} {*.html},
  habitat in 'habitat.pas' {frmHabitat: TMiletusForm} {*.html},
  LoRaUSBSettings in 'LoRaUSBSettings.pas' {frmLoRaUSBSettings: TMiletusForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.AutoFormRoute := True;
  Application.MainFormOnTaskbar := True;
  if not Application.NeedsFormRouting then
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
