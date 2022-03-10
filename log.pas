unit log;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  WEBLib.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCListBox,
  WEBLib.WebCtrls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmLog = class(TfrmBase)
    pnlMain: TWebPanel;
    WebSpeechSynthesis1: TWebSpeechSynthesis;
    lstLog: TWebListBox;
    procedure MiletusFormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    [async]
    procedure AddMessage(PayloadID, Temp: String; Speak, Tweet: Boolean);
  end;

var
  frmLog: TfrmLog;

implementation

{$R *.dfm}

uses Main;

procedure TfrmLog.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmLog.AddMessage(PayloadID, Temp: String; Speak, Tweet: Boolean);
var
    Speech, Msg, TimedMsg: String;
    INIFile: TMiletusINIFile;
begin
    if PayloadID = '' then begin
        Msg := Temp;
        Speech := Msg;
    end else begin
        Msg := PayloadID + ' - ' + Temp;
        // Speech := SpellOut(PayloadID) + Temp;
        Speech := PayloadID + ' ' + Temp;
    end;

    TimedMsg := formatDateTime('hh:nn:ss', Now) + ': ' + Msg;

    lstLog.Items.Add(TimedMsg);

    // Text to speech, for Android
    if Speak then begin
        try
            INIFile := TMiletusIniFile.Create(ParamStr(0) + '.INI');
            Speak := await(Boolean, INIFile.ReadBool('General', 'Speech', False));
            INIFile.Free;
        except
            Speak := False;
        end;

        if Speak then begin
            // lstSpeech.Items.Add(Speech);
            if frmMain.IsRaspberryPi then begin
                MiletusShell.Execute('espeak -a 200 -s 150 "' + Speech + '"');
            end else begin
                WebSpeechSynthesis1.Speak(Speech);
            end;
        end;
    end;
end;
initialization
  RegisterClass(TfrmLog);

end.