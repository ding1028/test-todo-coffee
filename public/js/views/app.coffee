depends = [
  'jquery',
  'underscore', 
  'backbone',
  'cs!collections/todos',
  'cs!views/todos',
  'text!templates/stats.html'
]

define depends, ($, _, Backbone, Todos, TodoView, statsTemplate) ->
  AppView = class extends Backbone.View

    el: $ "#todoapp"

    statsTemplate: _.template statsTemplate

    events:
      "keypress #new-todo":  "createOnEnter"
      "keyup #new-todo":     "showTooltip"
      "click .todo-clear a": "clearCompleted"

    initialize: ->
      _.bindAll @, 'addOne', 'addAll', 'render'

      @input = @$("#new-todo");

      Todos.bind 'add',     @addOne
      Todos.bind 'reset',   @addAll
      Todos.bind 'all',     @render

      Todos.fetch()

    render: ->
      done = Todos.done().length
      @$('#todo-stats').html @statsTemplate
        total:      Todos.length,
        done:       Todos.done().length,
        remaining:  Todos.remaining().length

    addOne: (todo) ->
      view = new TodoView {model: todo}
      @$("#todo-list").append view.render().el

    addAll: ->
      Todos.each @addOne

    newAttributes: ->
      return {
        content: @input.val(),
        order:   Todos.nextOrder(),
        done:    false
      }

    createOnEnter: (e) ->
      if e.keyCode != 13
        return
      Todos.create @newAttributes()
      @input.val ''

    clearCompleted: ->
      _.each Todos.done(), (todo) -> todo.clear()
      false

    showTooltip: (e) ->
      tooltip = @$(".ui-tooltip-top")
      val = @input.val()
      tooltip.fadeOut()
      if @tooltipTimeout
        clearTimeout @tooltipTimeout
      if val == '' || val == @input.attr 'placeholder'
         return
      show = -> tooltip.show().fadeIn()
      @tooltipTimeout = _.delay show, 1000

  AppView

