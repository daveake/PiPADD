unit main;

interface

uses
    System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
    WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls,
    WEBLib.StdCtrls, WEBLib.ExtCtrls, Math, Base, misc, WEBLib.REST,
    WEBLib.WebCtrls;

type
    THABSource = record
        LastReceivedAt:     TDateTime;
        SourceLabel:        TWebLabel;
    end;

type
  TPayload = record
      HasPosition:          Boolean;
      Previous:             THABPosition;
      Position:             THABPosition;
      Button:               TWebLabel;
      Colour:               TColor;
      ColourName:           String;
      GoodPosition:         Boolean;
      LoggedLoss:           Boolean;
      LastReceivedAt:       TDateTime;
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
        lblLoRaStatus1: TWebLabel;
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
        lblLoRaStatus2: TWebLabel;
    lblHABHUBStatus: TWebLabel;
    lblUSB: TWebLabel;
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
    [async]
    private
        { Private declarations }
        MainButtons: Array [1 .. 7] of TWebLabel;
        HABSources: Array[0..5] of THABSource;
        Targets: Array[1..3] of TWebLabel;
        ActiveButton: TWebLabel;
        ActivePanel: TWebPanel;
        ActiveForm: TfrmBase;
        function PlacePayloadInList(var Position: THABPosition): Integer;
        function FindOrAddPayload(Position: THABPosition): Integer;
        procedure ShowForm(Button: TWebLabel; NewPanel: TWebPanel; NewForm: TfrmBase);
        procedure ShowSelectedPayloadPosition;
        procedure WhereIsBalloon(PayloadIndex: Integer);
        procedure WhereAreBalloons;
        [async]
        procedure Initialise;
    public
        { Public declarations }
        IsRaspberryPi: Boolean;
        Car: TPayload;
        LastChaseUpload: TDateTime;
        Payloads: Array[1..3] of TPayload;
        SelectedIndex: Integer;
        procedure ShowTargetStatus(TargetID: Integer; Enabled, Connected: Boolean);
        procedure ShowSourceStatus(SourceID: Integer; Enabled, Connected, GotData: Boolean);
        [async] procedure NewGPSPosition(Position: THABPosition);
        [async] procedure NewPosition(SourceID: Integer; Position: THABPosition);
        procedure ShowSettings(PageIndex: Integer);
    end;

var
    frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Splash, Payloads, Direction, SSDV, Log, Settings, Map, Sources, Target, HABLink, Habitat;

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
    if frmSettings = nil then begin
        frmSettings := TfrmSettings.CreateNew(pnlSettings.ElementID, @AfterSettingsCreate);
    end else begin
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
    os := Await(TMiletusOSVersion, GetOSVersionP);

    IsRaspberryPi := os.Platform = opLinux;

    if IsRaspberryPi then begin
        Self.WindowState := wsMaximized;
        Self.BorderStyle := bsNoneBorder;
    end else begin
        Self.BorderStyle := bsSizeableBorder;   // bsSingleBorder;
        Self.WindowState := wsNormal;
        lblLoRaStatus1.Visible := False;
        lblLoRaStatus2.Visible := False;
    end;

    ActivePanel := nil;
    ActiveForm := nil;

    HABSources[0].SourceLabel := lblGPSStatus;
    HABSources[1].SourceLabel := lblLoRaStatus1;
    HABSources[2].SourceLabel := lblLoRaStatus2;
    HABSources[3].SourceLabel := lblUSB;;
    HABSources[4].SourceLabel := lblHABLINKStatus;
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
    Payloads[3].ColourName :='green';

    AddCSS('TopLeft', '.TopLeft {border-radius: 12px 0px 0px 0px}');
    AddCSS('TopRight', '.TopRight {border-radius: 0px 12px 0px 0px}');
    AddCSS('BottomRight', '.BottomRight {border-radius: 0px 0px 12px 0px}');
    AddCSS('BottomLeft', '.BottomLeft {border-radius: 0px 0px 0px 12px}');

    AddCSS('RoundedCorners','.RoundedCorners {border-radius: 24px; background: #0; border: 2px solid  #ffff00; padding: 20px;}');
    AddCSS('RoundedButton','.RoundedButton {border-radius: 24px; background: #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px;}');
    AddCSS('RoundedLabel','.RoundedLabel {border-radius: 24px;  background: #0; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 36px; color: #ffff00;}');
    AddCSS('ColumnRoundedCorners','.ColumnRoundedCorners {border-radius: 24px; background: #0; border: 2px solid  #ffff00; padding: 20px; width: 33%;}');

    AddCSS('BooleanButtonOn','.BooleanButtonOn {border-radius: 24px; background: #ffff00; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px; color: #0;}');
    AddCSS('BooleanButtonOff','.BooleanButtonOff {border-radius: 24px; background: #000000; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px; color: #ffff00;}');

    AddCSS('PushButtonOn','.PushButtonOn {border-radius: 24px; background: #ffff00; font-family:''Swiss911 UCm BT''; font-size: 24px;}');
    AddCSS('PushButtonOff','.PushButtonOff {border-radius: 24px; background: #a99c4e; font-family:''Swiss911 UCm BT''; font-size: 24px;}');

    AddCSS('SettingsButton','.SettingsButton {border-radius: 24px; background: #000000; border: 2px solid  #ffff00; font-family:''Swiss911 UCm BT''; font-size: 14px; color: #ffff00;}');

    lblTopLeft.ElementClassName := 'TopLeft';
    lblTopRight.ElementClassName := 'TopRight';
    lblBottomRight.ElementClassName := 'BottomRight';
    lblBottomLeft.ElementClassName := 'BottomLeft';
