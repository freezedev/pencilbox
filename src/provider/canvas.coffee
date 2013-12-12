udefine ->
  class CanvasProvider
    constructor: (elementId = "canvas-#{Date.now()}", options) ->
      {parent, width, height} = options if options?
      
      unless document.getElementById elementId
        elem = document.createElement 'canvas'
        elem.id = elementId
        elem.width = width if width
        elem.height = height if height
        
        if parent is 'body' or not parent
          document.body.appendChild elem
        else
          document.getElementById(parent).appendChild(elem)
        
      elem = document.getElementById elementId
      
      @context = elem.getContext '2d'
      
    drawRect: (x, y, w, h) ->