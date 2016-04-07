module.exports = class DateTime extends require('backbone').Model

  defaults:
    seconds:  0
    minutes:  0
    hours:    0
    date:     new Date()

  sync: ->
    null