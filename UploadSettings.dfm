inherited frmUploadSettings: TfrmUploadSettings
  inherited pnlSettings: TWebPanel
    Height = 86
    ExplicitHeight = 86
    object btnHabitat: TWebButton
      AlignWithMargins = True
      Left = 16
      Top = 20
      Width = 189
      Height = 50
      Caption = 'Habitat'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnSSDVClick
    end
    object btnHabLink: TWebButton
      AlignWithMargins = True
      Left = 228
      Top = 20
      Width = 189
      Height = 50
      Caption = 'HAB.LINK'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnSSDVClick
    end
    object btnSSDV: TWebButton
      AlignWithMargins = True
      Left = 444
      Top = 20
      Width = 189
      Height = 50
      Caption = 'SSDV'
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnSSDVClick
    end
  end
  inherited pnlButtons: TWebPanel
    Top = 95
    ExplicitTop = 95
  end
  inherited pnlNotes: TWebPanel
    Top = 147
    Height = 237
    ExplicitTop = 147
    ExplicitHeight = 237
    inherited WebMemo1: TWebMemo
      Height = 231
      Lines.Strings = (
        'Enable whichever upload options you wish.')
      SelStart = 43
      ExplicitHeight = 231
    end
  end
end
