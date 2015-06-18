require! <[ arch ]>
d = arch.DOM

todos-list = arch.DOM require '../components/todos-list.ls'

module.exports = class TodoMain extends React.Component
	render: ->
		d.section do
			class-name: 'main'
			d.input do
				class-name: 'toggle-all'
				type: \checkbox
				on-change: (e) ~> 
					@props.items.update (items) ->
						items |> map (it) ->
							it.done = e.target.checked
							it
			todos-list do
				items: @props.items
				mode: @props.mode
