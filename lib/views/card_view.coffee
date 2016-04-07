module.exports = class CardView extends require('backbone.marionette').LayoutView

  template: require('../tpl/card_view.hamlc')

  regions:
    vmContainer: '> .vm-container'

  onRender: =>
    if @model.getCollection().any()
      @getRegion('vmContainer').show(@model.getCollection().first().getView())
