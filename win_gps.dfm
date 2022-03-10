inherited frmWinGPS: TfrmWinGPS
  Height = 229
  ClientHeight = 190
  inherited lblPosition: TWebLabel
    Top = 41
    Width = 661
    Height = 142
    Caption = 'Click to open port'
    OnClick = lblPositionClick
    ExplicitTop = 41
    ExplicitHeight = 142
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
