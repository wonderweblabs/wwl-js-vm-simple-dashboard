module.exports = class MainView extends require('backbone.marionette').CompositeView

  template: require('../tpl/main_view.hamlc')

  childView: require('./card_view')

  childViewContainer: '.cards-container'