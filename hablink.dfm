inherited frmHABLink: TfrmHABLink
  OnCreate = MiletusFormCreate
  inherited lblSource: TWebLabel
    Caption = #160'hab.link'
    ExplicitWidth = 54
  end
  object WebSocketClient1: TWebSocketClient
    OnConnect = WebSocketClient1Connect
    OnDisconnect = WebSocketClient1Disconnect
    OnDataReceived = WebSocketClient1DataReceived
    Left = 110
    Top = 90
  end
  object tmrCheckConnection: TWebTimer
    OnTimer = tmrCheckConnectionTimer
    Left = 316
    Top = 90
  end
end
