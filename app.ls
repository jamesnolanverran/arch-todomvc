# module dependencies
require! <[ arch ]>
global import require 'prelude-ls'

# route components
require! <[
  ./routes/todo
  ./routes/not-found
]>

initial-state =
  items: [] 

module.exports = arch.application.create do
  get-initial-state: ->
    initial-state

  start: (app-state) ->

  routes: ->
    page = arch.routes.page

    arch.routes.define do
      page '/:mode?', todo
      page '*', not-found
