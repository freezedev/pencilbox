udefine ['mixedice', 'eventmap', 'pencilbox/core/property'], (mixedice, EventMap, property) ->
  class Element
    constructor: (left = 0, top = 0) ->
      mixedice [@, Element::], new EventMap()
      
      property @, 'left', left
      property @, 'top', top
      @type = 'none'
      
      @trigger 'created', @type