end;

procedure TfrmMain.tmrInitTimer(Sender: TObject);
begin
//    tmrInit.Enabled := False;

    // if frmSources <> nil then frmSources.AfterLoad;
end;

procedure TfrmMain.tmrScreenUpdatesTimer(Sender: TObject);
var
    Index: Integer;
begin
    for Index := Low(Payloads) to High(Payloads) do begin
        if Payloads[Index].LastReceivedAt > 0 then begin
            if Now > (Payloads[Index].LastReceivedAt + 60/86400) then begin
                Payloads[Index].Button.Font.Color := clRed;
            end;
        end;
    end;

    for Index := Low(HABSources) to High(HABSources) do begin
        if HABSources[Index].LastReceivedAt > 0 then begin
            if Now > (HABSources[Index].LastReceivedAt + 60/86400) then begin
                HABSources[Index].SourceLabel.Font.Color := clRed;
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

        ButtonHeight := (Self.ClientHeight - pnlButtonTop.Height * 2) div High(MainButtons);
        ButtonGap := Max(1, (ButtonHeight * 4) div 50);

        for i := 1 to high(MainButtons)-1 do
        begin
            MainButtons[i].Height := ButtonHeight - ButtonGap;
            MainButtons[i].Margins.Bottom := ButtonGap;
        end;
    end;
end;

procedure TfrmMain.MiletusFormShow(Sender: TObject);
const
    FirstTime: Boolean = True;

//    procedure AfterSettingsCreate(AForm: TObject);
//    begin
//        tmrWaitForSettingsSubForms.Enabled := True;
//    end;

    procedure AfterSourcesCreate(AForm: TObject);
    begin
//        frmSplash.lblStatus.Caption := 'Loading settings form ...';
//        frmSettings := TfrmSettings.CreateNew(pnlSettings.ElementID, @AfterSettingsCreate);
        frmSplash.lblStatus.Caption := 'Loaded OK';
        frmSources.AfterLoad;
        // tmrInit.Enabled := True;
    end;

    procedure AfterlogCreate(AForm: TObject);
    begin
        frmSplash.lblStatus.Caption := 'Loading sources  ...';
        frmSources := TfrmSources.CreateNew(pnlSources.ElementID, @AfterSourcesCreate);
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
        frmDirection := TfrmDirection.CreateNew(pnlDirection.ElementID, @AfterDirectionCreate);
    end;

    procedure AfterSplashCreate(AForm: TObject);
    begin
        ShowForm(nil, pnlSplash, frmSplash);
        frmSplash.lblStatus.Caption := 'Loading payloads form ...';
        frmPayloads := TfrmPayloads.CreateNew(pnlPayloads.ElementID, @AfterPayloadsCreate);
    end;

begin
    if FirstTime then begin
        FirstTime := False;

        // Create forms
        frmSplash := TfrmSplash.CreateNew(pnlSplash.ElementID, @AfterSplashCreate);
    end;
end;

procedure TfrmMain.ShowForm(Button: TWebLabel; NewPanel: TWebPanel; NewForm: TfrmBase);
begin
    pnlSplash.Visible := False;

//    if ActiveButton <> nil then begin
//        ActiveButton.Font.Style := [];
//    end;
//
//    if Button <> nil then begin
//        Button.Font.Style := [fsUnderline];
//        ActiveButton := Button;
//    end;

    if ActivePanel <> nil then begin
        ActivePanel.Visible := False;
        ActivePanel := nil;
    end;

    if NewPanel <> nil then begin
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

