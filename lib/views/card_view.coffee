module.exports = class CardView extends require('backbone.marionette').LayoutView

  className: 'wwl-js-vm-simple-dashboard-card'

  template: require('../tpl/card_view.hamlc')

  regions:
    vmContainer: '> .wwl-js-vm-simple-dashboard-card-inside > .vm-container'

  initialize: (options) ->
    @dashboardConfig = options.dashboardConfig

  onRender: =>
    @_updateBox()

    if @model.getCollection().any()
      @getRegion('vmContainer').show(@model.getCollection().first().getView())

  getBoxWidth: ->
    return 0 if !_.isNumber(@model.get('box_width')) || _.isNaN(@model.get('box_width'))
    return 0 if @model.get('box_width') <= 0

    (@model.get('box_width') / @dashboardConfig.get('columns')) * 100

  getBoxHeight: ->
    return 0 if !_.isNumber(@model.get('box_height')) || _.isNaN(@model.get('box_height'))
    return 0 if @model.get('box_height') <= 0

    (@model.get('box_height') / @dashboardConfig.get('rows')) * 100

  getBoxLeft: ->
    return 0 if !_.isNumber(@model.get('box_x')) || _.isNaN(@model.get('box_x'))
    return 0 if @model.get('box_x') <= 0

    (@model.get('box_x') / @dashboardConfig.get('columns')) * 100

  getBoxTop: ->
    return 0 if !_.isNumber(@model.get('box_y')) || _.isNaN(@model.get('box_y'))
    return 0 if @model.get('box_y') <= 0

    (@model.get('box_y') / @dashboardConfig.get('rows')) * 100

  # ---------------------------------------------
  # private

  # @nodoc
  _updateBox: ->
    @.el.style.width  = "#{@getBoxWidth()}%"
    @.el.style.height = "#{@getBoxHeight()}%"
    @.el.style.left   = "#{@getBoxLeft()}%"
    @.el.style.top    = "#{@getBoxTop()}%"
