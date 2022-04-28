unit main;

interface

uses
    System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
    WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls,
    WEBLib.StdCtrls, WEBLib.ExtCtrls, Math, Base, misc, WEBLib.REST,
    WEBLib.WebCtrls, Vcl.Imaging.GIFImg;

type
    THABSource = record
        LastReceivedAt: TDateTime;
        SourceLabel: TWebLabel;
    end;

type
    TPayload = record
        HasPosition: Boolean;
        Previous: THABPosition;
        Position: THABPosition;
        Button: TWebLabel;
        Colour: TColor;
        ColourName: String;
        GoodPosition: Boolean;
        LoggedLoss: Boolean;
        LastReceivedAt: TDateTime;
        UpdateScreen: Boolean;
        UploadPosition: Boolean;
        LastUploadAt: TDateTime;
        SourceID: Integer;
        // SourceMask:       Integer;
        // SSDVCount:        Integer;
        // PredictionIndex:  Integer;
    end;

type
    TfrmMain = class(TMiletusForm)
        pnlForm: TWebPanel;
        pnlButtons: TWebPanel;
        btnPayloads: TWebLabel;
        btnDirection: TWebLabel;
        btnMap: TWebLabel;
        btnSSDV: TWebLabel;
        btnSettings: TWebLabel;
        btnSources: TWebLabel;
        pnlButtonTop: TWebPanel;
        pnlButtonBottom: TWebPanel;
        WebLabel1: TWebLabel;
        pnlPayloads: TWebPanel;
        lblPayload3: TWebLabel;
        lblPayload2: TWebLabel;
        lblPayload1: TWebLabel;
        lblPayload: TWebLabel;
        lblBottomLeft: TWebLabel;
        lblGPSStatus: TWebLabel;
    lblCE0: TWebLabel;
        lblGPS: TWebLabel;
        lblTopLeft: TWebLabel;
        pnlSources: TWebPanel;
        lblBottomRight: TWebLabel;
        lblTopRight: TWebLabel;
        pnlMap: TWebPanel;
        pnlDirection: TWebPanel;
        pnlSSDV: TWebPanel;
        pnlSettings: TWebPanel;
        pnlSplash: TWebPanel;
        lblHABLinkStatus: TWebLabel;
        tmrInit: TWebTimer;
        btnLog: TWebLabel;
        pnlLog: TWebPanel;
        tmrBleep: TWebTimer;
        pnlMain: TWebPanel;
        lblSSDVUplinkStatus: TWebLabel;
        lblHABHUBUplinkStatus: TWebLabel;
        lblHABLINKUplinkStatus: TWebLabel;
        tmrScreenUpdates: TWebTimer;
    lblCE1: TWebLabel;
        lblHABHUBStatus: TWebLabel;
        lblUSB: TWebLabel;
        tmrSources: TWebTimer;
    WebWaitMessage1: TWebWaitMessage;
    tmrUploads: TWebTimer;
        procedure MiletusFormResize(Sender: TObject);
        [async]
        procedure btnPayloadsClick(Sender: TObject);
        procedure MiletusFormCreate(Sender: TObject);
        procedure btnSourcesClick(Sender: TObject);
        procedure MiletusFormShow(Sender: TObject);
        procedure btnMapClick(Sender: TObject);
        procedure btnDirectionClick(Sender: TObject);
        procedure btnSSDVClick(Sender: TObject);
        procedure btnSettingsClick(Sender: TObject);
        procedure SelectPayload(Sender: TObject);
        [async]
        procedure lblGPSClick(Sender: TObject);
        procedure tmrInitTimer(Sender: TObject);
        procedure btnLogClick(Sender: TObject);
        procedure tmrBleepTimer(Sender: TObject);
        procedure tmrScreenUpdatesTimer(Sender: TObject);
        procedure lblTopLeftClick(Sender: TObject);
        procedure tmrSourcesTimer(Sender: TObject);
        [async] procedure tmrUploadsTimer(Sender: TObject);
    private
        { Private declarations }
        MainButtons: Array [1 .. 7] of TWebLabel;
        HABSources: Array [0 .. 5] of THABSource;
        Targets: Array [1 .. 3] of TWebLabel;
        ActiveButton: TWebLabel;
        ActivePanel: TWebPanel;
        ActiveForm: TfrmBase;
        function PlacePayloadInList(SourceID: Integer): Integer;
        function FindOrAddPayload(SourceID: Integer): Integer;
        procedure ShowForm(Button: TWebLabel; NewPanel: TWebPanel; NewForm: TfrmBase);
        procedure ShowSelectedPayloadPosition;
        procedure WhereIsBalloon(PayloadIndex: Integer);
        procedure WhereAreBalloons;
        procedure DoPayloadCalcs(PayloadIndex: Integer);
        [async]
        procedure Initialise;
    public
        { Public declarations }
        IsRaspberryPi: Boolean;
        LastChaseUpload: TDateTime;
        Payloads: Array [0 .. 3] of TPayload;
        SelectedIndex: Integer;
        procedure ShowTargetStatus(TargetID: Integer; Enabled, Connected: Boolean);
        procedure ShowSourceStatus(SourceID: Integer; Enabled, Connected, GotData: Boolean);
        // [async] procedure NewGPSPosition(Position: THABPosition);
        // [async] procedure NewPosition(SourceID: Integer; Position: THABPosition);
        procedure ShowSettings(PageIndex: Integer);
    end;