function TfrmMain.FindOrAddPayload(Position: THABPosition): Integer;
var
    i: Integer;
begin
    Result := 0;

    // Look for same payload
    for i := Low(Payloads) to High(Payloads) do begin
        if Position.PayloadID = Payloads[i].Position.PayloadID then begin
            Result := i;
            Exit;
        end;
    end;

    // Look for empty slot
    for i := Low(Payloads) to High(Payloads) do begin
        if Payloads[i].Position.PayloadID = '' then begin
            Result := i;
            Exit;
        end;
    end;

    // Look for oldest payload
    Result := Low(Payloads);
    for i := Low(Payloads)+1 to High(Payloads) do begin
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

function TfrmMain.PlacePayloadInList(var Position: THABPosition): Integer;
var
    NewMask, PayloadIndex: Integer;
    PayloadChanged: Boolean;
begin
    Result := 0;

//    if Position.InUse and not Position.IsChase then begin
        PayloadIndex := FindOrAddPayload(Position);

        // PayloadIndex[SourceID] := Index;

        if PayloadIndex > 0 then begin
//            NewMask := Payloads[Index].SourceMask or ((1 shl (SourceID * 2)) shl Position.Channel);
//            if NewMask <> Payloads[Index].SourceMask then begin
//                Payloads[Index].SourceMask := NewMask;
//                if frmUplink <> nil then frmUplink.NewSelection(SelectedPayload);
//            end;

            // Update forms with payload list, if it has changed
            if Position.PayloadID <> Payloads[PayloadIndex].Position.PayloadID then begin
                frmLog.AddMessage(Position.PayloadID, 'telemetry now being received', True, True);
                PayloadChanged := True;
            end else begin
                PayloadChanged := False;
            end;

            // if (Position.TimeStamp - Payloads[Index].Previous.TimeStamp) >= 1/86400 then begin
            if (Position.TimeStamp > Payloads[PayloadIndex].Position.TimeStamp) or (Position.PayloadID <> Payloads[PayloadIndex].Position.PayloadID) then begin
                // Retrieve previous flight mode
                Position.FlightMode := Payloads[PayloadIndex].Previous.FlightMode;

                // Calculate ascent rate etc
                // DoPayloadCalcs(Payloads[PayloadIndex].Previous, Position);

                // Update buttons
                Payloads[PayloadIndex].Button.Caption := Position.PayloadID;
                Payloads[PayloadIndex].Button.Color := $006FDFF1;
                Payloads[PayloadIndex].Button.Font.Color := clGreen;
                Payloads[PayloadIndex].LastReceivedAt := Now;

                // Store new position
                Payloads[PayloadIndex].Previous := Payloads[PayloadIndex].Position;

                // Position.TelemetryCount := Payloads[Index].Previous.TelemetryCount + 1;

                Payloads[PayloadIndex].Position := Position;
                Payloads[PayloadIndex].Previous.FlightMode := Position.FlightMode;

                (*
                // Select payload if it's the only one
                if SelectedPayload < 1 then begin
                    SelectPayload(btnPayload1);
                end;
                *)

//                if PayloadChanged then begin
//                    UpdatePayloadList;
//                end;

                Result := PayloadIndex;
            end;
        end;
//    end;
end;

procedure TfrmMain.ShowSelectedPayloadPosition;
begin
    with Payloads[SelectedIndex].Position do begin
        lblPayload.Caption := FormatDateTime('hh:nn:ss', TimeStamp) + '  ' +
                              Format('%2.6f', [Latitude]) + ',' +
                              Format('%2.6f', [Longitude]) + ' at ' +
                              Format('%.0f', [Altitude]) + 'm';
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

procedure TfrmMain.NewPosition(SourceID: Integer; Position: THABPosition);
var
    PayloadIndex: Integer;
    PositionOK: Boolean;
    Callsign, Group: String;
    INIFile: TMiletusINIFile;
