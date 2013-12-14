udefine 'pencilbox', ->

udefine 'pencilbox/methods', ->
  methods = [
    'drawCircle'
    'drawEllipse'
    'drawImage'
    'drawImageRect'
    'drawLine'
    'drawOval'
    'drawPoint'
    'drawRect'
    'drawText'
  ]

udefine 'pencilbox/provider/canvas', ->
  class CanvasProvider
    constructor: (elementId = "pencilbox-#{Date.now()}", options) ->
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
udefine 'pencilbox/provider/dom', ->
  elements = 0
  
  pixelize = (num) ->
    # TODO: Do this without type check
    if typeof num is 'number' then num + 'px' else num
  
  createElement = (parent, attributes, styles) ->
    elem = document.createElement 'div'
    
    for key, value of attributes
      elem[key] = value
      
    for styleKey, styleValue of styles
      elem.style[styleKey] = styleValue
      
    if parent is 'body' or not parent
      document.body.appendChild elem
    else
      document.getElementById(parent).appendChild(elem)
    
    elements++
    elem
  
  class DOMProvider
    constructor: (elementId = "pencilbox-#{Date.now()}", options) ->
      if typeof elementId is 'object'
        options = elementId
        elementId = "pencilbox-#{Date.now()}"
      
      {parent, width, height} = options if options?
      width = pixelize width
      height = pixelize height
      
      unless document.getElementById elementId
        createElement parent,
          {id: elementId, className: 'pencilbox'},
          {width, height}
        
      elem = document.getElementById elementId
      
      @root = elementId
      
    drawRect: (x, y, w, h) ->
      styles =
        position: 'absolute'
        left: pixelize x
        top: pixelize y
        width: pixelize w
        height: pixelize h
        
      createElement @root,
        {id: "pb-element-#{element}", className: 'element rect'},
        styles

udefine 'pencilbox/provider', ->
  Provider = {}
  
  Provider.defaultProvider = 'CanvasProvider'
  
  Provider
  