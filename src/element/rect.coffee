udefine ['pencilbox/element', 'pencilbox/core/property'], (Element, property) ->
  class RectElement extends Element
    constructor: (left = 0, top = 0, width = 100, height = 100) ->
      @type = 'rect'
      
      property @, 'width', width
      property @, 'height', height
      
      super left, top