inherited frmLoRaUSBSettings: TfrmLoRaUSBSettings
  inherited pnlSettings: TWebPanel
    Height = 166
    ExplicitHeight = 166
    object WebLabel1: TWebLabel
      Left = 72
      Top = 16
      Width = 49
      Height = 21
      Alignment = taRightJustify
      Caption = 'Device:'
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
      Left = 46
      Top = 66
      Width = 75
      Height = 21
      Alignment = taRightJustify
      Caption = 'Frequency:'
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
    object edtFrequency: TWebEdit
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
      OnChange = edtDeviceChange
    end
    object btnAFC: TWebButton
      AlignWithMargins = True
      Left = 316
      Top = 63
      Width = 89
      Height = 32
      Caption = 'AFC'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object btnLess: TWebButton
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
      OnClick = btnLessClick
    end
    object btnMore: TWebButton
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
      OnClick = btnMoreClick
    end
    object btnMode: TWebEdit
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
      OnClick = btnUploadClick
    end
    object edtDevice: TWebEdit
      Left = 136
      Top = 13
      Width = 265
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
      OnChange = edtDeviceChange
    end
    object btnUpload: TWebButton
      AlignWithMargins = True
      Left = 64
      Top = 109
      Width = 265
      Height = 44
      Caption = 'Enable Telemetry Upload'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnUploadClick
    end
  end
  inherited pnlButtons: TWebPanel
    Top = 175
    ExplicitTop = 175
  end
  inherited pnlNotes: TWebPanel
    Top = 227
    Height = 157
    ExplicitTop = 227
    ExplicitHeight = 157
    inherited WebMemo1: TWebMemo
      Height = 151
      Lines.Strings = (
        'Choose the serial device.'
        
          'Set the frequency and mode to match your payload.  These setting' +
          's are sent '
        'to the attached receiver after you touch Apply.'
        
          'The Enable buttons enable uploading telemetry/SSDV from this dev' +
          'ice to '
        'Habitat.')
      SelStart = 236
      ExplicitHeight = 151
    end
  end
end
