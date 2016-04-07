module.exports = class SimpleDashboardVm extends require('wwl-js-vm').VM

  initialize: (options) ->
    @options = options

    cfg = {}
    cfg.columns = options.columns if _.isNumber(options.columns)
    cfg.rows    = options.rows if _.isNumber(options.rows)
    cfg.context = @context

    @getDashboardConfig().set cfg

  getDashboardConfig: ->
    @_dashboardConfig or= new (require('./models/dashboard_config'))({})

  getCardsCollection: ->
    @_cardsCollection or= new (require('./collections/cards_collection'))(
      @options.cards, {
        context:                @context
        viewModulesCollection:  @getViewModulesCollection()
      }
    )

  getViewModulesCollection: ->
    @_vmsCollection or= new (require('./collections/view_modules_collection'))([], {
      context: @context
    })

  getMainViewClass: ->
    require('./views/main_view')

  getMainViewOptions: ->
    _.extend(super(), {
      model:      @getDashboardConfig()
      collection: @getCardsCollection()
    })