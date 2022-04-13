inherited frmHabitat: TfrmHabitat
  Height = 132
  OnCreate = MiletusFormCreate
  ClientHeight = 93
  inherited lblPosition: TWebLabel
    Top = 34
    Height = 47
    Transparent = False
    ExplicitTop = 34
    ExplicitWidth = 661
    ExplicitHeight = 47
  end
  inherited lblSource: TWebLabel
    Caption = #160'Habitat'
  end
  object tmrPoll: TWebTimer
    Interval = 5000
    OnTimer = tmrPollTimer
    Left = 572
    Top = 84
  end
  object httpPoll: TWebHttpRequest
    ResponseType = rtText
    Timeout = 10000
    Left = 352
    Top = 80
  end
  object httpCar: TWebHttpRequest
    Headers.Strings = (
      'Cache-Control=no-cache, no-store, must-revalidate')
    Left = 212
    Top = 82
  end
  object httpPayload: TWebHttpRequest
    Command = httpPOST
    OnError = httpPayloadError
    Left = 124
    Top = 86
  end
end
