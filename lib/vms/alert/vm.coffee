module.exports = class AlertCardVm extends require('../abstract/vm')

  initialize: (options) ->
    super(options)

    @model or= new (require('./models/alert'))({})
    @model.set(options)

  getMainViewClass: ->
    require('./views/main_view')

  getMainViewOptions: ->
    _.extend(super(), {
      model: @model
    })