var
    frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Splash, Payloads, Direction, SSDV, Log, Settings, Map, Sources, Target,
    HABLink, Habitat;

procedure TfrmMain.btnDirectionClick(Sender: TObject);
begin
    ShowForm(TWebLabel(Sender), pnlDirection, frmDirection);
end;

procedure TfrmMain.btnLogClick(Sender: TObject);
begin
    ShowForm(TWebLabel(Sender), pnlLog, frmLog);
end;

procedure TfrmMain.btnMapClick(Sender: TObject);
begin
    ShowForm(TWebLabel(Sender), pnlMap, frmMap);
end;

procedure TfrmMain.btnPayloadsClick(Sender: TObject);
begin
    ShowForm(TWebLabel(Sender), pnlPayloads, frmPayloads);
end;

procedure TfrmMain.btnSettingsClick(Sender: TObject);
begin
    ShowSettings(0);
end;

procedure TfrmMain.ShowSettings(PageIndex: Integer);
    procedure AfterSettingsCreate(AForm: TObject);
    begin
        //
        ShowForm(btnSettings, pnlSettings, frmSettings);
        frmSettings.ShowPage(PageIndex);
    end;

begin
    if frmSettings = nil then
    begin
        frmSettings := TfrmSettings.CreateNew(pnlSettings.ElementID,
          @AfterSettingsCreate);
    end
    else
    begin
        ShowForm(btnSettings, pnlSettings, frmSettings);
        frmSettings.ShowPage(PageIndex);
    end;
end;

procedure TfrmMain.btnSourcesClick(Sender: TObject);
begin
    ShowForm(TWebLabel(Sender), pnlSources, frmSources);
end;

procedure TfrmMain.btnSSDVClick(Sender: TObject);
begin
    ShowForm(btnSSDV, pnlSSDV, frmSSDV);
end;

procedure TfrmMain.MiletusFormCreate(Sender: TObject);
begin
    Initialise;
end;

procedure TfrmMain.Initialise;
var
    os: TMiletusOSVersion;
