udefine ->
  property = (context, name, reference) ->
    Object.defineProperty context, name,
      get: -> reference
      set: (value) ->
        if value isnt reference
          context.trigger? 'property:change', name, value
          reference = value
