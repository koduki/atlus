# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.Chart = {}

$(() -> 
  $(".snipet").map((i, x) -> window.Chart.load($(x)))
  $(".hidden").map((i, x) -> $(x).css("display", "none"))
)
window.Chart.load = (snipet) ->
  target = snipet.find("table").first()
  container = snipet.find(".container")[0]
  type = snipet.find(".chartType").val()
  scale = snipet.find(".scale").val()
  switch type
    when "pi" then pi(target, container)
    when "line" then line(target, container, scale)
    when "horizonBar" then horizonBar(target, container)

horizonBar = (target, container) ->
  takeData = (xs) ->
    (xs.slice(1).map((i, x) ->
      parseFloat x
    )).toArray()
 
  items = $(target.find("tr").get().reverse()).map((i, x) ->
    $(x).find("td").map (i, x) ->
      $(x).text()
  ).map((i, x) ->
    index: i
    label: x[0]
    data: takeData(x)
  ).toArray()

  ticks = items.map((x) ->
    [ x["index"], x["label"] ]
  )

  data = items.map((x) ->
    [ [ x["data"][0], x["index"] ] ]
  )

  Flotr.draw container, data,
    bars:
      show: true
      horizontal: true
      shadowSize: 0
      barWidth: 0.5

    mouse:
      track: true
      relative: true

    xaxis:
      min: 0
      autoscaleMargin: 1
      showLabels: true
      showMinorLabels: true

    yaxis:
      showLabels: true
      min: 0
      ticks: ticks
      autoscaleMargin: 1


pi = (target, container) ->
  data = target.find("tr").map((i, x) ->
    td = $(x).find("td")
    label: td.eq(0).text()
    data: [ [ 0, parseFloat(td.eq(1).text()) ] ]
  )
  graph = Flotr.draw(container, data,
    HtmlText: false
    grid:
      verticalLines: false
      horizontalLines: false

    xaxis:
      showLabels: false

    yaxis:
      showLabels: false

    pie:
      show: true
      explode: 6

    mouse:
      track: true

    legend:
      position: "se"
      backgroundColor: "#D2E8FF"
  )
line = (target, container, scale) ->
  items = target.find("tr").map((i, x) ->
    $(x).find("td").map (i, x) ->
      $(x).text()
  ).map((i, x) ->
    index: i
    label: x[0]
    data: parseFloat(x[1])
  )

  data = items.map((i, x) ->
    [ [ x.index, x.data ] ]
  ).toArray()

  labels = items.map((i, x) ->
    if (i % scale == 0)
      [ [ x.index, x.label ] ]
    else
      [ [ x.index, "" ] ]
  ).toArray()

  graph = Flotr.draw(container, [ data ],
    parseFloat: true
    xaxis:
      minorTickFreq: 4
      showLabels: true
      min: 0
      ticks: labels

    yaxis:
      minorTickFreq: 4
      min: 0

    grid:
      minorVerticalLines: true
  )

initAceEditor = ->
  raw_editor = $("#snipet_query").eq(0)
  raw_editor.css "display", "none"

  $("#query").css("width", raw_editor.width()) + "px"
  $("#query").css("height", raw_editor.height()) + "px"
  $("#query").text raw_editor.text()

  editor = ace.edit("query")
  editor.setTheme "ace/theme/twilight"
  RubyMode = require("ace/mode/ruby").Mode
  editor.getSession().setMode new RubyMode()

  submit = $("form.edit_snipet input[type='submit']").eq(0)
  submit.click ->
    raw_editor.text editor.getSession().getValue()
