inherited frmMap: TfrmMap
  Width = 745
  OnCreate = MiletusFormCreate
  ClientWidth = 729
  object FNCMap: TTMSFNCGoogleMaps
    Left = 0
    Top = 0
    Width = 729
    Height = 387
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 0
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    Options.DefaultLatitude = 51.950300000000000000
    Options.DefaultLongitude = -2.544300000000000000
    Options.DefaultZoomLevel = 12.000000000000000000
    Options.BackgroundColor = clBlack
    ElementContainers = <
      item
        HTML.Strings = (
          '<style type="text/css">'
          '.mapbutton {'
          '   font-family:Arial, sans-serif;'
          '   font-size:12px;'
          '   line-height:12px;'
          '   color:#0;'
          '    border-width:1px;'
          '    border-color:#000000;'
          '    border-style:solid;'
          '   border-radius:8px;'
          '   background-color:#ffffff;'
          '   padding:8px;'
          '}'
          '</style>'
          '<!-- HTML Code -->'
          '<button class="mapbutton" id="btnCar" type="button">Car</button>'
          '<button class="mapbutton" id="btnHAB" type="button">HAB</button>'
          
            '<button class="mapbutton" id="btnFree" type="button" disabled="t' +
            'rue">Free</button>'
          
            '<button class="mapbutton" id="btnDirections" type="button">Direc' +
            'tions</button>')
        Actions = <
          item
            HTMLElementID = 'btnCar'
            Name = 'actCar'
            OnExecute = FNCMapElementContainers0Actions0Execute
          end
          item
            HTMLElementID = 'btnHAB'
            Name = 'actHAB'
            OnExecute = FNCMapElementContainers0Actions1Execute
          end
          item
            HTMLElementID = 'btnFree'
            Name = 'actFree'
            OnExecute = FNCMapElementContainers0Actions2Execute
          end
          item
            HTMLElementID = 'btnDirections'
            Name = 'actDirections'
            OnExecute = FNCMapElementContainers0Actions3Execute
          end>
        Position = poBottomLeft
        HTMLElementID = 'MapButtons'
        UseDefaultStyle = False
        Margins.Left = 10.000000000000000000
        Margins.Top = 10.000000000000000000
        Margins.Right = 10.000000000000000000
        Margins.Bottom = 10.000000000000000000
      end>
    HeadLinks = <>
    KMLLayers = <>
    Directions = <>
    Clusters = <>
    OverlayViews = <>
  end
end
