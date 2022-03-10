unit lora;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, source, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls;

type
    TLoRaSettings = record
        Frequency:  Double;
        Mode:       Integer;
        AFC:        Boolean;
    end;

type
  TfrmLoRa = class(TfrmSource)
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    LoRaSettings: Array[0..1] of TLoRaSettings;
    SourceOffset: Integer;
    procedure ProcessTelemetry(Channel: Integer; Sentence: STring);
    procedure ShowPosition(Channel: Integer; Msg: String); virtual;
  public
    { Public declarations }
    procedure SetFrequency(Channel: Integer; Frequency: Double); virtual;
    procedure SetMode(Channel, Mode: Integer); virtual;
    procedure ProgramDeviceFromSettings(Channel: Integer); virtual;
    procedure ProgramDevicesFromSettings; virtual;
    [async]
    procedure LoadSettings;
  end;


implementation

{$R *.dfm}

uses Main, misc;

procedure TfrmLoRa.SetFrequency(Channel: Integer; Frequency: Double);
begin
    // virtual
end;

procedure TfrmLoRa.SetMode(Channel, Mode: Integer);
begin
    // virtual
end;

procedure TfrmLoRa.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    LoadSettings;
end;

procedure TfrmLoRa.ProcessTelemetry(Channel: Integer; Sentence: STring);
var
    Position: THABPosition;
begin
    ShowPosition(Channel, Sentence);
    Position := DecodePosition(Sentence);
    frmMain.NewPosition(Channel+SourceOffset, Position);
end;

procedure TfrmLoRa.LoadSettings;
var
    INIFile: TMiletusINIFile;
begin
    INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
    try
        LoRaSettings[0].Frequency := StrToFloat(await(String, INIFile.ReadString('LoRaHAT', 'Frequency0', '869.850')));
        LoRaSettings[0].Mode := StrToIntDef(await(String, INIFile.ReadString('LoRaHAT', 'Mode0', '1')), 1);
        LoRaSettings[0].AFC := await(Boolean, INIFile.ReadBool('LoRaHAT', 'AFC0', False));

        LoRaSettings[1].Frequency := StrToFloat(await(String, INIFile.ReadString('LoRaHAT', 'Frequency1', '434.250')));
        LoRaSettings[1].Mode := StrToIntDef(await(String, INIFile.ReadString('LoRaHAT', 'Mode1', '1')), 1);
        LoRaSettings[1].AFC := await(Boolean, INIFile.ReadBool('LoRaHAT', 'AFC1', False));
    finally
        INIFile.Free;
    end;
end;

procedure TfrmLoRa.ProgramDevicesFromSettings;
begin
    // virtual
end;

procedure TfrmLoRa.ProgramDeviceFromSettings(Channel: Integer);
begin
	SetFrequency(Channel, LoRaSettings[Channel].Frequency);

	SetMode(Channel, LoRaSettings[Channel].Mode);
end;

procedure TfrmLoRa.ShowPosition(Channel: Integer; Msg: String);
begin
    lblPosition.Caption := Msg;
end;

initialization
  RegisterClass(TfrmLoRa);

end.