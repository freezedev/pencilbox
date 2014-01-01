udefine ['pencilbox/element'], (Element) ->
  class CircleElement extends Element
    constructor: ->
      @type = 'circle'
      
      super