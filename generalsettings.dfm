inherited frmGeneralSettings: TfrmGeneralSettings
  inherited pnlSettings: TWebPanel
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 663
    object WebLabel1: TWebLabel
      Left = 151
      Top = 12
      Width = 142
      Height = 32
      Alignment = taRightJustify
      Caption = 'Your Callsign:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object edtCallsign: TWebEdit
      Left = 308
      Top = 9
      Width = 167
      Height = 41
      ChildOrder = 1
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      ShowFocus = False
      SpellCheck = False
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
    object btnPositionBeeps: TWebButton
      AlignWithMargins = True
      Left = 20
      Top = 56
      Width = 189
      Height = 50
      Caption = 'Position Beeps'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClick
    end
    object btnAlarmBeeps: TWebButton
      AlignWithMargins = True
      Left = 236
      Top = 56
      Width = 189
      Height = 50
      Caption = 'Alarm Beeps'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClick
    end
    object btnSpeech: TWebButton
      AlignWithMargins = True
      Left = 448
      Top = 56
      Width = 189
      Height = 50
      Caption = 'Speech'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClick
    end
  end
  inherited pnlButtons: TWebPanel
    ExplicitTop = 125
  end
  inherited pnlNotes: TWebPanel
    ExplicitLeft = 0
    ExplicitTop = 174
    ExplicitWidth = 663
    ExplicitHeight = 213
    inherited WebMemo1: TWebMemo
      Font.Height = -16
      Lines.Strings = (
        
          '"Your Callsign" is used for uploading telemetry that has been di' +
          'rectly received by this '
        'program.'
        
          '"Position Beeps" enables a short speaker beep for every incoming' +
          ' telemetry position.'
        '"Alarm Beeps" enables beeps for alarms such as Signal Loss.'
        
          '"Speech" enables text-to-speech for log entries.  Works on Andro' +
          'id only.')
      SelStart = 321
      ExplicitWidth = 657
      ExplicitHeight = 207
    end
  end
end
