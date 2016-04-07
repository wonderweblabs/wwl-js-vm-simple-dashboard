module.exports = (moduleConfig) ->

  simpleDashboard = require('../lib/index')

  moduleConfig.columns  = 12
  moduleConfig.rows     = 6
  moduleConfig.cards    = [{
    box:
      x:      0
      y:      0
      width:  4
      height: 2
    vms: [{
      vmPrototype:  simpleDashboard.DateTimeCardVM
      vmConfig:     {}
    }]
  }, {
    box:
      x:      4
      y:      0
      width:  8
      height: 2
    vms: [{
      vmPrototype:  simpleDashboard.AlertCardVM
      vmConfig:
        title:    'Important information for everyone'
        message:  'Quisque lobortis massa purus, eget dictum dolor cursus id. Proin luctus eros accumsan quam viverra, nec luctus arcu faucibus. Maecenas auctor massa lorem, ut ornare purus molestie blandit.'
      fetchTriggerEachMinutes: 10
    }]
  }, {
    box:
      x:      0
      y:      2
      width:  3
      height: 3
    animation:
      type:     'fade'
      duration: 1
    vms: [{
      vmPrototype:  simpleDashboard.AlertCardVM
      vmConfig:
        message: 'Quisque lobortis massa purus, eget dictum dolor cursus id. Proin luctus eros accumsan quam viverra, nec luctus arcu faucibus. Maecenas auctor massa lorem, ut ornare purus molestie blandit.'
      duration:     3
    }, {
      vmPrototype:  simpleDashboard.DateTimeCardVM
      vmConfig:     {}
      duration:     5
    }]
  }]