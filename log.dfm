inherited frmLog: TfrmLog
  object pnlMain: TWebPanel
    AlignWithMargins = True
    Left = 6
    Top = 3
    Width = 657
    Height = 381
    Margins.Left = 6
    Margins.Right = 0
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    Align = alClient
    BorderColor = clYellow
    BorderStyle = bsSingle
    Color = clBlack
    object lstLog: TWebListBox
      Left = 0
      Top = 0
      Width = 657
      Height = 381
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ItemHeight = 30
      ItemIndex = -1
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
  end
  object WebSpeechSynthesis1: TWebSpeechSynthesis
    Left = 560
    Top = 307
  end
end
