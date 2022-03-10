inherited frmGPSSettings: TfrmGPSSettings
  inherited pnlSettings: TWebPanel
    object WebLabel1: TWebLabel
      Left = 20
      Top = 16
      Width = 141
      Height = 32
      Alignment = taRightJustify
      Caption = 'Chase Car ID:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object WebLabel2: TWebLabel
      Left = 58
      Top = 72
      Width = 103
      Height = 32
      Alignment = taRightJustify
      Caption = 'Period (s):'
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
      Left = 176
      Top = 13
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
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
    object btnUpload: TWebButton
      AlignWithMargins = True
      Left = 440
      Top = 34
      Width = 189
      Height = 50
      Caption = 'Enable upload'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClick
    end
    object edtPeriod: TWebEdit
      Left = 176
      Top = 69
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
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
  end
  inherited pnlNotes: TWebPanel
    inherited WebMemo1: TWebMemo
      Lines.Strings = (
        
          '"Enable Upload" enables uploading of your position to Habitat, w' +
          'here it will '
        'appear as a chase car icon.'
        
          '"Chase Car ID" is the label used for that icon.  "_chase" is aut' +
          'omatically '
        'appended so you don'#39't need to include that yourself.'
        
          '"Period" is the time, in seconds, between position updates to Ha' +
          'bitat.')
      SelStart = 311
    end
  end
end