begin
    WebWaitMessage1.Show;

    os := Await(TMiletusOSVersion, GetOSVersionP);

    IsRaspberryPi := os.Platform = opLinux;

    if IsRaspberryPi then begin
        Self.WindowState := wsMaximized;
        Self.BorderStyle := bsNoneBorder;
    end else begin
        Self.BorderStyle := bsSizeableBorder; // bsSingleBorder;
        Self.WindowState := wsNormal;
        lblCE0.Visible := False;
        lblCE1.Visible := False;
    end;

    ActivePanel := nil;
    ActiveForm := nil;

    HABSources[0].SourceLabel := lblGPSStatus;
    HABSources[1].SourceLabel := lblCE0;
    HABSources[2].SourceLabel := lblCE1;
    HABSources[3].SourceLabel := lblUSB;
    HABSources[4].SourceLabel := lblHABLinkStatus;
    HABSources[5].SourceLabel := lblHABHUBStatus;

    Targets[1] := lblHABHUBUplinkStatus;
    Targets[2] := lblHABLINKUplinkStatus;
    Targets[3] := lblSSDVUplinkStatus;

    Payloads[1].Button := lblPayload1;
    Payloads[2].Button := lblPayload2;
    Payloads[3].Button := lblPayload3;

    Payloads[1].Colour := clBlue;
    Payloads[2].Colour := clRed;
    Payloads[3].Colour := clLime;

    Payloads[1].ColourName := 'blue';
    Payloads[2].ColourName := 'red';
    Payloads[3].ColourName := 'green';

    AddCSS('TopLeft', '.TopLeft {border-radius: 12px 0px 0px 0px}');
    AddCSS('TopRight', '.TopRight {border-radius: 0px 12px 0px 0px}');
    AddCSS('BottomRight', '.BottomRight {border-radius: 0px 0px 12px 0px}');
    AddCSS('BottomLeft', '.BottomLeft {border-radius: 0px 0px 0px 12px}');

    AddCSS('RoundedCorners', '.RoundedCorners {border-radius: 12px; background: #0; border: 2px solid  #ffff00; padding: 20px;}');
    AddCSS('RoundedButton', '.RoundedButton {border-radius: 24px; background: #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px;}');
    AddCSS('RoundedLabel', '.RoundedLabel {border-radius: 24px;  background: #0; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 36px; color: #ffff00;}');
    AddCSS('ColumnRoundedCorners', '.ColumnRoundedCorners {border-radius: 24px; background: #0; border: 2px solid  #ffff00; padding: 20px; width: 33%;}');

    AddCSS('BooleanButtonOn', '.BooleanButtonOn {border-radius: 24px; background: #ffff00; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px; color: #0;}');
    AddCSS('BooleanButtonOff', '.BooleanButtonOff {border-radius: 24px; background: #000000; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px; color: #ffff00;}');

    AddCSS('PushButtonOn', '.PushButtonOn {border-radius: 24px; background: #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px;}');
    AddCSS('PushButtonOff', '.PushButtonOff {border-radius: 24px; background: #a99c4e; font-family:''Swiss911 UCm BT''; font-size: 24px;}');

    AddCSS('SettingsButton', '.SettingsButton {border-radius: 24px; background: #000000; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 14px; color: #ffff00;}');

    lblTopLeft.ElementClassName := 'TopLeft';
    lblTopRight.ElementClassName := 'TopRight';
    lblBottomRight.ElementClassName := 'BottomRight';
    lblBottomLeft.ElementClassName := 'BottomLeft';
end;

procedure TfrmMain.tmrInitTimer(Sender: TObject);
begin
    // tmrInit.Enabled := False;

    // if frmSources <> nil then frmSources.AfterLoad;
end;

procedure TfrmMain.tmrScreenUpdatesTimer(Sender: TObject);
var
    PayloadIndex, SourceIndex: Integer;
begin
    for PayloadIndex := Low(Payloads) to High(Payloads) do begin
        // Payloads updates on screen
        if Payloads[PayloadIndex].UpdateScreen then begin

            frmMap.NewPosition(PayloadIndex, Payloads[PayloadIndex].Position);

            // Balloons only
            if PayloadIndex > 0 then begin
                frmPayloads.NewPosition(PayloadIndex, Payloads[PayloadIndex].Position);

                // Select payload if it's the only one
                if SelectedIndex < 1 then begin
                    SelectPayload(lblPayload1);
                end;

                // Selected payload only
                if PayloadIndex = SelectedIndex then begin
                    if frmDirection <> nil then begin
                        frmDirection.NewPosition(PayloadIndex, Payloads[PayloadIndex].Position);
                    end;
                    ShowSelectedPayloadPosition;
                end;
            end;

            // INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
            // if await(Boolean, INIFile.ReadBool('General', 'PositionBeeps', False)) then begin
            // tmrBleep.Tag := 1;
            // end;

            Payloads[PayloadIndex].UpdateScreen := False;
        end;

        // Timed out payloads
        if PayloadIndex > 0 then begin
            if Payloads[PayloadIndex].LastReceivedAt > 0 then
            begin
                if Now > (Payloads[PayloadIndex].LastReceivedAt + 60 / 86400) then
                begin
                    Payloads[PayloadIndex].Button.Font.Color := clRed;
                end;
            end;
        end;
    end;

    for SourceIndex := Low(HABSources) to High(HABSources) do
    begin
        if HABSources[SourceIndex].LastReceivedAt > 0 then
        begin
            if Now > (HABSources[SourceIndex].LastReceivedAt + 60 / 86400) then begin
                HABSources[SourceIndex].SourceLabel.Font.Color := clRed;
            end;
        end;
    end;
