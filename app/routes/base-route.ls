html = '<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>{title}</title>
    <link href="http://gunrss.com/static/css/arch.css" type="text/css" charset="utf-8" rel="stylesheet">
  </head>
  <body>
    {body}
  </body>
</html>
'

# This is a base route for convenient definition of outer layout and
# page title. All route components inherit from this class
module.exports = class BaseRoute extends React.Component
  get-layout-template: ->
    # TODO replace me with an actual template.
    # Jade is a good template engine for example.
    (context) ->
      html.replace '{body}', context.body .replace '{title}', context.title

  get-title: (title) ->
    if title then "#{title}" else "Arch App"
