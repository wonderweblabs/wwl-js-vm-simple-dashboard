module.exports = class SimpleDashboardVm extends require('wwl-js-vm').VM

  initialize: (options) ->
    @options = options

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
      collection: @getCardsCollection()
    })