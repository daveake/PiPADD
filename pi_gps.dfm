inherited frmPiGPS: TfrmPiGPS
  Height = 169
  ClientHeight = 130
  inherited lblPosition: TWebLabel
    Width = 670
    Height = 86
    ExplicitWidth = 670
    ExplicitHeight = 104
  end
  object MiletusRaspberryUART1: TMiletusRaspberryUART
    PortNum = firstPL011
    OnClose = MiletusRaspberryUART1Close
    OnOpen = MiletusRaspberryUART1Open
    Left = 104
    Top = 20
  end
  object tmrPoll: TWebTimer
    Enabled = False
    OnTimer = tmrPollTimer
    Left = 232
    Top = 21
  end
  object tmrTimeout: TWebTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrTimeoutTimer
    Left = 352
    Top = 28
  end
end
