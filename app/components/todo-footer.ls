require! <[ arch ]>
d = arch.DOM

module.exports = class TodoFooter extends React.Component
  render: ->
    d.footer do
      class-name: 'footer'
      d.span do
        class-name: 'todo-count'
        d.strong "#{@props.items.length} #{if @props.items.length == 1 then 'item' else 'items'} left"
      d.ul do
        class-name: 'filters'
        d.li d.a do
          class-name: "selected" unless @props.mode in <[active completed]>
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
      d.button do
        class-name: 'clear-completed'
        on-click: (e) ~>
          @props.items.update (items) ->
            items |> filter -> !it.done
        "Clear Completed"