end;

procedure TfrmMain.tmrSourcesTimer(Sender: TObject);
var
    SourceID, PayloadIndex: Integer;
    PositionOK: Boolean;
begin
    for SourceID := Low(HABPositions) to High(HABPositions) do begin
        if HABPositions[SourceID].Updated then begin
            ShowSourceStatus(SourceID, True, True, True);

            if SourceID = GPS_SOURCE then begin
                Payloads[0].Position := HABPositions[SourceID];

                lblGPS.Caption := FormatDateTime('hh:nn:ss',
                  HABPositions[SourceID].TimeStamp) + ' , ' +
                  FormatFloat('0.00000', HABPositions[SourceID].Latitude) + ', '
                  + FormatFloat('0.00000', HABPositions[SourceID].Longitude) +
                  ', ' + FormatFloat('0', HABPositions[SourceID].Altitude) +
                  'm, ' + IntToStr(HABPositions[SourceID].Satellites) + ' sats';

                WhereAreBalloons;

                Payloads[0].UpdateScreen := True;
                Payloads[0].UploadPosition := True;
            end else begin
                PayloadIndex := PlacePayloadInList(SourceID);

                if PayloadIndex > 0 then begin
                    if Payloads[PayloadIndex].LoggedLoss then begin
                        Payloads[PayloadIndex].LoggedLoss := False;
                        frmLog.AddMessage(Payloads[PayloadIndex].Position.PayloadID, 'Signal Regained', True, False);
                    end;

                    PositionOK := (Payloads[PayloadIndex].Position.Latitude <> 0.0) or (Payloads[PayloadIndex].Position.Longitude <> 0.0);

                    if PositionOK <> Payloads[PayloadIndex].GoodPosition then begin
                        Payloads[PayloadIndex].GoodPosition := PositionOK;

                        if PositionOK then begin
                            frmLog.AddMessage
                              (Payloads[PayloadIndex].Position.PayloadID, 'GPS Position Valid', True, False);
                        end else begin
                            frmLog.AddMessage
                              (Payloads[PayloadIndex].Position.PayloadID, 'GPS Position Lost', True, False);
                        end;
                    end;

                    WhereIsBalloon(PayloadIndex);

                    Payloads[PayloadIndex].UpdateScreen := True;
                    Payloads[PayloadIndex].UploadPosition := (Payloads[PayloadIndex].Position.Longitude <> 0) or
                                                             (Payloads[PayloadIndex].Position.Latitude <> 0) or
                                                             (Payloads[PayloadIndex].Position.Altitude <> 0);
                    Payloads[PayloadIndex].SourceID := SourceID;
                end;
            end;

            HABPositions[SourceID].Updated := False;
        end;
    end;
end;

