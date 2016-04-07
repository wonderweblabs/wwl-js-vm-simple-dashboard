module.exports = class MainView extends require('backbone.marionette').ItemView

  template: require('../tpl/main_view.hamlc')

  modelEvents:
    'change': 'render'

  templateHelpers: =>
    getFormatedTime: =>
      h = "#{@model.get('hours')}"
      h = "0#{h}" if h.length <= 1
      m = "#{@model.get('minutes')}"
      m = "0#{m}" if m.length <= 1
      s = "#{@model.get('seconds')}"
      s = "0#{s}" if s.length <= 1

      "#{h}:#{m}:#{s}"
    getFormatedDate: =>
      date = @model.get('date')

      d = "#{date.getDate()}"
      d = "0#{d}" if d.length <= 1

      m = switch date.getMonth()
        when 0 then "January"
        when 1 then "February"
        when 2 then "March"
        when 3 then "April"
        when 4 then "May"
        when 5 then "June"
        when 6 then "July"
        when 7 then "August"
        when 8 then "September"
        when 9 then "October"
        when 10 then "November"
        when 11 then "December"

      "#{d}. #{m} #{date.getFullYear()}"

