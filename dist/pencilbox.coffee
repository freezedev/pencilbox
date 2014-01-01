udefine 'pencilbox/constants', ->
  defaultWidth: 800
  defaultHeight: 480
udefine 'pencilbox/core/property', ->
  property = (context, name, reference) ->
    Object.defineProperty context, name,
      get: -> reference
      set: (value) ->
        if value isnt reference
          context.trigger? 'property:change', name, value
          reference = value

udefine 'pencilbox/element/all', ['pencilbox/element', './circle', './rect'], (Element, Circle, Rect) ->
  {Element, Circle, Rect}
  
udefine 'pencilbox/element/circle', ['pencilbox/element', 'pencilbox/core/property'], (Element, property) ->
  class CircleElement extends Element
    constructor: (left = 0, top = 0, width = 100, height = 100) ->
      @type = 'circle'
      
      property @, 'width', width
      property @, 'height', height
      
      super left, top
udefine 'pencilbox/element', ['mixedice', 'eventmap', 'pencilbox/core/property'], (mixedice, EventMap, property) ->
  class Element
    constructor: (left = 0, top = 0) ->
      mixedice [@, Element::], new EventMap()
      
      property @, 'left', left
      property @, 'top', top
      @type = 'none'
      
      @on 'created', @onCreate
      @trigger 'created', @type, @
    
    # TODO: This needs to be better to take multiple providers into account
    @onCreate = ->
udefine 'pencilbox/element/rect', ['pencilbox/element', 'pencilbox/core/property'], (Element, property) ->
  class RectElement extends Element
    constructor: (left = 0, top = 0, width = 100, height = 100) ->
      @type = 'rect'
      
      property @, 'width', width
      property @, 'height', height
      
      super left, top
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
udefine 'pencilbox/provider/dom', ['pencilbox/constants', 'pencilbox/element/all'], (Constants, Elements) ->
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
      
      width = width or Constants.defaultWidth
      height = height or Constants.defaultHeight
      
      width = pixelize width
      height = pixelize height
      
      unless document.getElementById elementId
        createElement parent,
          {id: elementId, className: 'pencilbox'},
          {width, height}
        
      elem = document.getElementById elementId
            
      @root = elementId
      
      Elements.Element.onCreate = (type, instance) =>
        element = "#{type}-#{Date.now()}"
        styles =
          position: 'absolute'
        
        styles['left'] = pixelize instance.left
        styles['top'] = pixelize instance.top
        
        switch type
          when 'circle'
            size = if instance.width > instance.height then instance.width else instance.height
          
            styles['width'] = styles['height'] = pixelize size
            styles['border-radius'] = pixelize (size / 2)
          when 'rect'
            styles['width'] = pixelize instance.width
            styles['height'] = pixelize instance.height
            
        createElement @root,
        {id: "pb-element-#{element}", className: "element #{type}"},
        styles
    
    drawCircle: (x, y, size) ->
      new Elements.Circle x, y, size, size
      
    drawRect: (x, y, w, h) ->
      new Elements.Rect x, y, w, h
udefine 'pencilbox/provider', ->
  Provider = {}
  
  Provider.defaultProvider = 'CanvasProvider'
  
  Provider
  