procedure TfrmMain.tmrUploadsTimer(Sender: TObject);
var
    INIFile: TMiletusINIFile;
    UploadCallsign, ChaseCallsign: String;
    PayloadIndex, ChasePeriod: Integer;
    HabLinkEnabled, HabitatEnabled, ChaseEnabled, USBEnabled, HATEnabled, OK: Boolean;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');

    ChaseEnabled := await(Boolean, INIFile.ReadBool('Chase', 'Enabled', False));
    ChaseCallsign := await(String, INIFile.ReadString('Chase', 'Callsign', ''));
    ChasePeriod := await(Integer, INIFile.ReadString('Chase', 'Period', ''));

    UploadCallsign := await(String, INIFile.ReadString('General', 'Callsign', ''));
    HabLinkEnabled := await(Boolean, INIFile.ReadBool('Upload', 'HabLinkEnabled', False));
    HabitatEnabled := await(Boolean, INIFile.ReadBool('Upload', 'HabitatEnabled', False));

    USBEnabled := await(Boolean, INIFile.ReadBool('LoRaUSB', 'Upload', False));
    HATEnabled := await(Boolean, INIFile.ReadBool('LoRaHAT', 'Upload', False));
    INIFile.Free;

    if HabLinkEnabled or HabitatEnabled then begin
        // Chase car position
        if (ChasePeriod > 0) and Payloads[0].UploadPosition and
           (Now > (Payloads[PayloadIndex].LastUploadAt + ChasePeriod/86400)) and
           (ChaseCallsign <> '') then begin
            if HABLinkEnabled then begin
                Payloads[PayloadIndex].LastUploadAt := Now;
                frmHABLink.SendGPSPosition(ChaseCallsign, Payloads[PayloadIndex].Position);
                Payloads[0].UploadPosition := False;
            end;

            if HabitatEnabled then begin
                Payloads[PayloadIndex].LastUploadAt := Now;
                frmHabitat.UploadCarPosition(ChaseCallsign, Payloads[PayloadIndex].Position);
                Payloads[0].UploadPosition := False;
            end;
        end;

        // Balloons
        if UploadCallsign <> '' then begin
            for PayloadIndex := 1 to High(Payloads) do begin
                if Payloads[PayloadIndex].UploadPosition then begin
                    if Payloads[PayloadIndex].SourceID = 3 then begin
                        OK := USBEnabled;
                    end else if Payloads[PayloadIndex].SourceID in [1..2] then begin
                        OK := HATEnabled;
                    end else begin
                        OK := False;
                    end;

                    if HabLinkEnabled then begin
                        frmHabitat.UploadHABPosition(UploadCallsign, Payloads[PayloadIndex].Position.Sentence);
                    end;

                    if HabitatEnabled then begin
                        frmHABLink.SendPayloadPosition(Payloads[PayloadIndex].Position.Sentence);
                    end;
                end;
            end;
        end;
    end;
end;

procedure TfrmMain.MiletusFormResize(Sender: TObject);
var
    i, ButtonHeight, ButtonGap: Integer;
begin
    if btnPayloads <> nil then
    begin
        if MainButtons[1] = nil then
        begin
            MainButtons[1] := btnPayloads;
            MainButtons[2] := btnDirection;
            MainButtons[3] := btnMap;
            MainButtons[4] := btnSSDV;
            MainButtons[5] := btnLog;
            MainButtons[6] := btnSettings;
            MainButtons[7] := btnSources;
        end;

        pnlButtonTop.Height := Self.ClientHeight div 18;
        pnlButtonBottom.Height := pnlButtonTop.Height;

        ButtonHeight := (Self.ClientHeight - pnlButtonTop.Height * 2)
          div High(MainButtons);
        ButtonGap := Max(1, (ButtonHeight * 4) div 50);

        for i := 1 to high(MainButtons) - 1 do
        begin
            MainButtons[i].Height := ButtonHeight - ButtonGap;
            MainButtons[i].Margins.Bottom := ButtonGap;
        end;
    end;
end;

procedure TfrmMain.MiletusFormShow(Sender: TObject);
const
    FirstTime: Boolean = True;

    // procedure AfterSettingsCreate(AForm: TObject);
    // begin
    // tmrWaitForSettingsSubForms.Enabled := True;
    // end;

    procedure AfterSourcesCreate(AForm: TObject);
    begin
        // frmSplash.lblStatus.Caption := 'Loading settings form ...';
        // frmSettings := TfrmSettings.CreateNew(pnlSettings.ElementID, @AfterSettingsCreate);
        frmSplash.lblStatus.Caption := 'Loaded OK';
        frmSources.AfterLoad;
        // tmrInit.Enabled := True;
    end;

    procedure AfterlogCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading sources  ...';
        frmSources := TfrmSources.CreateNew(pnlSources.ElementID,
          @AfterSourcesCreate);
    end;

    procedure AfterSSDVCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading log form ...';
        frmLog := TfrmLog.CreateNew(pnlLog.ElementID, @AfterlogCreate);
    end;

    procedure AfterMapCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading SSDV form ...';
        frmSSDV := TfrmSSDV.CreateNew(pnlSSDV.ElementID, @AfterSSDVCreate);
    end;

    procedure AfterDirectionCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading map form ...';
        frmMap := TfrmMap.CreateNew(pnlMap.ElementID, @AfterMapCreate);
    end;

    procedure AfterPayloadsCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading direction form ...';
        frmDirection := TfrmDirection.CreateNew(pnlDirection.ElementID,
          @AfterDirectionCreate);
    end;

    procedure AfterSplashCreate(AForm: TObject);
    begin
        ShowForm(nil, pnlSplash, frmSplash);
        frmSplash.lblStatus.Caption := 'Loading payloads form ...';
        frmPayloads := TfrmPayloads.CreateNew(pnlPayloads.ElementID,
          @AfterPayloadsCreate);
    end;

