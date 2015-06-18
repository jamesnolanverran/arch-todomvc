require! <[ arch ]>
d = arch.DOM

module.exports = class TodoHeader extends React.Component
  -> 
    @state = new-todo: ''
  render: ->
    d.header do
      class-name: 'header'
      d.h1 'todos'
      d.input do
        type: 'text'
        class-name: 'new-todo'
        placeholder: 'What needs to be done?'
        autoFocus: true
        value: @state.new-todo
        on-change: (e) ~>
          @set-state new-todo: e.target.value
        on-key-up: ~> 
          if it.key-code == 13 and @state.new-todo
            new-todo = 
              task: @state.new-todo
              done: false
              editing: false
            @props.items.update (items) ~> 
              [ new-todo ] ++ items

            @set-state new-todo: ''


