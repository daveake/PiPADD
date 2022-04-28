inherited frmGPS: TfrmGPS
  Height = 100
  OnCreate = MiletusFormCreate
  ClientHeight = 61
  inherited lblPosition: TWebLabel
    Top = 32
    Height = 26
    Margins.Left = 12
    Anchors = [akLeft, akTop, akRight]
    ExplicitTop = 32
    ExplicitHeight = 26
  end
  inherited lblSource: TWebLabel
    Caption = #160'GPS'
  end
end