begin
    if FirstTime then
    begin
        FirstTime := False;

        // Create forms
        frmSplash := TfrmSplash.CreateNew(pnlSplash.ElementID,
          @AfterSplashCreate);
    end;
end;

procedure TfrmMain.ShowForm(Button: TWebLabel; NewPanel: TWebPanel;
  NewForm: TfrmBase);
begin
    pnlSplash.Visible := False;

    if ActivePanel <> nil then
    begin
        ActivePanel.Visible := False;
        ActivePanel := nil;
    end;

    if NewPanel <> nil then
    begin
        NewPanel.Visible := True;
        ActivePanel := NewPanel;
    end;

    if NewForm <> nil then
    begin
        ActiveForm := NewForm;
        NewForm.Resize;
        NewForm.AfterShow;
    end;
end;

function TfrmMain.FindOrAddPayload(SourceID: Integer): Integer;
var
    i: Integer;
begin
    Result := -1;

    // Look for same payload
    for i := 1 to High(Payloads) do begin
        if HABPositions[SourceID].PayloadID = Payloads[i].Position.PayloadID then begin
            Result := i;
            Exit;
        end;
    end;

    // Look for empty slot
    for i := 1 to High(Payloads) do begin
        if Payloads[i].Position.PayloadID = '' then begin
            Result := i;
            Exit;
        end;
    end;

    // Look for oldest payload
    Result := 1;
    for i := 2 to High(Payloads) do begin
        if Payloads[i].Position.TimeStamp < Payloads[Result].Position.TimeStamp then begin
            // This one is older than oldest so far
            Result := i;
        end;
    end;
end;

procedure TfrmMain.lblGPSClick(Sender: TObject);
begin
    MiletusShell.Beep;
end;

procedure TfrmMain.lblTopLeftClick(Sender: TObject);
begin
    ShowForm(nil, pnlSplash, frmSplash);
end;

function TfrmMain.PlacePayloadInList(SourceID: Integer): Integer;
var
    NewMask, PayloadIndex: Integer;
    PayloadChanged, PositionChanged: Boolean;
begin
    Result := 0;

    // if Position.InUse and not Position.IsChase then begin
    PayloadIndex := FindOrAddPayload(SourceID);

    if PayloadIndex > 0 then begin
        // Update forms with payload list, if it has changed
        if HABPositions[SourceID].PayloadID <> Payloads[PayloadIndex].Position.PayloadID then begin
            frmLog.AddMessage(HABPositions[SourceID].PayloadID, 'telemetry now being received', True, True);
            PayloadChanged := True;
        end else begin
            PayloadChanged := False;
        end;

        // if (Position.TimeStamp - Payloads[Index].Previous.TimeStamp) >= 1/86400 then begin
        PositionChanged := (HABPositions[SourceID].TimeStamp <> Payloads[PayloadIndex].Position.TimeStamp) or
          (HABPositions[SourceID].Counter <> Payloads[PayloadIndex].Position.Counter);

        if PayloadChanged or PositionChanged then begin
            // Update buttons
            Payloads[PayloadIndex].Button.Caption := HABPositions[SourceID].PayloadID;
            Payloads[PayloadIndex].Button.Color := $006FDFF1;
            Payloads[PayloadIndex].Button.Font.Color := clGreen;
            Payloads[PayloadIndex].LastReceivedAt := Now;

            Payloads[PayloadIndex].Previous := Payloads[PayloadIndex].Position;

            Payloads[PayloadIndex].Position := HABPositions[SourceID];

            DoPayloadCalcs(PayloadIndex);

            (*
              // Select payload if it's the only one
              if SelectedPayload < 1 then begin
              SelectPayload(btnPayload1);
              end;
            *)

            // if PayloadChanged then begin
            // UpdatePayloadList;
            // end;

            Result := PayloadIndex;
        end;
    end;
    // end;
