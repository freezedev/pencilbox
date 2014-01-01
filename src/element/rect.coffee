udefine ['pencilbox/element'], (Element) ->
  class RectElement extends Element
    constructor: ->
      @type = 'rect'
      
      super