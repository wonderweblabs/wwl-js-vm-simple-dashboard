module.exports = class ViewModule extends require('backbone').Model

  defaults:
    cardId:                   null
    vmPrototype:              null
    vmConfig:                 null
    duration:                 null
    fetchTriggerEachMinutes:  null

  sync: ->
    null

  initialize: (attrs, options) ->
    super(attrs, options)

    @context = options.context

    @listenTo @, 'destroy', @onDestroy

  getVM: ->
    @_vm or= @_buildVM()

  getView: ->
    @getVM().getView()

  onDestroy: ->
    @_vm.stop() if @_vm
    @_vm = null


  # ---------------------------------------------
  # private

  # @nodoc
  _buildVM: ->
    vm = new (@get('vmPrototype'))(_.extend(@get('vmConfig') || {}, { context: @context }))
    setTimeout => vm.start()
    vm

