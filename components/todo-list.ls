require! <[ arch ]>
d = arch.DOM

todo-list-item = arch.DOM require '../components/todo-list-item.ls'

module.exports = class TodoList extends React.Component
  render: ->
    d.ul do
      class-name: 'todo-list'
      @props.items
      |> filter ~>
        mode = if it.deref!done then \completed else \active
        @props.mode is '' or @props.mode == mode
      |> map ~>
        todo-list-item do
          items: @props.items
          item: it
