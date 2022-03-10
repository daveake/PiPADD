inherited frmInternetSettings: TfrmInternetSettings
  inherited pnlSettings: TWebPanel
    object WebLabel1: TWebLabel
      Left = 51
      Top = 16
      Width = 110
      Height = 32
      Alignment = taRightJustify
      Caption = 'White List:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object edtWhiteList: TWebEdit
      Left = 176
      Top = 13
      Width = 457
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
    object btnHabitat: TWebButton
      AlignWithMargins = True
      Left = 176
      Top = 68
      Width = 189
      Height = 42
      Caption = 'Habitat'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = buttonClicked
    end
    object btnHabLink: TWebButton
      AlignWithMargins = True
      Left = 444
      Top = 68
      Width = 189
      Height = 42
      Caption = 'Hablink'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = buttonClicked
    end
  end
  inherited pnlNotes: TWebPanel
    inherited WebMemo1: TWebMemo
      Lines.Strings = (
        
          '"White List" adds these payload IDs (comma-separated if more tha' +
          'n one) to '
        
          'the Habitat/Hablink downloads, so you can chase payloads that yo' +
          'u aren'#39't '
        'receiving from directly, or to fill in missing telemetry.'
        'Enable for HABHUB/HABLINK as required.')
      SelStart = 250
    end
  end
end
