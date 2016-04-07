global.$                          = require('jquery')
global.jquery                     = global.jQuery = global.$
global._                          = require 'underscore'
global.underscore                 = global._
global.Backbone                   = require 'backbone'
global.backbone                   = global.Backbone
global.Backbone.$                 = $

require('backbone.marionette').Renderer.render = (template, data) ->
  tpl = require('backbone.marionette').TemplateCache.get(template)
  if require('underscore').isFunction(tpl) then tpl(data) else template

require('backbone.marionette').TemplateCache.prototype.compileTemplate = (rawTemplate, options) ->
  return rawTemplate

require('backbone.marionette').TemplateCache.prototype.loadTemplate = (templateId, options) =>
  templateId

domready    = require 'domready'
wwlContext  = require 'wwl-js-app-context'

domready ->
  tester = new (require('wwl-js-vm')).Tester({

    domElementId: 'wwl-js-vm-tester-container'

    config:
      getDefaultVMConfig: ->
        context: new (wwlContext)({ root: true })

    vmConfig:

      vmPrototype: require('../lib/vm')

      beforeInititalize: require('./cards_config')

      beforeStart: (vm, moduleConfig) ->
        vm.getView().triggerMethod 'attach'
        vm.getView().triggerMethod 'show'

        window.vm = vm


  }).run()
