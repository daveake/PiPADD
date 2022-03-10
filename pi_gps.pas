unit pi_gps;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, gps, WEBLib.MiletusRaspi,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls;

type
  TfrmPiGPS = class(TfrmGPS)
    MiletusRaspberryUART1: TMiletusRaspberryUART;
    tmrPoll: TWebTimer;
    tmrTimeout: TWebTimer;
    procedure MiletusRaspberryUART1Close(Sender: TObject);
    procedure MiletusRaspberryUART1Open(Sender: TObject);
    [async]
    procedure tmrPollTimer(Sender: TObject);
    procedure MiletusFormResize(Sender: TObject);
    procedure tmrTimeoutTimer(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SendCommand(Command: TBytes); override;
  public
    { Public declarations }
    procedure AfterLoad; override;
  end;

implementation

{$R *.dfm}

procedure TfrmPiGPS.AfterLoad;
begin
    try
        lblStatus.Caption := 'Open port ...';
        MiletusRaspberryUART1.Open;
    except
        lblStatus.Caption := 'Missing GPS Device';
    end;
end;

procedure TfrmPiGPS.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmPiGPS.MiletusRaspberryUART1Close(Sender: TObject);
begin
    tmrPoll.Enabled := False;
end;

procedure TfrmPiGPS.MiletusRaspberryUART1Open(Sender: TObject);
begin
    lblStatus.Caption := 'Port is open';

    tmrPoll.Enabled := True;
    tmrTimeout.Enabled := True;
end;

procedure TfrmPiGPS.SendCommand(Command: TBytes);
begin
    MiletusRaspberryUART1.WriteBuffer(Command, Length(Command));
end;

procedure TfrmPiGPS.tmrPollTimer(Sender: TObject);
const
    Line: String = '';
var
    Buffer: TBytes;
    i, AvailLength, ReadLength: Integer;
    StartTime: TDateTime;
begin
    StartTime := Now;
    tmrPoll.Enabled := False;

(*
    while await(Boolean, MiletusRaspberryUART1.CanRead(1)) do begin
        AvailLength := await(Integer, MiletusRaspberryUART1.WaitingData);

        // SetLength(Buffer, AvailLength);

        ReadLength := await(Integer, MiletusRaspberryUART1.ReadBuffer(Buffer, AvailLength));

        for i := 0 to ReadLength-1 do begin
            if Buffer[i] = Ord('$') then begin
                Line := '$';
            end else if Buffer[i] = 10 then begin
                ProcessLine(Line);
                Line := '';
                tmrTimeout.Enabled := False;
            end else begin
                Line := Line + Chr(Buffer[i]);
            end;
        end;

        // Buffer := nil;
    end;
*)

    repeat
        AvailLength := await(Integer, MiletusRaspberryUART1.WaitingData);
        if AvailLength > 0 then begin
            ReadLength := await(Integer, MiletusRaspberryUART1.ReadBuffer(Buffer, AvailLength));

            for i := 0 to ReadLength-1 do begin
                if Buffer[i] = Ord('$') then begin
                    Line := '$';
                end else if Buffer[i] = 10 then begin
                    ProcessLine(Line);
                    Line := '';
                    tmrTimeout.Enabled := False;
                end else begin
                    Line := Line + Chr(Buffer[i]);
                end;
            end;
        end;
    until AvailLength = 0;

    lblStatus.Caption := IntToStr(AvailLength) + ': ' + FormatDateTime('ss.zzz', Now - StartTime);


    tmrPoll.Enabled := True;
end;

procedure TfrmPiGPS.tmrTimeoutTimer(Sender: TObject);
begin
    lblStatus.Caption := 'No GPS Connected';
    MiletusRaspberryUART1.Close;
end;

initialization
  RegisterClass(TfrmPiGPS);

end.