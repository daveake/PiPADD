inherited frmPiLoRaSerial: TfrmPiLoRaSerial
  Height = 121
  ClientHeight = 82
  inherited lblPosition: TWebLabel
    Height = 56
    ExplicitHeight = 56
  end
  inherited lblSource: TWebLabel
    Caption = #160'LoRa USB'
  end
  inherited lblGPS: TWebLabel
    Top = 52
    ExplicitTop = 52
  end
  object MiletusRaspberryUART1: TMiletusRaspberryUART [6]
    BaudRate = 57600
    PortNum = firstPL011
    OnClose = MiletusRaspberryUART1Close
    OnOpen = MiletusRaspberryUART1Open
    Left = 104
    Top = 20
  end
  object tmrPoll: TWebTimer [7]
    Enabled = False
    Interval = 200
    OnTimer = tmrPollTimer
    Left = 232
    Top = 21
  end
  inherited tmrCommands: TWebTimer
    Left = 344
    Top = 40
  end
end
