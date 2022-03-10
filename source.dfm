inherited frmSource: TfrmSource
  Width = 692
  Height = 152
  Font.Color = clWhite
  Font.Height = -21
  ParentFont = False
  ClientHeight = 113
  ClientWidth = 676
  object lblPosition: TWebLabel
    AlignWithMargins = True
    Left = 0
    Top = 26
    Width = 675
    Height = 87
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WordWrap = True
    WidthPercent = 100.000000000000000000
  end
  object lblSource: TWebLabel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 129
    Height = 24
    Margins.Left = 12
    Margins.Right = 2
    Margins.Bottom = 2
    AutoSize = False
    Color = 7331825
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblStatus: TWebLabel
    AlignWithMargins = True
    Left = 128
    Top = 0
    Width = 513
    Height = 24
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Color = 7331825
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object WebLabel1: TWebLabel
    AlignWithMargins = True
    Left = 640
    Top = 0
    Width = 35
    Height = 24
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '...'
    Color = 7331825
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
    OnClick = WebLabel1Click
  end
end
