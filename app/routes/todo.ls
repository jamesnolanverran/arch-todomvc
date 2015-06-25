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
  component-did-mount: ->
    items = @props.app-state.get \state.items
    if !items.length && JSON.parse(localStorage.getItem('items'))
      items.update -> JSON.parse(localStorage.get-item \items)
  render: ->
    items = @props.app-state.get \state.items
    mode = (@props.app-state.get \route.params.mode .deref!) or ''
    d.div do
      d.section do
        class-name: 'todoapp'
        todo-header do
          items: items
          mode: mode
        if items.length > 0
          todo-main do
            items: items
            mode: mode
        if items.length > 0 # why do I need to check twice?
          todo-footer do
            mode: mode
            items: items
      d.footer do
        class-name: 'info'
        d.p "Double-click to edit a todo"

