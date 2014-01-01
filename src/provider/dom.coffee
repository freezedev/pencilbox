udefine ['pencilbox/constants'], (Constants) ->
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
    
    drawCircle: (x, y, size) ->
      styles =
        position: 'absolute'
        left: pixelize x
        top: pixelize y
        width: pixelize size
        height: pixelize size
        'border-radius': pixelize (size / 2)
        
      element = "circle-#{Date.now()}"
      
      createElement @root,
        {id: "pb-element-#{element}", className: 'element circle'},
        styles
      
    drawRect: (x, y, w, h) ->
      styles =
        position: 'absolute'
        left: pixelize x
        top: pixelize y
        width: pixelize w
        height: pixelize h
      
      element = "rect-#{Date.now()}"
      
      createElement @root,
        {id: "pb-element-#{element}", className: 'element rect'},
        styles
