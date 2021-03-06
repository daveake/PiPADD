unit gps;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, source, Vcl.Controls,
  Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmGPS = class(TfrmSource)
    procedure MiletusFormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ProcessLine(Line: String);
    procedure SendCommand(Command: TBytes); virtual;
  public
    { Public declarations }
  end;

var
  frmGPS: TfrmGPS;

implementation

{$R *.dfm}

uses Main, misc;

const
	DisableGLL: TBytes = ($B5, $62, $06, $01, $08, $00, $F0, $01, $00, $00, $00, $00, $00, $01, $01, $2B);
    DisableGSA: TBytes = ($B5, $62, $06, $01, $08, $00, $F0, $02, $00, $00, $00, $00, $00, $01, $02, $32);
	DisableGSV: TBytes = ($B5, $62, $06, $01, $08, $00, $F0, $03, $00, $00, $00, $00, $00, $01, $03, $39);
    DisableRMC: TBytes = ($B5, $62, $06, $01, $08, $00, $F0, $04, $00, $00, $00, $00, $00, $01, $04, $40);
	DisableVTG: TBytes = ($B5, $62, $06, $01, $08, $00, $F0, $05, $00, $00, $00, $00, $00, $01, $05, $47);


procedure TfrmGPS.SendCommand(Command: TBytes);
begin
    // virtual
end;

procedure TfrmGPS.MiletusFormCreate(Sender: TObject);
begin
    inherited;
    SettingsPageIndex := 1;
end;

procedure TfrmGPS.ProcessLine(Line: String);
begin
    try
        if Copy(Line, 4, 3) = 'GGA' then begin
            with HABPositions[GPS_SOURCE] do begin
                GetString(Line);        // Skip GPGGA

                TimeStamp := GetTime(Line);

                Latitude := FixPosition(GetFloat(Line));
                if GetString(Line) = 'S' then Latitude := -Latitude;

                Longitude := FixPosition(GetFloat(Line));
                if GetString(Line) = 'W' then Longitude := -Longitude;

                GetString(Line);
                Satellites := GetInteger(Line);

                GetString(Line);
                Altitude := GetFloat(Line);

                lblPosition.Caption := FormatDateTime('hh:nn:ss', TimeStamp) + ' , ' +
                              FormatFloat('0.00000', Latitude) + ', ' +
                              FormatFloat('0.00000', Longitude) + ', ' +
                              FormatFloat('0', Altitude) + 'm, ' +
                              IntToStr(Satellites) + ' sats';

                Updated := True;
            end;

            // frmMain.NewGPSPosition(Position);
        end else if Copy(Line, 4, 3) = 'GLL' then begin
            SendCommand(DisableGLL);
        end else if Copy(Line, 4, 3) = 'GSA' then begin
            SendCommand(DisableGSA);
        end else if Copy(Line, 4, 3) = 'GSV' then begin
            SendCommand(DisableGSV);
        end else if Copy(Line, 4, 3) = 'RMC' then begin
            SendCommand(DisableRMC);
        end else if Copy(Line, 4, 3) = 'VTG' then begin
            SendCommand(DisableVTG);
        end;

    finally
        //
    end;
end;

initialization
  RegisterClass(TfrmGPS);

end.