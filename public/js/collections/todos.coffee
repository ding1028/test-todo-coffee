depends = [
  'underscore',
  'backbone',
  'libs/backbone/localstorage',
  'cs!models/todo'
]
define depends, (_, Backbone, Store, Todo) ->
  TodosCollection = class extends Backbone.Collection
    model: Todo

    localStorage: new Store "todos"

    done: ->
      @filter (todo) -> todo.get('done')

    remaining: ->
      @without.apply(@, @done())

    nextOrder: ->
      if !this.length
        return 1
      this.last().get('order') + 1

      todo.get('order')

  new TodosCollection