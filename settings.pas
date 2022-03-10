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
    procedure MiletusFormShow(Sender: TObject);
    procedure btnGPSClick(Sender: TObject);
    procedure btnLoRaHATClick(Sender: TObject);
    procedure btnInternetClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure tmrLoadTimer(Sender: TObject);
    procedure btnLoRaUSBClick(Sender: TObject);
  private
    { Private declarations }
    ActivePanel: TWebPanel;
    ShowPageIndex: Integer;
    ReadyToShow: Boolean;
    procedure ShowSelectedPage;
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
begin
    ShowForm(btnGeneral, pnlGeneral, frmGeneralSettings);
end;

procedure TfrmSettings.btnGPSClick(Sender: TObject);
begin
    ShowForm(btnGPS, pnlGPS, frmGPSSettings);
end;

procedure TfrmSettings.btnInternetClick(Sender: TObject);
begin
    ShowForm(btnInternet, pnlInternet, frmInternetSettings);
end;

procedure TfrmSettings.btnLoRaHATClick(Sender: TObject);
begin
    ShowForm(btnLoRaHAT, pnlLoRaHAT, frmLoRaHATSettings);
end;

procedure TfrmSettings.btnLoRaUSBClick(Sender: TObject);
begin
    ShowForm(btnLoRaUSB, pnlLoRaUSB, frmLoRaUSBSettings);
end;

procedure TfrmSettings.btnUploadClick(Sender: TObject);
begin
    ShowForm(btnUpload, pnlUpload, frmUploadSettings);
end;

procedure TfrmSettings.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmSettings.MiletusFormShow(Sender: TObject);
    procedure AfterUploadCreate(AForm: TObject);
    begin
        ReadyToShow := True;
    end;

    procedure AfterInternetCreate(AForm: TObject);
    begin
        frmUploadSettings := TfrmUploadSettings.CreateNew(pnlUpload.ElementID, @AfterUploadCreate);
    end;

    procedure AfterLoRaCreate(AForm: TObject);
    begin
        frmInternetSettings := TfrmInternetSettings.CreateNew(pnlInternet.ElementID, @AfterInternetCreate);
    end;

    procedure AfterLoRaHATCreate(AForm: TObject);
    begin
        frmLoRaUSBSettings := TfrmLoRaUSBSettings.CreateNew(pnlLoRaUSB.ElementID, @AfterLoRaCreate);
    end;

    procedure AfterGPSCreate(AForm: TObject);
    begin
        frmLoRaHATSettings := TfrmLoRaHATSettings.CreateNew(pnlLoRaHAT.ElementID, @AfterLoRaHATCreate);
    end;

    procedure AfterGeneralCreate(AForm: TObject);
    begin
        frmGPSSettings := TfrmGPSSettings.CreateNew(pnlGPS.ElementID, @AfterGPSCreate);
    end;

begin
    if frmGeneralSettings = nil then begin
        // Create sub=forms
        frmGeneralSettings := TfrmGeneralSettings.CreateNew(pnlGeneral.ElementID, @AfterGeneralCreate);
    end;
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


procedure TfrmSettings.tmrLoadTimer(Sender: TObject);
begin
    if ReadyToShow then begin
        tmrLoad.Enabled := False;
        ShowSelectedPage;
    end;
end;

procedure TfrmSettings.AfterShow;
begin
//    inherited;
//
//    if ReadyToShow then begin
//        btnGeneralClick(nil);
//    end else begin
//        tmrLoad.Enabled := True;
//    end;
end;

procedure TfrmSettings.ShowPage(PageIndex: Integer);
begin
    ShowPageIndex := PageIndex;

    if ReadyToShow then begin
        ShowSelectedPage;
    end else begin
        tmrLoad.Enabled := True;
    end;
end;

procedure TfrmSettings.ShowSelectedPage;
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