Q = require('q')

module.exports = class DateTimeCardVm extends require('../abstract/vm')

  initialize: (options) ->
    super(options)

    @model or= new (require('./models/date_time'))({})
    @_updateInterval = null

  onStart: ->
    @_updateInterval or= window.setInterval(@onUpdateTime, 1000)

    Q()

  onStop: ->
    window.clearInterval(@_updateInterval) if @_updateInterval

    Q()

  getMainViewClass: ->
    require('./views/main_view')

  getMainViewOptions: ->
    _.extend(super(), {
      model: @model
    })

  onUpdateTime: =>
    d = new Date()

    @model.set
      hours:    d.getHours()
      minutes:  d.getMinutes()
      seconds:  d.getSeconds()
