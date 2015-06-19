require! <[ arch ]>
d = arch.DOM

module.exports = class TodoListItem extends React.Component
  -> 
    @state = edit-todo: ''
  component-did-update: (prev-props) ->
    if @props.item.deref!editing
      node = React.find-DOM-node @refs['edit-field'] 
      node.focus!
      node.set-selection-range node.value.length, node.value.length
  render: ->
    task = @props.item.get \task
    done = @props.item.get \done
    editing = @props.item.get \editing

    d.li do
      class-name: do
        switch
        | done.deref! && editing.deref! => 'completed editing'
        | done.deref!                   => 'completed'
        | editing.deref!                => 'editing'
        | otherwise                     => ''
      # style:
      #   color: \red 
      d.div do
        class-name: 'view'
        d.input do
          class-name: \toggle
          type: \checkbox
          checked: done.deref!
          on-change: (e) -> 
            done.update (done) -> 
              !done
        d.label do
          on-double-click: (e) ~>
            @set-state edit-todo: task.deref!
            @props.items
            |> map ~> 
              it.get \editing .update (_) ~> 
                if it == @props.item then true else false
          task.deref!

        d.button do
          class-name: \destroy
          on-click: (e) ~>
            @props.item.update -> {}
            @props.items.update (items) ~> 
              items |> filter ~> it.task

      d.input do
        class-name: 'edit'
        value: @state.edit-todo
        ref: \edit-field
        on-blur: (e) ~>
          if @state.edit-todo
            @props.item.update ~>
              task: @state.edit-todo
              done: false
              editing: false
            @set-state edit-todo: ''
        on-key-up: (e) ~> 
          if e.key-code == 13 and @state.edit-todo
            @props.item.update ~>
              task: @state.edit-todo
              done: done.deref!
              editing: false
            @set-state edit-todo: ''
          else if e.key-code == 27
            @set-state edit-todo: task.deref!
            @props.item.get \editing .update -> false
        on-change: (e) ~>
          @set-state edit-todo: e.target.value
