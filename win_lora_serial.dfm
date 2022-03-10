inherited frmWinLoRaSerial: TfrmWinLoRaSerial
  inherited lblPosition: TWebLabel
    Caption = 'Click to open port'
    OnClick = lblPositionClick
    ExplicitWidth = 165
  end
  inherited lblStatus: TWebLabel
    Caption = 'Click to open USB GPS Serial Port'
    OnClick = lblStatusClick
  end
  object WebUSBSerial1: TWebUSBSerial
    Filters = <>
    OnReadData = WebUSBSerial1ReadData
    OnOpenPort = WebUSBSerial1OpenPort
    OnConnected = WebUSBSerial1Connected
    Left = 552
    Top = 16
  end
end
