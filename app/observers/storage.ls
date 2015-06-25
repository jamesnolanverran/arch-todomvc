
module.exports = (items) ->
  items.on-change ->
    if local-storage
      local-storage.set-item \items (JSON.stringify (items.deref! |> map -> it))