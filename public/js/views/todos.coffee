depends = [
  'jquery', 
  'underscore', 
  'backbone',
  'text!templates/todos.html'
]

define depends, ($, _, Backbone, todosTemplate) ->
  TodoView = class extends Backbone.View

    tagName:  "li"

    template: _.template todosTemplate

    events: 
      "click .check"              : "toggleDone"
      "dblclick div.todo-content" : "edit"
      "click span.todo-destroy"   : "clear"
      "keypress .todo-input"      : "updateOnEnter"

    initialize: ->
      _.bindAll @, 'render', 'close'
      @model.bind 'change', @render
      @model.view = @;

    render: ->
      $(@el).html @template @model.toJSON()
      @setContent()
      @

    setContent: ->
      content = @model.get 'content'
      @$('.todo-content').text content
      @input = @$('.todo-input')
      @input.bind 'blur', @close
      @input.val content

    toggleDone: ->
      @model.toggle()

    edit: ->
      $(@el).addClass "editing"
      @input.focus()

    close: ->
      @model.save {content: @input.val()}
      $(@el).removeClass "editing"

    updateOnEnter: (e) ->
      if e.keyCode == 13
        @close()

    remove: ->
      $(@el).remove()

    # Remove the item, destroy the model.
    clear: ->
      @model.clear()

  TodoView
