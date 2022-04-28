inherited frmLoRaSerial: TfrmLoRaSerial
  inherited lblPosition: TWebLabel
    Height = 23
    ExplicitHeight = 23
  end
  inherited lblSource: TWebLabel
    Caption = #160'LoRa Serial'
  end
  object lblGPS: TWebLabel
    AlignWithMargins = True
    Left = 0
    Top = 51
    Width = 675
    Height = 23
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WordWrap = True
    WidthPercent = 100.000000000000000000
  end
  object lstCommands: TWebListBox
    Left = 492
    Top = 36
    Width = 65
    Height = 61
    HeightPercent = 100.000000000000000000
    ItemHeight = 30
    ItemIndex = -1
    Visible = False
    WidthPercent = 100.000000000000000000
  end
  object tmrCommands: TWebTimer
    Interval = 300
    OnTimer = tmrCommandsTimer
    Left = 332
    Top = 64
  end
end
