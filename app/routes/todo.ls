require! {
  './base-route': BaseRoute
  arch
}

todo-header = arch.DOM require '../components/todo-header.ls'
todo-main = arch.DOM require '../components/todo-main.ls'
todo-footer = arch.DOM require '../components/todo-footer.ls'

d = arch.DOM

module.exports = class TodoRoute extends BaseRoute
  get-title: -> super "TodoMVC"

  component-will-mount: ->
    # look for localStorage client side only # TODO: refactor
    if typeof window != 'undefined' &&
       window.document &&
       window.document.createElement &&
       typeof local-storage != 'undefined'
      if json-items = JSON.parse (local-storage.getItem \items)
        items = @props.app-state.get \state.items
        items.update -> json-items

  render: ->
    items = @props.app-state.get \state.items
    mode = @props.app-state.get \route.params.mode .deref!
    d.div do
      d.section do
        class-name: 'todoapp'
        todo-header do
          items: items
          mode: mode
        if items.length
          todo-main do
            items: items
            mode: mode
        if items.length # why two checks?
          todo-footer do
            mode: mode
            items: items
      d.footer do
        class-name: 'info'
        d.p "Double-click to edit a todo"

