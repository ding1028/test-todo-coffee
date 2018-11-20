define ['underscore', 'backbone'], (_, Backbone) ->
  TodoModel = class extends Backbone.Model

    defaults:
      content: "empty todo..."
      done: false

    initialize: ->
      if !@get("content")
        @set {"content": @defaults.content}

    toggle: ->
      @save {done: !@get("done")}

    clear: ->
      @destroy()
      @view.remove()

  TodoModel
