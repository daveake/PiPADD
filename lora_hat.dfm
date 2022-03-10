inherited frmLoRaHAT: TfrmLoRaHAT
  Height = 195
  Caption = 'LoRa'
  ClientHeight = 156
  inherited lblPosition: TWebLabel
    Top = 33
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    ExplicitTop = 33
    ExplicitWidth = 661
    ExplicitHeight = 24
  end
  inherited lblSource: TWebLabel
    Caption = #160'LoRa CE0'
  end
  object lblStatus2: TWebLabel
    AlignWithMargins = True
    Left = 128
    Top = 70
    Width = 547
    Height = 24
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Color = 7331825
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object WebLabel2: TWebLabel
    AlignWithMargins = True
    Left = 0
    Top = 70
    Width = 129
    Height = 24
    Margins.Left = 12
    Margins.Right = 2
    Margins.Bottom = 2
    AutoSize = False
    Caption = #160'LoRa CE1'
    Color = 7331825
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblPosition2: TWebLabel
    AlignWithMargins = True
    Left = 8
    Top = 102
    Width = 661
    Height = 27
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
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
  object CE0: TMiletusRaspberrySPI
    OnOpen = SPIOpen
    Left = 176
    Top = 78
  end
  object tmrPoll: TWebTimer
    Enabled = False
    OnTimer = tmrPollTimer
    Left = 547
    Top = 88
  end
  object CE1: TMiletusRaspberrySPI
    Tag = 1
    PortNum = spi1
    OnOpen = SPIOpen
    Left = 248
    Top = 78
  end
end
