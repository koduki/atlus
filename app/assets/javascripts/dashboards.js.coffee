# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(() ->
  window.updateOrder = () ->
    url = location.href.replace(/.*dashboards/, "/dashboards/")
    orders = $(".item article.snipet input.name").map((i, x) -> $(x).val()).toArray()
    $.ajax(
      type: "PUT"
      url: url
      data: '{"orders":"' + orders.toString() + '"}'
      contentType:"application/json; charset=utf-8"
      dataType:'json'
      success: (msg) -> console.log("update order success.")
    )
  reorder = () ->
    ul = $("ul#jquery-ui-sortable.ui-sortable")
    orders = $("#snipets_orders").val().split(",")
    items = orders.map((x, i) -> $(".item").has("article.snipet input.name[value='" + x + "']").parent())
    for i in items
      ul.append(items[i])

  $( '#jquery-ui-sortable' ).sortable()
  $( '#jquery-ui-sortable' ).disableSelection()
 
  $("div.item").map((i, x) ->
    snipet = $(x)
    snipet.load(snipet.text() + " article", (res) ->
      $(".snipet").map((i, x) -> window.Chart.load($(x)))
      $(".hidden").map((i, x) -> $(x).css("display", "none"))
      reorder()
    )
  )


)
