Template.hoursAdder.onCreated ->
  @timeInputsCnt = new ReactiveVar 1
  @totalTime = new ReactiveVar 0

Template.hoursAdder.helpers
  countOfTimeInputs: ->
    cntArr = []
    i = 0
    while i < Template.instance().timeInputsCnt.get()
      cntArr.push i++
    cntArr
  removeInputActiveIsActive: ->
    Template.instance().timeInputsCnt.get() > 1
  totalTime: ->
    Template.instance().totalTime.get()

Template.hoursAdder.events
  'click #addInput': (e, tmpl) ->
    reactTimeInputsCnt = tmpl.timeInputsCnt
    reactTimeInputsCnt.set (reactTimeInputsCnt.get() + 1)
  'click #removeInput': (e, tmpl) ->
    reactTimeInputsCnt = tmpl.timeInputsCnt
    reactTimeInputsCnt.set (reactTimeInputsCnt.get() - 1)
  'click #count': (e, tmpl) ->
    totalMins = 0
    timeInputs = $.find(".timeInput")
    _.each timeInputs, (timeInput) ->
      hours = +$(timeInput).find("#hours").val()
      mins = +$(timeInput).find("#mins").val()
      totalMins += hours * 60 + mins

    hours = Math.floor (totalMins / 60)
    if hours < 10
      hours = '0' + hours
    mins = totalMins % 60
    if mins < 10
      mins = '0' + mins
    tmpl.totalTime.set("#{hours}:#{mins}")