object frmMain: TfrmMain
  Width = 800
  Height = 480
  Caption = 'HAB PiPADD'
  Color = clBlack
  OnCreate = MiletusFormCreate
  OnResize = MiletusFormResize
  OnShow = MiletusFormShow
  ClientHeight = 480
  ClientWidth = 800
  BorderStyle = bsNoneBorder
  WindowState = wsMaximized
  object pnlForm: TWebPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 480
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    Align = alClient
    BorderColor = clBlack
    BorderStyle = bsNone
    ChildOrder = 8
    Color = clBlack
    object pnlButtons: TWebPanel
      Left = 0
      Top = 27
      Width = 121
      Height = 426
      WidthStyle = ssPercent
      HeightPercent = 100.000000000000000000
      WidthPercent = 15.000000000000000000
      Align = alLeft
      BorderColor = clSilver
      BorderStyle = bsNone
      ChildOrder = 8
      Color = clBlack
      object btnPayloads: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 121
        Height = 57
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Payloads'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnPayloadsClick
      end
      object btnDirection: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 61
        Width = 121
        Height = 57
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Direction'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnDirectionClick
      end
      object btnMap: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 122
        Width = 121
        Height = 57
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Map'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnMapClick
      end
      object btnSSDV: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 183
        Width = 121
        Height = 57
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SSDV'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnSSDVClick
      end
      object btnSettings: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 305
        Width = 121
        Height = 57
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Settings'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnSettingsClick
      end
      object btnSources: TWebLabel
        Left = 0
        Top = 366
        Width = 121
        Height = 60
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Sources'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnSourcesClick
        ExplicitTop = 378
        ExplicitHeight = 50
      end
      object btnLog: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 244
        Width = 121
        Height = 57
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Log'#160
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = btnLogClick
      end
    end
    object pnlButtonTop: TWebPanel
      Left = 0
      Top = 0
      Width = 800
      Height = 27
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Align = alTop
      BorderColor = clBlack
      BorderStyle = bsNone
      ChildOrder = 8
      Color = clBlack
      object WebLabel1: TWebLabel
        Left = 632
        Top = 8
        Width = 58
        Height = 15
        Caption = 'WebLabel1'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object lblPayload3: TWebLabel
        Tag = 3
        AlignWithMargins = True
        Left = 348
        Top = 0
        Width = 96
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 12.000000000000000000
        OnClick = SelectPayload
        ExplicitLeft = 350
      end
      object lblPayload2: TWebLabel
        Tag = 2
        AlignWithMargins = True
        Left = 248
        Top = 0
        Width = 96
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 12.000000000000000000
        OnClick = SelectPayload
        ExplicitTop = -28
      end
      object lblPayload1: TWebLabel
        Tag = 1
        AlignWithMargins = True
        Left = 148
        Top = 0
        Width = 96
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 12.000000000000000000
        OnClick = SelectPayload
        ExplicitLeft = 150
      end
      object lblPayload: TWebLabel
        AlignWithMargins = True
        Left = 448
        Top = 0
        Width = 336
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        ExplicitLeft = 531
        ExplicitTop = -3
        ExplicitWidth = 96
      end
      object lblTopLeft: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 144
        Height = 27
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 18.000000000000000000
        OnClick = lblTopLeftClick
        ExplicitLeft = 8
      end
      object lblTopRight: TWebLabel
        Left = 784
        Top = 0
        Width = 16
        Height = 27
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Alignment = taCenter
        AutoSize = False
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
      end
    end
    object pnlButtonBottom: TWebPanel
      Left = 0
      Top = 453
      Width = 800
      Height = 27
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Align = alBottom
      BorderColor = clBlack
      BorderStyle = bsNone
      ChildOrder = 8
      Color = clBlack
      object lblBottomLeft: TWebLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 144
        Height = 27
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HeightPercent = 100.000000000000000000
        Layout = tlBottom
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 18.000000000000000000
        ExplicitLeft = 10
      end
      object lblGPSStatus: TWebLabel
        AlignWithMargins = True
        Left = 148
        Top = 0
        Width = 64
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'GPS'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 4.000000000000000000
      end
      object lblLoRaStatus1: TWebLabel
        AlignWithMargins = True
        Left = 216
        Top = 0
        Width = 64
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'CE0'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 4.000000000000000000
        ExplicitLeft = 212
      end
      object lblGPS: TWebLabel
        AlignWithMargins = True
        Left = 556
        Top = 0
        Width = 159
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        OnClick = lblGPSClick
        ExplicitLeft = 452
        ExplicitWidth = 348
      end
      object lblBottomRight: TWebLabel
        Left = 784
        Top = 0
        Width = 16
        Height = 27
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Alignment = taCenter
        AutoSize = False
        Color = 7331825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 100.000000000000000000
        ExplicitLeft = 794
      end
      object lblHABLinkStatus: TWebLabel
        AlignWithMargins = True
        Left = 420
        Top = 0
        Width = 64
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'HABLink'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 7.000000000000000000
        ExplicitLeft = 276
      end
      object lblSSDVUplinkStatus: TWebLabel
        AlignWithMargins = True
        Left = 763
        Top = 0
        Width = 19
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alRight
        Alignment = taCenter
        AutoSize = False
        Caption = 'S'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 10.000000000000000000
        ExplicitLeft = 768
      end
      object lblHABHUBUplinkStatus: TWebLabel
        AlignWithMargins = True
        Left = 717
        Top = 0
        Width = 19
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alRight
        Alignment = taCenter
        AutoSize = False
        Caption = 'H'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 10.000000000000000000
        ExplicitLeft = 768
      end
      object lblHABLINKUplinkStatus: TWebLabel
        AlignWithMargins = True
        Left = 740
        Top = 0
        Width = 19
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alRight
        Alignment = taCenter
        AutoSize = False
        Caption = 'L'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthPercent = 10.000000000000000000
        ExplicitLeft = 768
      end
      object lblLoRaStatus2: TWebLabel
        AlignWithMargins = True
        Left = 284
        Top = 0
        Width = 64
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'CE1'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 4.000000000000000000
        ExplicitLeft = 296
      end
      object lblHABHUBStatus: TWebLabel
        AlignWithMargins = True
        Left = 488
        Top = 0
        Width = 64
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'Habitat'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 7.000000000000000000
        ExplicitLeft = 448
      end
      object lblUSB: TWebLabel
        AlignWithMargins = True
        Left = 352
        Top = 0
        Width = 64
        Height = 27
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = 'USB'
        Color = 5151913
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Swiss911 UCm BT'
        Font.Style = []
        HeightPercent = 100.000000000000000000
        Layout = tlCenter
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 4.000000000000000000
        ExplicitLeft = 368
      end
    end
    object pnlMain: TWebPanel
      AlignWithMargins = True
      Left = 124
      Top = 30
      Width = 676
      Height = 420
      Margins.Right = 0
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Align = alClient
      BorderColor = clSilver
      BorderStyle = bsNone
      ChildOrder = 3
      Color = clBlack
      object pnlDirection: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlDirection'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
      object pnlLog: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlLog'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
      object pnlMap: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlMap'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
      object pnlPayloads: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlPayloads'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
      object pnlSettings: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlSettings'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
      object pnlSources: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlSources'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
      object pnlSplash: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlSplash'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
      end
      object pnlSSDV: TWebPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 420
        Margins.Right = 0
        ElementID = 'pnlSSDV'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        Align = alClient
        BorderColor = clSilver
        BorderStyle = bsNone
        ChildOrder = 3
        Color = clBlack
        Visible = False
      end
    end
  end
  object tmrInit: TWebTimer
    Enabled = False
    Interval = 1500
    OnTimer = tmrInitTimer
    Left = 616
    Top = 394
  end
  object tmrBleep: TWebTimer
    Interval = 100
    OnTimer = tmrBleepTimer
    Left = 396
    Top = 394
  end
  object tmrScreenUpdates: TWebTimer
    OnTimer = tmrScreenUpdatesTimer
    Left = 268
    Top = 402
  end
end
