module.exports = class CardsCollection extends require('backbone').Collection

  model: require('../models/card')

  initialize: (models, options) ->
    super(models, options)

    @context                = options.context
    @viewModulesCollection  = options.viewModulesCollection

  sync: ->
    null


  # ---------------------------------------------
  # private methods

  # @nodoc
  _prepareModel: (attrs, options = {}) =>
    options.context = @context
    options.parse   = true

    options.viewModulesCollection = @viewModulesCollection

    super(attrs, options)