end;

procedure TfrmMain.DoPayloadCalcs(PayloadIndex: Integer);
const
    FlightModes: Array[0..8] of String = ('Idle', 'Launched', 'Descending', 'Homing', 'Direct To Target', 'Downwind', 'Upwind', 'Landing', 'Landed');
begin
    with Payloads[PayloadIndex] do begin
        Position.AscentRate := (Position.Altitude - Previous.Altitude) / (86400 * (Position.TimeStamp - Previous.TimeStamp));
        Position.MaxAltitude := max(Position.Altitude, Previous.MaxAltitude);

        // Default is no change to flight mode
        Position.FlightMode := Previous.FlightMode;

        // Flight mode
        case Previous.FlightMode of
            fmIdle: begin
                if ((Position.AscentRate > 2.0) and (Position.Altitude > 100)) or
                   (Position.Altitude > 5000) or
                   (Abs(Position.AscentRate) > 20) or
                   ((Position.AscentRate > 1.0) and (Position.Altitude > 300)) then begin
                    Position.FlightMode := fmLaunched;
                end;
            end;

            fmLaunched: begin
                if Position.AscentRate < -4 then begin
                    Position.FlightMode := fmDescending;
                end;
            end;

            fmDescending: begin
                if Position.AscentRate > -1 then begin
                    Position.FlightMode := fmLanded;
                end;
            end;

            fmLanded: begin
                if ((Position.AscentRate > 3.0) and (Position.Altitude > 100)) or
                   ((Position.AscentRate > 2.0) and (Position.Altitude > 500)) then begin
                    Position.FlightMode := fmLaunched;
                end;
            end;
        end;

        if Position.FlightMode = fmDescending then begin
            Position.DescentTime := CalculateDescentTime(Position.Altitude, -Position.AscentRate, HABPositions[GPS_SOURCE].Altitude) / 86400;
        end;
    end;
end;

procedure TfrmMain.ShowSelectedPayloadPosition;
begin
    with Payloads[SelectedIndex].Position do begin
         lblPayload.Caption := FormatDateTime('hh:nn:ss', TimeStamp) + '  ' + Format('%2.6f', [Latitude]) + ',' + Format('%2.6f', [Longitude]) + ' at ' + Format('%.0f', [Altitude]) + 'm';
    end;
end;

procedure TfrmMain.ShowSourceStatus(SourceID: Integer; Enabled, Connected, GotData: Boolean);
begin
    if (SourceID >= Low(HABSources)) and (SourceID <= High(HABSources)) then begin
        if Enabled then begin
            if Connected then begin
                HABSources[SourceID].SourceLabel.Color := $006FDFF1;

                if GotData then begin
                    HABSources[SourceID].LastReceivedAt := Now;
                    HABSources[SourceID].SourceLabel.Font.Color := clGreen;
                end;
            end else begin
                HABSources[SourceID].SourceLabel.Color := clRed;
                HABSources[SourceID].SourceLabel.Font.Color := clBlack;
                HABSources[SourceID].LastReceivedAt := 0;
            end;
        end else begin
            HABSources[SourceID].SourceLabel.Color := $004E9CA9;
            HABSources[SourceID].SourceLabel.Font.Color := clBlack;
        end;
    end;
end;


