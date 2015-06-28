require! <[ arch ]>
d = arch.DOM
routes = arch.routes

module.exports = class TodoFooter extends React.Component

  get-completed: -> it |> filter -> (it.get \done .deref!) == true

  render: ->
    d.footer do
      class-name: 'footer'
      d.span do
        class-name: 'todo-count'
        d.strong "#{@props.items.length} #{if @props.items.length == 1 then 'item' else 'items'} left"
      d.ul do
        class-name: 'filters'
        d.li d.a do
          class-name: "selected" unless @props.mode in <[ active completed ]>
          href: '/'
          "All"
        d.li d.a do
          class-name: "selected" if @props.mode is 'active'
          href: '/active'
          "Active"
        d.li d.a do
          class-name: "selected" if @props.mode is 'completed'
          href: '/completed'
          "Completed"
      if num-completed = @get-completed @props.items .length
        d.button do
          class-name: 'clear-completed'
          on-click: (e) !~> do
            @props.items.update (items) ->
              items |> filter -> !it.done
            if @props.mode == \completed
              routes.navigate '/'
          "Clear #num-completed Completed"
