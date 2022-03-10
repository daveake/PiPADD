unit sources;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls;

type
  TfrmSources = class(TfrmBase)
    pnlLoRaHAT: TWebPanel;
    pnlGPS: TWebPanel;
    pnlHABLink: TWebPanel;
    tmrInit: TWebTimer;
    pnlLoRaSerial: TWebPanel;
    pnlHabitat: TWebPanel;
    procedure tmrInitTimer(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure AfterLoad; override;
    procedure AfterShow; override;
  public
    { Public declarations }
  end;

var
  frmSources: TfrmSources;

implementation

{$R *.dfm}

uses Main, gps, fake_gps, win_gps, pi_gps, lora, win_lora_serial, lora_hat, pi_lora_serial, hablink, habitat, splash;

procedure TfrmSources.AfterLoad;
    procedure AfterAllCreated(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := '';
        tmrInit.Enabled := True;
    end;

    procedure AfterLoRaUSBCreate(AForm: TObject);
    begin
        if frmMain.IsRaspberryPi then begin
            frmSplash.lblStatus.Caption := 'Loading sources: LoRa HAT ...';

            frmLoRaHAT := TfrmLoRaHAT.CreateNew(pnlLoRaHAT.ElementID, @AfterAllCreated);
        end else begin
            AfterAllCreated(nil);
        end;
    end;


    procedure AfterHabitatCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading sources: LoRa USB ...';
        if frmMain.IsRaspberryPi then begin
            frmPiLoRaSerial := TfrmPiLoRaSerial.CreateNew(pnlLoRaSerial.ElementID, @AfterLoRaUSBCreate);
        end else begin
            frmWinLoRaSerial := TfrmWinLoRaSerial.CreateNew(pnlLoRaSerial.ElementID, @AfterLoRaUSBCreate);
        end;
    end;

    procedure AfterHABLinkCreate(AForm: TObject);
    begin
        frmHabitat := TfrmHabitat.CreateNew(pnlHABitat.ElementID, @AfterHabitatCreate);
        frmSplash.lblStatus.Caption := 'Loading sources: Habitat ...';
    end;

    procedure AfterGPSCreate(AForm: TObject);
    begin
        frmHABLink := TfrmHABLink.CreateNew(pnlHABLink.ElementID, @AfterHABLinkCreate);
        frmSplash.lblStatus.Caption := 'Loading sources: HABLINK ...';
    end;
begin
    frmSplash.lblStatus.Caption := 'Loading sources: GPS ...';

    if frmMain.IsRaspberryPi then begin
//        frmGPS := TfrmFakeGPS.CreateNew(pnlGPS.ElementID, @AfterGPSCreate);
        frmGPS := TfrmPiGPS.CreateNew(pnlGPS.ElementID, @AfterGPSCreate);
    end else begin
        frmGPS := TfrmFakeGPS.CreateNew(pnlGPS.ElementID, @AfterGPSCreate);
    end;
end;

procedure TfrmSources.AfterShow;
begin
    if frmGPS <> nil then frmGPS.Resize;
    if frmHABLink <> nil then frmHABLink.Resize;
    if frmHabitat <> nil then frmHabitat.Resize;
    if frmLoRaHAT <> nil then frmLoRaHAT.Resize;
    if frmPiLoRaSerial <> nil then frmPiLoRaSerial.Resize;
    if frmWinLoRaSerial <> nil then frmWinLoRaSerial.Resize;
end;

procedure TfrmSources.MiletusFormCreate(Sender: TObject);
begin
//    inherited;
//
//    if not frmMain.IsRaspberryPi then begin
//        pnlLoRaHAT.Visible := False;
//    end;
end;

procedure TfrmSources.tmrInitTimer(Sender: TObject);
begin
    tmrInit.Enabled := False;

    if frmGPS <> nil then frmGPS.AfterLoad;

    if frmHABLink <> nil then frmHABLink.AfterLoad;
    if frmHabitat <> nil then frmHabitat.AfterLoad;

    if frmLoRaHAT <> nil then frmLoRaHAT.AfterLoad;
    if frmPiLoRaSerial <> nil then frmPiLoRaSerial.AfterLoad;
    if frmWinLoRaSerial <> nil then frmWinLoRaSerial.AfterLoad;
end;


initialization
  RegisterClass(TfrmSources);

end.