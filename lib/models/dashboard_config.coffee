module.exports = class DashboardConfig extends require('backbone').Model

  defaults:
    columns:  12
    rows:     6
    context:  null

  sync: ->
    null