begin
    ShowSourceStatus(SourceID, True, True, True);

    Position.Latitude := Position.Latitude + 1;
    Position.Longitude := Position.Longitude + 1;

    PayloadIndex := PlacePayloadInList(Position);

    if PayloadIndex > 0 then begin
        if Payloads[PayloadIndex].LoggedLoss then begin
            Payloads[PayloadIndex].LoggedLoss := False;
            frmLog.AddMessage(Position.PayloadID, 'Signal Regained', True, False);
        end;

        PositionOK := (Position.Latitude <> 0.0) or (Position.Longitude <> 0.0);

        if PositionOK <> Payloads[PayloadIndex].GoodPosition then begin
            Payloads[PayloadIndex].GoodPosition := PositionOK;

            if PositionOK then begin
                frmLog.AddMessage(Position.PayloadID, 'GPS Position Valid', True, False);
            end else begin
                frmLog.AddMessage(Position.PayloadID, 'GPS Position Lost', True, False);
            end;
        end;

        WhereIsBalloon(PayloadIndex);

        frmPayloads.NewPosition(PayloadIndex, Position);

        frmMap.NewPosition(PayloadIndex, Position);

        // Select payload if it's the only one
        if SelectedIndex < 1 then begin
            SelectPayload(lblPayload1);
        end;

        // Selected payload only
        if PayloadIndex = SelectedIndex then begin
            // if frmDirection <> nil then frmDirection.NewPosition(PayloadIndex, Payloads[Index].Position);
            ShowSelectedPayloadPosition;

            frmDirection.NewPosition(PayloadIndex, Position);
        end;

        INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
        if await(Boolean, INIFile.ReadBool('General', 'PositionBeeps', False)) then begin
            tmrBleep.Tag := 1;
        end;

        if SourceID in [1..3] then begin
            if Position.Sentence <> '' then begin
                if SourceID = 3 then begin
                    Group := 'LoRaUSB';
                end else begin
                    Group := 'LoRaHAT';
                end;

                if await(Boolean, INIFile.ReadBool('Upload', 'HabitatEnabled', False)) then begin
                    Callsign := await(String, INIFile.ReadString('General', 'Callsign', ''));
                    if Callsign <> '' then begin
                        if await(Boolean, INIFile.ReadBool(Group, 'HabitatEnabled', False)) then begin
                            frmHabitat.UploadHABPosition(Callsign, Position.Sentence);
                        end;
                    end;
                end;

                if await(Boolean, INIFile.ReadBool('Upload', 'HabLinkEnabled', False)) then begin
                    if await(Boolean, INIFile.ReadBool(Group, 'HabLinkEnabled', False)) then begin
                        frmHABLink.SendPayloadPosition(Position.Sentence);
                    end;
                end;
            end;
        end;
        INIFile.Free;

        // Landing prediction needed ?
//        if not Position.ContainsPrediction then begin
//            if Payloads[Index].PredictionIndex <= 0 then begin
//                Payloads[Index].PredictionIndex := Predictor.AddPayload(Position.PayloadID);
//            end;
//
//            if Payloads[Index].PredictionIndex > 0 then begin
//                Predictor.UpdatePayload(Payloads[Index].PredictionIndex,
//                                        Position.Latitude,
//                                        Position.Longitude,
//                                        Position.Altitude,
//                                        30000,      // Burst
//                                        Position.AscentRate,
//                                        5);
//            end;
//        end;
    end;
end;

procedure TfrmMain.SelectPayload(Sender: TObject);
begin
    if TWebLabel(Sender).Tag <> SelectedIndex then begin
        if Payloads[TWebLabel(Sender).Tag].Position.PayloadID <> '' then begin
            // Select payload
            SelectedIndex := TWebLabel(Sender).Tag;

            // Show selected payload on buttons
            lblPayload1.Font.Style := lblPayload1.Font.Style - [fsUnderline];
            lblPayload2.Font.Style := lblPayload2.Font.Style - [fsUnderline];
            lblPayload3.Font.Style := lblPayload3.Font.Style - [fsUnderline];

            TWebLabel(Sender).Font.Style := TWebLabel(Sender).Font.Style + [fsUnderline];

            // Update main screen
            ShowSelectedPayloadPosition;
        end;
    end;
end;

procedure TfrmMain.NewGPSPosition(Position: THABPosition);
const
    LastUpload: TDateTime = 0;
var
    INIFile: TMiletusINIFile;
    Callsign: String;
    Period: Integer;
