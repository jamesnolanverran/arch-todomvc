require! <[ arch ]>
d = arch.DOM

todo-list-item = arch.DOM require '../components/todo-list-item.ls'

module.exports = class TodoList extends React.Component
  ->
    @state = edit-todo: ''
  render: ->
    d.ul do
      class-name: 'todo-list'
      @props.items
      |> filter ~>
        mode = if it.deref!done == false then \active else \completed
        @props.mode is '' or mode == @props.mode
      |> map ~>
        todo-list-item do
          items: @props.items
          item: it
