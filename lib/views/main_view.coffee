module.exports = class MainView extends require('backbone.marionette').CompositeView

  className: 'wwl-js-vm-simple-dashboard'

  template: require('../tpl/main_view.hamlc')

  childView: require('./card_view')

  childViewContainer: '.cards-container'

  childViewOptions: (model, index) ->
    context:          @getOption('context')
    dashboardConfig:  @getOption('model')