begin
    if (Position.Longitude <> 0) or (Position.Latitude <> 0) or (Position.Altitude <> 0) then begin
        ShowSourceStatus(0, True, True, True);

        Car.Position := Position;
        Car.HasPosition := True;

        lblGPS.Caption := FormatDateTime('hh:nn:ss', Position.TimeStamp) + ' , ' +
                                  FormatFloat('0.00000', Position.Latitude) + ', ' +
                                  FormatFloat('0.00000', Position.Longitude) + ', ' +
                                  FormatFloat('0', Position.Altitude) + 'm, ' +
                                  IntToStr(Position.Satellites) + ' sats';

        lblGPSStatus.Font.Color := clGreen;

        WhereAreBalloons;

        frmMap.NewPosition(0, Position);

        frmDirection.NewPosition(0, Position);

        // Time for an upload ?
        INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');


        if await(Boolean, INIFile.ReadBool('Chase', 'Enabled', False)) then begin
            Callsign := await(String, INIFile.ReadString('Chase', 'Callsign', ''));
            Period := await(Integer, INIFile.ReadString('Chase', 'Period', ''));
            if (Period > 0) and (Now > (LastUpload + Period/86400)) and (Callsign <> '') then begin
                // Time for car uploads
                if await(Boolean, INIFile.ReadBool('Upload', 'HabLinkEnabled', False)) then begin
                    // Hablink upload
                    LastUpload := Now;
                    frmHABLink.SendGPSPosition(Callsign, Position);
                end;
                if await(Boolean, INIFile.ReadBool('Upload', 'HabitatEnabled', False)) then begin
                    // Habitat upload
                    LastUpload := Now;
                    frmHabitat.UploadCarPosition(Callsign, Car.Position);
                end;
            end;
        end;
        INIFile.Free;
    end else begin
        ShowSourceStatus(0, True, True, False);
    end;
end;

procedure TfrmMain.WhereIsBalloon(PayloadIndex: Integer);
begin
    if (Car.Position.Latitude <> 0) or (Car.Position.Longitude <> 0) then begin
        Payloads[PayloadIndex].Position.DirectionValid := True;
        // Horizontal distance to payload
        Payloads[PayloadIndex].Position.Distance := CalculateDistance(Car.Position.Latitude, Car.Position.Longitude,
                                                                      Payloads[PayloadIndex].Position.Latitude,
                                                                      Payloads[PayloadIndex].Position.Longitude);
        // Direction to payload
        Payloads[PayloadIndex].Position.Direction := CalculateDirection(Payloads[PayloadIndex].Position.Latitude,
                                                                       Payloads[PayloadIndex].Position.Longitude,
                                                                       Car.Position.Latitude, Car.Position.Longitude) -
                                                                       Car.Position.Direction;

        Payloads[PayloadIndex].Position.Elevation := CalculateElevation(Car.Position.Latitude, Car.Position.Longitude, Car.Position.Altitude,
                                                                        Payloads[PayloadIndex].Position.Latitude, Payloads[PayloadIndex].Position.Longitude, Payloads[PayloadIndex].Position.Altitude);


        if Payloads[PayloadIndex].Position.ContainsPrediction then begin
            // Horizontal distance to payload
            Payloads[PayloadIndex].Position.PredictionDistance := CalculateDistance(Car.Position.Latitude, Car.Position.Longitude,
                                                                                      Payloads[PayloadIndex].Position.PredictedLatitude,
                                                                                      Payloads[PayloadIndex].Position.PredictedLongitude);
            // Direction to payload
            Payloads[PayloadIndex].Position.PredictionDirection := CalculateDirection(Payloads[PayloadIndex].Position.PredictedLatitude,
                                                                                       Payloads[PayloadIndex].Position.PredictedLongitude,
                                                                                       Car.Position.Latitude, Car.Position.Longitude) -
                                                                                       Car.Position.Direction;
        end;
    end else begin
        Payloads[PayloadIndex].Position.DirectionValid := False;
    end;
end;

procedure TfrmMain.tmrBleepTimer(Sender: TObject);
begin
    if tmrBleep.Tag > 0 then begin
        if tmrBleep.Tag = 1 then begin
            // MessageBeep(MB_OK);
            MiletusShell.Beep;
        end else if tmrBleep.Tag = 2 then begin
            // MessageBeep(MB_ICONERROR);
            MiletusShell.Beep;
        end else begin
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
    for PayloadIndex := Low(Payloads) to High(Payloads) do begin
        WhereIsBalloon(PayloadIndex);
    end;
end;


procedure TfrmMain.ShowTargetStatus(TargetID: Integer; Enabled, Connected: Boolean);
begin
    if (TargetID >= Low(Targets)) and (TargetID <= High(Targets)) then begin
        if Enabled then begin
            if Connected then begin
                Targets[TargetID].Color := $006FDFF1;
            end else begin
                Targets[TargetID].Color := clRed;
                Targets[TargetID].Font.Color := clBlack;
            end;
        end else begin
            Targets[TargetID].Color := $004E9CA9;
            Targets[TargetID].Font.Color := clBlack;
        end;
    end;
end;




initialization

RegisterClass(TfrmMain);

end.
