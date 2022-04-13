unit settings;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, SettingsBase, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls, base;

type
  TfrmSettings = class(TfrmBase)
    pnlButtonTop: TWebPanel;
    btnLoRaHAT: TWebLabel;
    btnGeneral: TWebLabel;
    btnGPS: TWebLabel;
    btnInternet: TWebLabel;
    pnlGeneral: TWebPanel;
    pnlGPS: TWebPanel;
    pnlLoRaHAT: TWebPanel;
    pnlInternet: TWebPanel;
    btnUpload: TWebLabel;
    pnlUpload: TWebPanel;
    tmrLoad: TWebTimer;
    btnLoRaUSB: TWebLabel;
    pnlLoRaUSB: TWebPanel;
    procedure MiletusFormResize(Sender: TObject);
    procedure btnGeneralClick(Sender: TObject);
    procedure btnGPSClick(Sender: TObject);
    procedure btnLoRaHATClick(Sender: TObject);
    procedure btnInternetClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnLoRaUSBClick(Sender: TObject);
  private
    { Private declarations }
    ActivePanel: TWebPanel;
    ShowPageIndex: Integer;
    procedure ShowForm(Button: TWebLabel; NewPanel: TWebPanel; NewForm: TfrmSettingsBase);
  public
    { Public declarations }
    procedure AfterShow; override;
    procedure ShowPage(PageIndex: Integer);
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

uses GeneralSettings, GPSSettings, LoRaHATSettings, LoRaUSBSettings, InternetSettings, UploadSettings;

procedure TfrmSettings.btnGeneralClick(Sender: TObject);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        ShowForm(btnGeneral, pnlGeneral, frmGeneralSettings);
    end;
begin
    if frmGeneralSettings = nil then begin
        frmGeneralSettings := TfrmGeneralSettings.CreateNew(pnlGeneral.ElementID, @AfterSettingsCreate);
    end else begin
        ShowForm(btnGeneral, pnlGeneral, frmGeneralSettings);
    end;
end;

procedure TfrmSettings.btnGPSClick(Sender: TObject);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        ShowForm(btnGPS, pnlGPS, frmGPSSettings);
    end;
begin
    if frmGPSSettings = nil then begin
        frmGPSSettings := TfrmGPSSettings.CreateNew(pnlGPS.ElementID, @AfterSettingsCreate);
    end else begin
        ShowForm(btnGPS, pnlGPS, frmGPSSettings);
    end;
end;

procedure TfrmSettings.btnInternetClick(Sender: TObject);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        ShowForm(btnInternet, pnlInternet, frmInternetSettings);
    end;
begin
    if frmInternetSettings = nil then begin
        frmInternetSettings := TfrmInternetSettings.CreateNew(pnlInternet.ElementID, @AfterSettingsCreate);
    end else begin
        ShowForm(btnInternet, pnlInternet, frmInternetSettings);
    end;
end;

procedure TfrmSettings.btnLoRaHATClick(Sender: TObject);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        ShowForm(btnLoRaHAT, pnlLoRaHAT, frmLoRaHATSettings);
    end;
begin
    if frmLoRaHATSettings = nil then begin
        frmLoRaHATSettings := TfrmLoRaHATSettings.CreateNew(pnlLoRaHAT.ElementID, @AfterSettingsCreate);
    end else begin
        ShowForm(btnLoRaHAT, pnlLoRaHAT, frmLoRaHATSettings);
    end;
end;

procedure TfrmSettings.btnLoRaUSBClick(Sender: TObject);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        ShowForm(btnLoRaUSB, pnlLoRaUSB, frmLoRaUSBSettings);
    end;
begin
    if frmLoRaUSBSettings = nil then begin
        frmLoRaUSBSettings := TfrmLoRaUSBSettings.CreateNew(pnlLoRaUSB.ElementID, @AfterSettingsCreate);
    end else begin
        ShowForm(btnLoRaUSB, pnlLoRaUSB, frmLoRaUSBSettings);
    end;
end;

procedure TfrmSettings.btnUploadClick(Sender: TObject);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        ShowForm(btnUpload, pnlUpload, frmUploadSettings);
    end;
begin
    if frmUploadSettings = nil then begin
        frmUploadSettings := TfrmUploadSettings.CreateNew(pnlUpload.ElementID, @AfterSettingsCreate);
    end else begin
        ShowForm(btnUpload, pnlUpload, frmUploadSettings);
    end;
end;

procedure TfrmSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmSettings.ShowForm(Button: TWebLabel; NewPanel: TWebPanel; NewForm: TfrmSettingsBase);
begin
    btnLoRaHAT.Font.Style := [];
    btnLoRaUSB.Font.Style := [];
    btnGeneral.Font.Style := [];
    btnGPS.Font.Style := [];
    btnInternet.Font.Style := [];
    btnUpload.Font.Style := [];

    if Button <> nil then begin
        Button.Font.Style := [fsUnderline];
    end;

    if ActivePanel <> nil then begin
        ActivePanel.Visible := False;
        ActivePanel := nil;
    end;

    if NewPanel <> nil then begin
        NewPanel.Visible := True;
        ActivePanel := NewPanel;
    end;

    if NewForm <> nil then begin
        NewForm.Resize;
        NewForm.AfterShow;
    end;
end;


procedure TfrmSettings.AfterShow;
begin
end;

procedure TfrmSettings.ShowPage(PageIndex: Integer);
begin
    case ShowPageIndex of
        0:  btnGeneralClick(nil);
        1:  btnGPSClick(nil);
        2:  btnLoRaHATClick(nil);
        3:  btnLoRaUSBClick(nil);
        4:  btnInternetClick(nil);
        5:  btnUploadClick(nil);
    end;
end;

initialization
  RegisterClass(TfrmSettings);

end.