inherited frmPiGPS: TfrmPiGPS
  Width = 697
  Height = 169
  ClientHeight = 130
  ClientWidth = 681
  inherited lblPosition: TWebLabel
    Width = 675
    Height = 86
    ExplicitWidth = 675
    ExplicitHeight = 104
  end
  inherited lblSource: TWebLabel
    Width = 675
    ExplicitWidth = 675
  end
  inherited lblStatus: TWebLabel
    Width = 675
    ExplicitWidth = 675
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
