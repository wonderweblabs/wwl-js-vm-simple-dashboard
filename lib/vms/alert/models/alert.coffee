module.exports = class Alert extends require('backbone').Model

  defaults:
    title:    null
    message:  null

  sync: ->
    null