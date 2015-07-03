
module.exports = (items) ->
  items.on-change ->
    if typeof local-storage != 'undefined'
      local-storage.set-item \items (JSON.stringify (items.deref! |> map -> it))