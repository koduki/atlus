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

  switch type
    when "pi" then pi(target, container)
    when "line" then line(target, container)
    when "horizonBar" then horizonBar(target, container)

horizonBar = (target, container) ->
  takeData = (xs) ->
    (xs.slice(1).map((i, x) ->
      parseInt x
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
    data: [ [ 0, parseInt(td.eq(1).text()) ] ]
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

line = (target, container) ->
  items = target.find("tr").map((i, x) ->
    $(x).find("td").map (i, x) ->
      $(x).text()
  ).map((i, x) ->
    index: i
    label: x[0]
    data: parseInt(x[1])
  )

  data = items.map((i, x) ->
    [ [ x.index, x.data ] ]
  ).toArray()

  labels = items.map((i, x) ->
    [ [ x.index, x.label ] ]
  ).toArray()

  graph = Flotr.draw(container, [ data ],
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
