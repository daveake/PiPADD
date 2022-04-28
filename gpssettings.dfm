inherited frmGPSSettings: TfrmGPSSettings
  inherited pnlSettings: TWebPanel
    Height = 109
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 663
    ExplicitHeight = 109
    object WebLabel1: TWebLabel
      Left = 20
      Top = 59
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
      Left = 451
      Top = 62
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
    object WebLabel3: TWebLabel
      Left = 35
      Top = 12
      Width = 126
      Height = 32
      Alignment = taRightJustify
      Caption = 'GPS Device:'
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
      Top = 56
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
      Left = 474
      Top = 10
      Width = 167
      Height = 40
      Caption = 'Enable upload'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClick
    end
    object edtPeriod: TWebEdit
      Left = 560
      Top = 59
      Width = 81
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
    object edtDevice: TWebEdit
      Left = 176
      Top = 9
      Width = 281
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
  inherited pnlButtons: TWebPanel
    Top = 112
    ExplicitTop = 125
  end
  inherited pnlNotes: TWebPanel
    Top = 161
    Height = 226
    ExplicitLeft = 0
    ExplicitTop = 174
    ExplicitWidth = 663
    ExplicitHeight = 213
    inherited WebMemo1: TWebMemo
      Height = 220
      Lines.Strings = (
        
          '"GPS Device" defaults to Pi serial pot.  Fill in if using USB GP' +
          'S.'
        
          '"Enable Upload" enables uploading of your position to Habitat, w' +
          'here it will '
        'appear as a chase car icon.'
        
          '"Chase Car ID" is the label used for that icon.  "_chase" is aut' +
          'omatically '
        'appended so you don'#39't need to include that yourself.'
        
          '"Period" is the time, in seconds, between position updates to Ha' +
          'bitat.')
      SelStart = 379
      ExplicitWidth = 657
      ExplicitHeight = 207
    end
  end
end
