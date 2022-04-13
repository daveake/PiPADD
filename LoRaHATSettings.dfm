inherited frmLoRaHATSettings: TfrmLoRaHATSettings
  inherited pnlSettings: TWebPanel
    Height = 162
    ExplicitHeight = 162
    object WebLabel1: TWebLabel
      Left = 14
      Top = 16
      Width = 107
      Height = 21
      Alignment = taRightJustify
      Caption = 'Ch0 Frequency:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object WebLabel3: TWebLabel
      Left = 416
      Top = 16
      Width = 40
      Height = 21
      Alignment = taRightJustify
      Caption = 'Mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object WebLabel2: TWebLabel
      Left = 14
      Top = 66
      Width = 107
      Height = 21
      Alignment = taRightJustify
      Caption = 'Ch1 Frequency:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object WebLabel4: TWebLabel
      Left = 416
      Top = 66
      Width = 40
      Height = 21
      Alignment = taRightJustify
      Caption = 'Mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object edtFrequency0: TWebEdit
      Left = 136
      Top = 13
      Width = 167
      Height = 32
      ChildOrder = 1
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
    object btnAFC0: TWebButton
      AlignWithMargins = True
      Left = 316
      Top = 13
      Width = 89
      Height = 32
      Caption = 'AFC'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClicked
    end
    object btnLess0: TWebButton
      AlignWithMargins = True
      Left = 463
      Top = 13
      Width = 66
      Height = 32
      Caption = '<'
      ChildOrder = 1
      ElementClassName = 'SettingsButton'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnLess0Click
    end
    object btnMode0: TWebEdit
      Left = 535
      Top = 13
      Width = 33
      Height = 32
      ChildOrder = 1
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
    object btnMore0: TWebButton
      AlignWithMargins = True
      Left = 574
      Top = 13
      Width = 66
      Height = 32
      Caption = '>'
      ChildOrder = 1
      ElementClassName = 'SettingsButton'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnMore0Click
    end
    object edtFrequency1: TWebEdit
      Left = 136
      Top = 63
      Width = 167
      Height = 32
      ChildOrder = 1
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
    object btnAFC1: TWebButton
      AlignWithMargins = True
      Left = 316
      Top = 63
      Width = 89
      Height = 32
      Caption = 'AFC'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClicked
    end
    object btnLess1: TWebButton
      AlignWithMargins = True
      Left = 463
      Top = 63
      Width = 66
      Height = 32
      Caption = '<'
      ChildOrder = 1
      ElementClassName = 'SettingsButton'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnLess1Click
    end
    object btnMode1: TWebEdit
      Left = 535
      Top = 63
      Width = 33
      Height = 32
      ChildOrder = 1
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      OnChange = TextChanged
    end
    object btnMore1: TWebButton
      AlignWithMargins = True
      Left = 574
      Top = 63
      Width = 66
      Height = 32
      Caption = '>'
      ChildOrder = 1
      ElementClassName = 'SettingsButton'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnMore1Click
    end
    object btnSSDV: TWebButton
      AlignWithMargins = True
      Left = 340
      Top = 109
      Width = 265
      Height = 44
      Caption = 'Enable SSDV Upload'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = ButtonClicked
    end
  end
  inherited pnlButtons: TWebPanel
    Top = 171
    ExplicitTop = 171
  end
  inherited pnlNotes: TWebPanel
    Top = 223
    Height = 161
    ExplicitTop = 223
    ExplicitHeight = 161
    inherited WebMemo1: TWebMemo
      Height = 155
      Lines.Strings = (
        
          'Set the frequency and mode to match your payload.  These setting' +
          's are sent '
        'to the attached receiver after you touch Apply.'
        
          'The Enable buttons enable uploading telemetry/SSDV from this dev' +
          'ice to '
        'Habitat.')
      SelStart = 209
      ExplicitHeight = 155
    end
  end
  object btnUpload: TWebButton
    AlignWithMargins = True
    Left = 64
    Top = 112
    Width = 265
    Height = 44
    Caption = 'Enable Telemetry Upload'
    ChildOrder = 1
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = ButtonClicked
  end
end
