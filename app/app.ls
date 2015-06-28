# module dependencies
require! <[ arch ]>
global import require 'prelude-ls'

# route components
require! <[
  ./routes/todo
  ./routes/not-found
  ./observers/storage
]>

initial-state =
  items: []

module.exports = arch.application.create do
  get-initial-state: ->
    initial-state

  start: (app-state) ->
    items = app-state.get \state.items
    storage items

  routes: ->
    page = arch.routes.page

    arch.routes.define do
      page '/:mode?', todo
      page '*', not-found
