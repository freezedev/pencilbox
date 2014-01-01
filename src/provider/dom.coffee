udefine ['pencilbox/constants', 'pencilbox/element/all'], (Constants, Elements) ->
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