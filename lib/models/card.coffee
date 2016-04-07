_ = require('underscore')

module.exports = class Card extends require('backbone').Model

  defaults:
    animation_type:     'fade'
    animation_duration: 1
    box_x:              0
    box_y:              0
    box_width:          1
    box_height:         1

  sync: ->
    null

  constructor: (attrs, options) ->
    @context                = options.context
    @viewModulesCollection  = options.viewModulesCollection

    attrs.id = _.uniqueId('wwl-js-vm-simple-dashboard-card')
    @id      = attrs.id

    super(attrs, options)

  getCollection: =>
    @_collection or= new (require('backbone-virtual-collection'))(@viewModulesCollection, {
      filter: (vm) => vm.get('cardId') == @id
    })

  parse: (response, options) ->
    data =
      box_x:      response.box.x
      box_y:      response.box.y
      box_width:  response.box.width
      box_height: response.box.height

    if _.isObject(response.animation)
      data.animation_type     = response.animation.type if _.isString(response.animation.type)
      data.animation_duration = response.animation.duration if _.isNumber(response.animation.duration)

    data.vms or= []
    data.vms = [data.vms] unless _.isArray(data.vms)

    _.each response.vms, (vmCfg) => vmCfg.cardId = @id

    @viewModulesCollection.add(response.vms, { merge: true, add: true, remove: false })

    data
