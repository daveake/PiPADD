unit settingsbase;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Miletus, WEBLib.Dialogs, base, Vcl.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmSettingsBase = class(TfrmBase)
    pnlSettings: TWebPanel;
    pnlButtons: TWebPanel;
    pnlNotes: TWebPanel;
    btnCancel: TWebButton;
    btnSave: TWebButton;
    WebMemo1: TWebMemo;
    procedure MiletusFormResize(Sender: TObject);
    procedure MiletusFormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure EnableSettingsButton(Button: TWebButton; Enabled: Boolean);
    procedure SettingsHaveChanged;
    procedure ToggleButton(Button: TWebButton);
    function SettingsButtonToBoolean(Button: TWebButton): Boolean;
    procedure SetSettingsButtonFromBoolean(Button: TWebButton; Value: Boolean);

    [async]
    procedure LoadSettings; virtual;
    procedure SaveSettings; virtual;
  public
    { Public declarations }
    procedure AfterShow; override;
  end;

implementation

{$R *.dfm}

procedure TfrmSettingsBase.MiletusFormCreate(Sender: TObject);
begin
    inherited;

    pnlSettings.ElementClassName := 'RoundedCorners';
    pnlNotes.ElementClassName := 'RoundedCorners';

end;

procedure TfrmSettingsBase.btnCancelClick(Sender: TObject);
begin
    LoadSettings;
end;

procedure TfrmSettingsBase.btnSaveClick(Sender: TObject);
begin
    SaveSettings;

    EnableSettingsButton(btnSave, False);
    EnableSettingsButton(btnCancel, False);
end;

procedure TfrmSettingsBase.EnableSettingsButton(Button: TWebButton; Enabled: Boolean);
begin
    if Enabled then begin
        Button.ElementClassName := 'PushButtonOn';
    end else begin
        Button.ElementClassName := 'PushButtonOff';
    end;
end;

procedure TfrmSettingsBase.SettingsHaveChanged;
begin
    EnableSettingsButton(btnSave, True);
    EnableSettingsButton(btnCancel, True);
end;


procedure TfrmSettingsBase.ToggleButton(Button: TWebButton);
begin
    if Button.ElementClassName = 'BooleanButtonOff' then begin
        Button.ElementClassName := 'BooleanButtonOn';
    end else begin
        Button.ElementClassName := 'BooleanButtonOff';
    end;

    SettingsHaveChanged;
end;

procedure TfrmSettingsBase.MiletusFormResize(Sender: TObject);
begin
    inherited;
    //
end;

procedure TfrmSettingsBase.SaveSettings;
begin
    inherited;
    //
end;

procedure TfrmSettingsBase.LoadSettings;
begin
    EnableSettingsButton(btnSave, False);
    EnableSettingsButton(btnCancel, False);
end;

function TfrmSettingsBase.SettingsButtonToBoolean(Button: TWebButton): Boolean;
begin
    Result := Button.ElementClassName = 'BooleanButtonOn';
end;

procedure TfrmSettingsBase.SetSettingsButtonFromBoolean(Button: TWebButton; Value: Boolean);
begin
    if Value then begin
        Button.ElementClassName := 'BooleanButtonOn';
    end else begin
        Button.ElementClassName := 'BooleanButtonOff';
    end;
end;

procedure TfrmSettingsBase.AfterShow;
begin
    inherited;

    LoadSettings;
end;

initialization
  RegisterClass(TfrmSettingsBase);

end.