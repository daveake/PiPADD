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
        object WebWaitMessage1: TWebWaitMessage
          Left = 280
          Top = 228
          Width = 24
          Height = 24
          HeightPercent = 100.000000000000000000
          WidthPercent = 100.000000000000000000
          Opacity = 0.200000000000000000
          Picture.Data = {
            0954474946496D61676547494638396190012C01A20000FFFFFFDDDDDDBBBBBB
            999999FFFFFFFFFFFFFFFFFFFFFFFF21FF0B4E45545343415045322E30030100
            000021F90405050004002C0000000090012C0182FFFFFFDDDDDDBBBBBB999999
            FFFFFFFFFFFFFFFFFFFFFFFF03FF48BADCFE30CA49ABBD38EBCDBBFF60288E64
            699E68AAAE6CEBBE702CCF746DDF78AEEF7CEFFFC0A070482C1A8FC8A472C96C
            3A9FD0A8744AAD5AAFD8AC76CBED7ABFE0B0784C2E9BCFE8B47ACD6EBBDFF0B8
            7C4EAFDBEFF8BC7ECFEFFBFF808182838485868788898A8B8C8D8E8F90919293
            9495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3
            B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3
            D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3
            F4F5F6F7F8F9FAFBFCFDFEFF00030A1C48B0A0C18308132A5CC8B0A1C3871023
            861A407180C444152B5E349431FFE346421D357E141492E24892254F062A6951
            E51F962EC978F400D383809B02621E09493365079C387512A9B981A806A04085
            0A319A812906A441950261D95283530B50A34AF541B52A86AB14B26ADDDA836A
            519F19C4E6243B15AC04B711D4B20D62B629DA0B72E7B6BD5B01EE83BC7A7F74
            FDCA7782DAB58105FB6DB09801E0C45CEBF62D1CF731E4B28D15642660F93266
            CA0F3277F6CC43F204D162492F6DDC78B4EA1D834F8376ECFAB50ED31016D7B6
            9D237604BF8779AF9EBD80A7E1D4C24BCCFC803BB44809BB2F04981E20B9F19E
            C48F22F7409D3AEFE676AF87D8CEA1BB79DB5DBD86EF48827C06F3F0D1A7577F
            41BC08A8E5E1C77F3DDFE459FFFF2624B5817EFA7DD71F7D4E1058A0700702D8
            84820B26474083081601E17E1216D7A012179E97A103141AD161771FBEB56110
            237A57A26C070291E2742B5A70220F2FC6B81E78378C682307E9F970E18ED865
            370384408220240D111669E4733F90A8E493504629E594545669E5955866A9A5
            4014FA960400608629E698648EB955973D7E59E69A6C86A9149AF321D1E69C6C
            0A05679A46D0A9A7993ADDE925117B060A809D7E6E9683A07BBE59287B6A225A
            A7548B3229A7A3656E69E9A59866AAE9A69C76EAE9A7A086AAC5728A39E8E991
            33A06AE59FBDE198259EB0B18A657F91C1BA6A8B9FC5596588A5D22A25AF7BF9
            AA24B04310BBA2B145206BDD8CFF4928CB1FB34C387B19B44F503BADB0EBA140
            2A61BAAA862DB79286605F7DDD92662BB8DB32A72A88B226E6AA8CEB5260A873
            F1129AAE55F3B2382EBEF77AD6EF8DFF6A682ABDFBF25BE1AC8B15CCC0BBA2FE
            C6B05FED36ECB09009E71B6AC402336AA2C59F32ACD9911E4B3C61662473CC69
            C8232BCC98C99AA29CB2C6F2B27C29C62BAB5C73BD2D1BAAB3CC5AD27C73C0EC
            F28C70BCF3BA9C73BDF91A8DA9D22F034D30CC0D33DD74B893E13C34CE16FBBC
            34C75C0B1DA5C9605B7DABCD1B438D2ED5A79A7DF6C0678BFC31DB6B1F0C2FDC
            6E77E075DDCA898D770A77EF2D42DF7E2F4976E02F004E7890741F9E2ADA8A37
            EEF8E390472EF9E494576EF9E5649867AEF9E69C77EEF9E7A0872EFAE8A4976E
            FAE9A8A7AEFAEAACB7EEFAEBB0C72EFBECB4D76EFBEDB8E7AEFBEEBCF7EEFBEF
            C0072FFCF0C4176FFCF1C827AFFCF2CC37EFFCF3D0472FFDF4D4576FFDF5D867
            AFFDF6DC77EFFDF7E0872FFEF8E497DF7D020021F90405050007002CD6006000
            3000570082FFFFFFDDDDDDBBBBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03EC78
            BABCF3A3C9492B85D0EA7D71E6E0E67D61298DA4A9A2A95AB291BBB2B20BD7E6
            8D8770BC73BA9F2828B4108B1D1472A85C568E4E462F9A1C5127D36B037AE5AA
            04608191B60B879FCD9A795DC5A8D7ECB6CF04AF8F1FB2BA9DAADF3BFB7E4880
            707C83665186877F8960858C8E865A895A0A83940B80970C819A95679DA0A1A2
            A3A4A5A6A7A8A9AA2A01ADAEAFB0B1B035B2B5B6AF2EB7BAB6ACBBBEB826BFC2
            01BDC3BBB9C6B7B4C9B2ABCECFD0D1D2D3D4D53200D800A5D9DCA2DCDFDA9DE0
            DFE2E3E494E6E3E8E9E05AECEDEEEFDDF1F2D8F4F5EBF5E157FAFBFCF8F9D895
            4B178AA0B773A3E65148000021F90405050007002CD60075003000570082FFFF
            FFDDDDDDBBBBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03E978BADCFE6EC801AB
            BD6D4ECCFBD1A0274660388E657A8AA9BA62ADFB56B13C93B576D3B9BEE33DCA
            2F13940C81BD2331A844B69A8F1C14529BF24CD6AB30CBED7ABFE0B0784C2E9B
            CF5C817ACD6EBBDBB3B77CCE5ED1EFF3137E0F1FF1FF027A807B76837471866F
            688B8C8D8E8F909192930A01960166979A639A9D98609E9DA0A1A25DA4A1A6A7
            9E5CAAABACAD9BAFB096B2B3A9B39F59B8B91000BE002FB815BFBFC1B0BDC4C5
            C6A7C8C9C037CC0FCECAD0A5D2D3CF3BB1C3D862D8BEDEDD61DFD95FDF63E7E3
            E2EAD3E1EBE6EF5EE4EECEE8F15DE9ECF5FAFB60F9FEEDE81123D3CF1EB82909
            000021F90405050007002CC40092004200420082FFFFFFDDDDDDBBBBBB999999
            FFFFFFFFFFFFFFFFFFFFFFFF03F978BADCFE508D49ABBD36EA1DB1FF15277260
            F98DE863AE59EA4A6CFCBEB13CBBB579CFF9B9FFC0A070482C1A8FC8A472C96C
            3A9FD0A8747A105805D4D7759B1D6DBFD8AE06FC1547C860B3034D5633D86D77
            155E96CFE957FB1D1F76F3F3767F567A8246018701377F4488888A78438D8D3B
            74919287406C96978999751100A1001C9C98415C1AA2A2A4A54FAAAA1BA5A64C
            AFABB1AD4DB5A1ACB84BBAA3BC97B9BA23B2B4C422C6BEC8C9BD48BF28B29DCF
            CCCD9C4AD0D1CA47D9DAD7D4B52FDB45DDDEC2DCD5E692E8E1E2E342E529EF41
            F1F2DF44F5EA8EE4E92EE7FCED764C62F74A8F837C7610CA51E886A11A870F0B
            1A7C006B6283040021F90405050007002CA700A4005700300082FFFFFFDDDDDD
            BBBBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03FF78BADCFE30CA37EA9838EBCD
            8FFD5D288ECD675E64AA4AA7B9BEB0D7BA711DCEADAD6B78BEFF90DE09487408
            69C5E411942C2E2D4DE51315054E35802CE027E80A464F8C56ABF37AC1C7C978
            5C339B4942F53ADB76775538C99C1CB39FF148107B7413018601187E772B4C11
            835B858786898A518F90119292138A8B458F189A87947E4997A1A2889C9D9F83
            19A9AAABA540A0AFA91AAC3FB5A8A2B8953BBBBC9A1BB935A71AB0C4C530C1C2
            9BCAB3CCCD91BDD0D12BD3D4C31CCB29D9DACFDCBF2ADF12C91DDD22E5E6B721
            E91CC71DE7E8EF58AE22F3F4D71DF7F8ED22E342F40B914F9F1B6F6B521434E8
            89041B85FF46BCA9E26C14C5280B2FFEC8A8511307C78E353E82842172E48B6A
            2689844BA920010021F90405050007002C9200A4005700300082FFFFFFDDDDDD
            BBBBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03FF78BADC0E10B849ABBD38B7C8
            B5FFE0C78D52689E2139A26C4BA9A42BB7B03ADF606DE33CA6C7BDE0E4B7121A
            17C4CE71998C2C8F4DC813DA9C5289A78036201C7807996476ABED7DBF3E1D8A
            4CC69DCF975A8BBD75BFBD69258B5EBFDDD1714E2E7C6517028702187F785607
            845C8688878A8B568F90159292178B8C4B8F189A88947F4F97A1A2899C9D9F84
            19A9AAABA546A0AFA91AAC42B5A8A2B89541BBBC9A1EB938A71AB0C4C533C1C2
            9BCAB3CCCD91BDD0D183AE1FC91FCB7BD9DAB720DD637C21DBDCBFDEE5E6E1E2
            E926C720E7E8EF20D3C8EDEED7F6EB26F3FA6FD6F46357CD443D7E6D50FC03E8
            49602185F90C026A446D18452B0B2F0AC9A8B11207C78E383E829C2172A48C82
            268D3CE391000021F90405050007002C8A0092004200420082FFFFFFDDDDDDBB
            BBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03F57807DCFEF0A949ABBD98C6CD5D
            FEE0D58D5C6882642A9DACA5BE402B4FB03ADFF578EFF9B6FFC0A070482C1A8F
            C8A472C96C3A9FD0A8744A3D05AE81AA0CCBD59AB8E0AC3713068F2FE5F09992
            2EAF0F6DF73AAE3ED3CDF63BF6ADDFE7FB7C8081773B028602467A8587864574
            3F8C8C446D4191878E784096979857439B8D2003A30352A088A2A4A350A7A819
            AAAA4FA721B0A44EADB4B5A54DB3B9B5BCA027BABB4BBDBEB04CC6C7B14AB8C2
            BAC5C12CC3CDCACBB649D6D7AB48DADBC446DEA9BF47E2E3C8E1E61FD4E99B3B
            EC45D237F044F233F4F59140F8F9A13FFC6F26000C78606040836F10AE517886
            6143740431304B000021F90405050007002C8A0075003000570082FFFFFFDDDD
            DDBBBBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03E778BA0C0E2CCA496B7BCEEA
            4DB1E7E0E68D61298DA8A9A2A95AB2ADCBC1B1ACD1A47DE3982EF20FDF0E0811
            768845E304A9AC009B161C340A9B0E7BD65F26CBED7ABFE0B0784C2E9BCFA180
            7ACD6EBBDBB6B77CCE76D1EF73157E0F37F1FF017A807B76837471866F688B8C
            8D8E8F909192936802960266979A639A9D98609E9D5FA19E5DA4A159A7A856AA
            A553ADA2AFB097A9B396ACB69FB2B35CB63203C00316BC2EC1C115AD36C6C614
            A73ECBC7CDB13AD0D1D2B742D5C062DAC261DDDE60DDDCE3DFDAE4D563E5E2E7
            E6EDECE9EEF1F0D0E8F5F6CBF8CCF2F7F4F9FADBD4CDD377669F86040021F904
            05050007002C8A0060003000570082FFFFFFDDDDDDBBBBBB999999FFFFFFFFFF
            FFFFFFFFFFFFFF03EB78BADCFE0B4800ABBD6D4ECCBBD29A2756E0369E4C69A2
            A7BAB2A24BC1AD4B8FF28DDB7A27CF3D4C2E281C122DC62389A784249B8E2734
            229D1EAAD39F35CA8404BE811EF60006EBB0E5F4ADCB48BB61EC857BCE2A55E6
            7454C882CF4FFB7E50806F7F83655B8687568966858C888F90835B7280949578
            976D849A9B5F9DA0A1A2A3A4A5A6A7A8A93A02ACADAEAFB0AF30B1B4B5AE28B6
            B9B527BABDB223BEC102BCC2BDB8C5B6B3C8B1AACDCECFD0D1D2D3D4CF03D703
            A3D8DBA0DBDED997DFDE94E2DF56E5E250E8E94DEBE64AEEE3F0F1D8EAF4D7ED
            F7E0F3F453F75BFD00AED3842ED43B51DCAC24000021F90405050007002C8A00
            58004200420082FFFFFFDDDDDDBBBBBB999999FFFFFFFFFFFFFFFFFFFFFFFF03
            FD78BADCFE30CA062A9838EB69EDFE20D77961698EA4A96E68B5BE597BC13424
            D738D5E64BE007AF1BEFF75B097144A2EA584B164FBB9CF31962D2A6D48FF58A
            2D6DB9D36A74D8057DC14EF3985CD69CD149ED9A1D76CFE9713B8AE7C0026377
            784A807B7C0D7E842386878822858B3D6D116F528D93818696971D13029E0270
            83129C129F9F309A2BA6AB2F92AAABAC26AE2AB0B5B27934B5B625A235BABB90
            20BFC0C11BC3B0C51FC7B1C91ACBA6CDC6CF9ED119D3D4D518D7D9D6CBDCCEC3
            DFE0BAE2D2CCE5E3A0E8EBECEDEEEFF0F1F2F3F4F5F68603F9FAFBFCFDFCD5FE
            020ADCD76CA04181C90E2AFC576CA1C301091F2A2C287120C08AFEA225000021
            F90405050007002C920058005700300082FFFFFFDDDDDDBBBBBB999999FFFFFF
            FFFFFFFFFFFFFFFFFF03FF78BADCFE30BE4083BC38EB3D2BE560284A9E379E28
            575669EB76EB2BBFEB37DF676DE13CA8F723815090FAA10048406B38441947C9
            248AC9CCD54ED1E889DA1C3D435969902BF45E4561B188DCF59D4169F59A2DFA
            6EE2CA149BE88EC1E32E7B217619782F822A6F1A8687881A841278798D64897E
            8B80337B7C19901092388E189E0F8CA1749D8A91993CA224AA11A6ADA817A40C
            B2B3B411B60AA0400AAE302518B83D9BB5B00DBEBFC0BA1097B1AC1003D40381
            CEC2C4D20FD5D54BD847DB0DDDE47A9532E2E3E4E5635C33E90CEBF2ED6DE859
            18F2F373653C5A19F9FA9809041850E02F82EB0C3243C84E211086DD1C1E8448
            4D620F8A152DF2C0A8F11322C38E0F09820C996FE4C48626495A4BA921010021
            F90401050007002CA70058005700300082FFFFFFDDDDDDBBBBBB999999FFFFFF
            FFFFFFFFFFFFFFFFFF03FF78BADCFE4B4801ABBD38EB36E7FE60A8759D689E22
            E9A16C5BA9922BCF074CD1F869E77CB8F7A28170C0FA9D02C8406B38441945C9
            248AC9D4C18E51A989DA343D41596D902BF45EA161E489DC057D3569F1989C3A
            83E34BB6CFBE892BF3746E7C70782E6C441F6F177E33878823838B8C8D7A1B8A
            1593949519970F7E7F34879691988539A29CA49EA6A79B179D0D993CA8AFAAB1
            ACB3B42FB60B9F400BBA10B00AB2408EB52A92B8C6AEC22418C5BF07C10F25CA
            612E00DA0018D428D121DBDBDD8132CB20E2E917CD2CE71AE9F0E45538D822F0
            F719F3395126F7F8D2D2FCFD03D843E04082380CC643C843A13A86091D8E8348
            43E2448A332C6AC358D11422C7880A3FE6082972A4C0920517A24CB9D1440200
            3B}
        end
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
    Top = 390
  end
  object tmrSources: TWebTimer
    Interval = 100
    OnTimer = tmrSourcesTimer
    Left = 504
    Top = 390
  end
  object tmrUploads: TWebTimer
    OnTimer = tmrUploadsTimer
    Left = 708
    Top = 390
  end
end
