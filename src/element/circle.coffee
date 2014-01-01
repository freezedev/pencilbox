udefine ['pencilbox/element', 'pencilbox/core/property'], (Element, property) ->
  class CircleElement extends Element
    constructor: (left = 0, top = 0, width = 100, height = 100) ->
      @type = 'circle'
      
      property @, 'width', width
      property @, 'height', height
      
      super left, top