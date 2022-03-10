unit lora_hat;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, lora, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls, WEBLib.MiletusRaspi;

type
    TPacket = record
        HasPosition:    Boolean;
        BadCRC:         Boolean;
        Sentence:       String;
        RSSI:           Integer;
    end;

type
  TfrmLoRaHAT = class(TfrmLoRa)
    CE0: TMiletusRaspberrySPI;
    tmrPoll: TWebTimer;
    CE1: TMiletusRaspberrySPI;
    lblStatus2: TWebLabel;
    WebLabel2: TWebLabel;
    lblPosition2: TWebLabel;
    [async] procedure tmrPollTimer(Sender: TObject);
    [async] procedure SPIOpen(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
    procedure MiletusFormResize(Sender: TObject);
  private
    { Private declarations }
	PayloadLength: Integer;
    Devices: Array[0..1] of TMiletusRaspberrySPI;
    ChannelIsOpen: Array[0..1] of Boolean;
    Status: Array[0..1] of TWebLabel;
  protected
    procedure ProgramDeviceFromSettings(Channel: Integer); override;
    procedure ProgramDevicesFromSettings; override;
    procedure ShowPosition(Channel: Integer; Msg: String); override;
  public
    { Public declarations }
    procedure SetFrequency(Channel: Integer; Frequency: Double); override;
    procedure SetMode(Channel, Mode: Integer); override;

    [async] function ReadRegister(Channel, Reg: Integer): Integer;
    procedure WriteRegister(Channel, Reg, Value: Integer);
    [async] procedure SetLoRaParameters(Channel: Integer; ImplicitOrExplicit, ErrorCoding, Bandwidth, SpreadingFactor, LowDataRateOptimize: Byte);
    [async] function GotPacket(Channel: Integer): Boolean;
    [async] function GetPacket(Channel: Integer): TPacket;
    [async] function SetDeviceMode(Channel, Mode: Integer): TJSPromise;
    [async] procedure Listen(Channel: Integer);
    procedure AfterLoad; override;
  end;

var
  frmLoRaHAT: TfrmLoRaHAT;

const
	REG_FIFO					= $00;
	REG_FIFO_ADDR_PTR			= $0D;
	REG_FIFO_TX_BASE_AD        = $0E;
	REG_FIFO_RX_BASE_AD        = $0F;
	REG_RX_NB_BYTES            = $13;
	REG_OPMODE                 = $01;
	REG_FIFO_RX_CURRENT_ADDR   = $10;
	REG_IRQ_FLAGS              = $12;
	REG_PACKET_SNR				= $19;
	REG_PACKET_RSSI				= $1A;
	REG_CURRENT_RSSI			= $1B;
	REG_DIO_MAPPING_1          = $40;
	REG_DIO_MAPPING_2          = $41;
	REG_MODEM_CONFIG           = $1D;
	REG_MODEM_CONFIG2          = $1E;
	REG_MODEM_CONFIG3          = $26;
	REG_PAYLOAD_LENGTH         = $22;
	REG_IRQ_FLAGS_MASK         = $11;
	REG_HOP_PERIOD             = $24;
	REG_FREQ_ERROR				= $28;
	REG_DETECT_OPT				= $31;
	REG_DETECTION_THRESHOLD		= $37;

	// MODES
	RF98_MODE_RX_CONTINUOUS    = $85;
	RF98_MODE_TX               = $83;
	RF98_MODE_SLEEP            = $80;
	RF98_MODE_STANDBY          = $81;

	// Modem Config 1
	EXPLICIT_MODE              = $00;
	IMPLICIT_MODE              = $01;

	ERROR_CODING_4_5           = $02;
	ERROR_CODING_4_6           = $04;
	ERROR_CODING_4_7           = $06;
	ERROR_CODING_4_8           = $08;

	BANDWIDTH_7K8              = $00;
	BANDWIDTH_10K4             = $10;
	BANDWIDTH_15K6             = $20;
	BANDWIDTH_20K8             = $30;
	BANDWIDTH_31K25            = $40;
	BANDWIDTH_41K7             = $50;
	BANDWIDTH_62K5             = $60;
	BANDWIDTH_125K             = $70;
	BANDWIDTH_250K             = $80;
	BANDWIDTH_500K             = $90;

	// Modem Config 2

	SPREADING_6                = $60;
	SPREADING_7                = $70;
	SPREADING_8                = $80;
	SPREADING_9                = $90;
	SPREADING_10               = $A0;
	SPREADING_11               = $B0;
	SPREADING_12               = $C0;

	CRC_OFF                    = $00;
	CRC_ON                     = $04;

	// POWER AMPLIFIER CONFIG
	REG_PA_CONFIG              = $09;
	PA_MAX_BOOST               = $8F;
	PA_LOW_BOOST               = $81;
	PA_MED_BOOST               = $8A;
	PA_MAX_UK                  = $88;
	PA_OFF_BOOST               = $00;
	RFO_MIN                    = $00;

	// LOW NOISE AMPLIFIER
	REG_LNA                    = $0C;
	LNA_MAX_GAIN               = $23;
	LNA_OFF_GAIN               = $00;
	LNA_LOW_GAIN               = $C0;

implementation

{$R *.dfm}

uses Main, misc;

procedure TfrmLoRaHAT.AfterLoad;
begin
    inherited;

    lblStatus.Caption := 'Opening SPI CE0';
    lblStatus2.Caption := 'Opening SPI CE1';

    CE0.Open;
    CE1.Open;
end;

procedure TfrmLoRaHAT.SPIOpen(Sender: TObject);
var
    Channel, Value: Integer;
begin
    Channel := TMiletusRaspberrySPI(Sender).Tag;

    if await(Integer, ReadRegister(Channel, REG_OPMODE)) <> 0 then begin
        Status[Channel].Caption := 'LoRa CE' + IntToStr(Channel) + ' Opened';

	    // DIO Mapping
    	WriteRegister(Channel, REG_DIO_MAPPING_2, $00);

        ProgramDeviceFromSettings(Channel);

        ChannelIsOpen[Channel] := True;

        frmMain.ShowSourceStatus(Channel+SourceOffset, True, True, False);

        tmrPoll.Enabled := True;
    end else begin
        Devices[Channel].Close;

        ChannelIsOpen[Channel] := False;

        Status[Channel].Caption := 'LoRa CE' + IntToStr(Channel) + ' Missing';

        frmMain.ShowSourceStatus(Channel+SourceOffset, False, False, False);
    end;
end;

function TfrmLoRaHAT.ReadRegister(Channel, Reg: Integer): Integer;
var
    Buffer: TBytes;
begin
    SetLength(Buffer, 1);

    Buffer[0] := Reg;
  	await(Boolean, Devices[Channel].ReadTransfer(Buffer, 1, 1));
    Result := Buffer[0];

    Buffer := nil;
end;

procedure TfrmLoRaHAT.WriteRegister(Channel, Reg, Value: Integer);
var
    Buffer: TBytes;
begin
    SetLength(Buffer, 2);

    Buffer[0] := Reg or $80;
    Buffer[1] := Value;
  	Devices[Channel].WriteTransfer(Buffer, 2);

    Buffer := nil;
end;

function TfrmLoRaHAT.SetDeviceMode(Channel, Mode: Integer): TJSPromise;
const
    CurrentMode: Byte = 0;
begin
	if Mode <> CurrentMode then begin
		if Mode = RF98_MODE_TX then begin
			// TURN LNA OFF FOR TRANSMIT
        	WriteRegister(Channel, REG_LNA, LNA_OFF_GAIN);

			// Set 10mW
        	WriteRegister(Channel, REG_PA_CONFIG, PA_MAX_UK);
		end else if Mode = RF98_MODE_RX_CONTINUOUS then begin
			// PA Off
			WriteRegister(Channel, REG_PA_CONFIG, PA_OFF_BOOST);

			// Max LNA Gain
			WriteRegister(Channel, REG_LNA, LNA_MAX_GAIN);

            // WebListBox1.ItemIndex := WebListBox1.Items.Add('Set listening mode');
		end;

		WriteRegister(Channel, REG_OPMODE, Mode);

		CurrentMode := Mode;

		// Sleep(10);
	end;
end;

procedure TfrmLoRaHAT.SetFrequency(Channel: Integer; Frequency: Double);
var
	FrequencyValue: LongInt;
begin
	SetDeviceMode(Channel, RF98_MODE_STANDBY);
	SetDeviceMode(Channel, RF98_MODE_SLEEP);
	WriteRegister(Channel, REG_OPMODE, $80);
	SetDeviceMode(Channel, RF98_MODE_STANDBY);

	FrequencyValue := Trunc((Frequency * 7110656) / 434);

    Status[Channel].Caption := 'CE' + IntToStr(Channel) + ': Set to ' + FormatFloat('0.00', Frequency) + ' MHz';

	WriteRegister(Channel, $06, (FrequencyValue shr 16) and $FF);
	WriteRegister(Channel, $07, (FrequencyValue shr 8) and $FF);
	WriteRegister(Channel, $08, FrequencyValue and $FF);
end;

procedure TfrmLoRaHAT.SetLoRaParameters(Channel: Integer; ImplicitOrExplicit, ErrorCoding, Bandwidth, SpreadingFactor, LowDataRateOptimize: Byte);
var
    Temp: Integer;
begin
	WriteRegister(Channel, REG_MODEM_CONFIG, ImplicitOrExplicit or ErrorCoding or Bandwidth);
	WriteRegister(Channel, REG_MODEM_CONFIG2, SpreadingFactor or CRC_ON);
	WriteRegister(Channel, REG_MODEM_CONFIG3, $04 or LowDataRateOptimize);

	if SpreadingFactor = SPREADING_6 then begin
		WriteRegister(Channel, REG_DETECTION_THRESHOLD, $0C);
		WriteRegister(Channel, REG_DETECT_OPT, (await(Integer, ReadRegister(Channel, REG_DETECT_OPT)) and $F8) or $05);
	end else begin
		WriteRegister(Channel, REG_DETECTION_THRESHOLD, $0A);
		WriteRegister(Channel, REG_DETECT_OPT, (await(Integer, ReadRegister(Channel, REG_DETECT_OPT)) and $F8) or $03);
	end;

	if ImplicitOrExplicit = IMPLICIT_MODE then begin
		PayloadLength := 255;
	end else begin
		PayloadLength := 0;
	end;

	WriteRegister(Channel, REG_PAYLOAD_LENGTH, PayloadLength);
	WriteRegister(Channel, REG_RX_NB_BYTES, PayloadLength);
end;

procedure TfrmLoRaHAT.SetMode(Channel, Mode: Integer);
begin
    Status[Channel].Caption := Status[Channel].Caption + ' Mode ' + IntToStr(Mode);

	if Mode = 0 then begin
		SetLoRaParameters(Channel, EXPLICIT_MODE, ERROR_CODING_4_8, BANDWIDTH_20K8, SPREADING_11, $08);
	end else if Mode = 1 then begin
		SetLoRaParameters(Channel, IMPLICIT_MODE, ERROR_CODING_4_5, BANDWIDTH_20K8, SPREADING_6, $00);
	end else if Mode = 2 then begin
		SetLoRaParameters(Channel, EXPLICIT_MODE, ERROR_CODING_4_8, BANDWIDTH_62K5, SPREADING_8, $00);
	end;
end;

procedure TfrmLoRaHAT.Listen(Channel: Integer);
begin
    // WriteRegister(REG_DIO_MAPPING_1, 0x00)  	# 00 00 00 00 maps DIO0 to RxDone

    WriteRegister(Channel, REG_PAYLOAD_LENGTH, 255);
    WriteRegister(Channel, REG_RX_NB_BYTES, 255);

	WriteRegister(Channel, REG_FIFO_RX_BASE_AD, 0);
	WriteRegister(Channel, REG_FIFO_ADDR_PTR, 0);

	// Setup Receive Continous Mode
	await(Integer, SetDeviceMode(Channel, RF98_MODE_RX_CONTINUOUS));

    Status[Channel].Caption := Status[Channel].Caption + ': Listening...';
end;

procedure TfrmLoRaHAT.MiletusFormCreate(Sender: TObject);
begin
    SourceOffset := CE0_SOURCE;

    Devices[0] := CE0;
    Devices[1] := CE1;

    Status[0] := lblStatus;
    Status[1] := lblStatus2;

    SettingsPageIndex := 2;

    inherited;
end;

procedure TfrmLoRaHAT.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

function TfrmLoRaHAT.GotPacket(Channel: Integer): Boolean;
begin
	Result := (await(Integer, ReadRegister(Channel, REG_IRQ_FLAGS)) and $40) <> 0;
end;

function TfrmLoRaHAT.GetPacket(Channel: Integer): TPacket;
var
    Status, CurrentAddress, ByteCount: Byte;
    i: Integer;
    Buffer: TBytes;
begin
    Result := default(TPacket);

    // Grab status register (CRC etc)
	Status := await(Integer, ReadRegister(Channel, REG_IRQ_FLAGS));

    // Clear RxDone
	WriteRegister(Channel, REG_IRQ_FLAGS, $40);

	// check for payload crc issues
	if (Status and $20 ) <> 0 then begin
		// reset the crc flags
		WriteRegister(Channel, REG_IRQ_FLAGS, $20);
        Result.BadCRC := True;
	end else begin
	    CurrentAddress := await(Integer, ReadRegister(Channel, REG_FIFO_RX_CURRENT_ADDR));
		ByteCount := await(Integer, ReadRegister(Channel, REG_RX_NB_BYTES));

		WriteRegister(Channel, REG_FIFO_ADDR_PTR, CurrentAddress);

        SetLength(Buffer, ByteCount);
        Buffer[0] := REG_FIFO;
      	await(Boolean, Devices[Channel].ReadTransfer(Buffer, 1, ByteCount));

		// Clear all flags
		WriteRegister(Channel, REG_IRQ_FLAGS, $FF);

        for i := 0 to ByteCount-1 do begin
            if Buffer[i] = 10 then begin
                Break;
            end else begin
                Result.Sentence := Result.Sentence + Char(Buffer[i]);
            end;
        end;

        Result.HasPosition := Copy(Result.Sentence, 1, 1) = '$';

        Buffer := nil;
    end;
end;

procedure TfrmLoRaHAT.tmrPollTimer(Sender: TObject);
var
    Channel: Integer;
    Line: String;
    Packet: TPacket;
begin
    for Channel := 0 to 1 do begin
        if ChannelIsOpen[Channel] then begin
            if await(Boolean, GotPacket(Channel)) then begin
                Packet := await(TPacket, GetPacket(Channel));
                if Packet.HasPosition then begin
                    ProcessTelemetry(Channel, Packet.Sentence);
                end else if Packet.BadCRC then begin
                    ShowPosition(Channel, 'Bad CRC');
                end;
            end;
        end;
    end;
end;

procedure TfrmLoRaHAT.ProgramDeviceFromSettings(Channel: Integer);
begin
    inherited;

    Listen(Channel);
end;

procedure TfrmLoRaHAT.ProgramDevicesFromSettings;
begin
    ProgramDeviceFromSettings(0);
    ProgramDeviceFromSettings(1);
end;

procedure TfrmLoRaHAT.ShowPosition(Channel: Integer; Msg: String);
begin
    if Channel = 1 then begin
        lblPosition2.Caption := Msg;
    end else begin
        inherited;
    end;
end;


initialization
  RegisterClass(TfrmLoRaHAT);

end.