procedure TfrmMain.SelectPayload(Sender: TObject);
begin
    if TWebLabel(Sender).Tag <> SelectedIndex then
    begin
        if Payloads[TWebLabel(Sender).Tag].Position.PayloadID <> '' then
        begin
            // Select payload
            SelectedIndex := TWebLabel(Sender).Tag;

            // Show selected payload on buttons
            lblPayload1.Font.Style := lblPayload1.Font.Style - [fsUnderline];
            lblPayload2.Font.Style := lblPayload2.Font.Style - [fsUnderline];
            lblPayload3.Font.Style := lblPayload3.Font.Style - [fsUnderline];

            TWebLabel(Sender).Font.Style := TWebLabel(Sender).Font.Style +
              [fsUnderline];

            // Update main screen
            ShowSelectedPayloadPosition;
        end;
    end;
end;

procedure TfrmMain.WhereIsBalloon(PayloadIndex: Integer);
begin
    if (Payloads[0].Position.Latitude <> 0) or (Payloads[0].Position.Longitude <> 0) then begin
        Payloads[PayloadIndex].Position.DirectionValid := True;
        // Horizontal distance to payload
        Payloads[PayloadIndex].Position.Distance :=
          CalculateDistance(Payloads[0].Position.Latitude, Payloads[0].Position.Longitude,
          Payloads[PayloadIndex].Position.Latitude,
          Payloads[PayloadIndex].Position.Longitude);
        // Direction to payload
        Payloads[PayloadIndex].Position.Direction :=
          CalculateDirection(Payloads[PayloadIndex].Position.Latitude,
          Payloads[PayloadIndex].Position.Longitude, Payloads[0].Position.Latitude,
          Payloads[0].Position.Longitude) - Payloads[0].Position.Direction;

        Payloads[PayloadIndex].Position.Elevation :=
          CalculateElevation(Payloads[0].Position.Latitude, Payloads[0].Position.Longitude,
          Payloads[0].Position.Altitude, Payloads[PayloadIndex].Position.Latitude,
          Payloads[PayloadIndex].Position.Longitude,
          Payloads[PayloadIndex].Position.Altitude);

        if Payloads[PayloadIndex].Position.ContainsPrediction then begin
            // Horizontal distance to payload
            Payloads[PayloadIndex].Position.PredictionDistance :=
              CalculateDistance(Payloads[0].Position.Latitude, Payloads[0].Position.Longitude,
              Payloads[PayloadIndex].Position.PredictedLatitude,
              Payloads[PayloadIndex].Position.PredictedLongitude);
            // Direction to payload
            Payloads[PayloadIndex].Position.PredictionDirection :=
              CalculateDirection(Payloads[PayloadIndex]
              .Position.PredictedLatitude,
              Payloads[PayloadIndex].Position.PredictedLongitude,
              Payloads[0].Position.Latitude, Payloads[0].Position.Longitude) -
              Payloads[0].Position.Direction;
        end;
    end else begin
        Payloads[PayloadIndex].Position.DirectionValid := False;
    end;
end;

procedure TfrmMain.tmrBleepTimer(Sender: TObject);
begin
    if tmrBleep.Tag > 0 then
    begin
        if tmrBleep.Tag = 1 then
        begin
            // MessageBeep(MB_OK);
            MiletusShell.Beep;
        end
        else if tmrBleep.Tag = 2 then
        begin
            // MessageBeep(MB_ICONERROR);
            MiletusShell.Beep;
        end
        else
        begin
            // MessageBeep(MB_ICONWARNING);
            MiletusShell.Beep;
        end;
    end;

    tmrBleep.Tag := 0;
end;

procedure TfrmMain.WhereAreBalloons;
var
    PayloadIndex: Integer;
begin
    for PayloadIndex := 1 to High(Payloads) do begin
        WhereIsBalloon(PayloadIndex);
    end;
end;

procedure TfrmMain.ShowTargetStatus(TargetID: Integer;
  Enabled, Connected: Boolean);
begin
    if (TargetID >= Low(Targets)) and (TargetID <= High(Targets)) then
    begin
        if Enabled then
        begin
            if Connected then
            begin
                Targets[TargetID].Color := $006FDFF1;
            end
            else
            begin
                Targets[TargetID].Color := clRed;
                Targets[TargetID].Font.Color := clBlack;
            end;
        end
        else
        begin
            Targets[TargetID].Color := $004E9CA9;
            Targets[TargetID].Font.Color := clBlack;
        end;
    end;
end;

initialization

RegisterClass(TfrmMain);

end.
