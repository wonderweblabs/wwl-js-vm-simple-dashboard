module.exports = class ViewModulesCollection extends require('backbone').Collection

  model: require('../models/view_module')

  initialize: (models, options) ->
    super(models, options)

    @context = options.context

  sync: ->
    null


  # ---------------------------------------------
  # private methods

  # @nodoc
  _prepareModel: (attrs, options = {}) =>
    options.context = @context

    super(attrs, options)