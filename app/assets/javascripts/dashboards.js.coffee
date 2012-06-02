# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(() ->
  $( '#jquery-ui-sortable' ) . sortable();
  $( '#jquery-ui-sortable' ) . disableSelection();
 
  $("div.item").map((i, x) ->
    snipet = $(x)
    snipet.load(snipet.text() + " article", (res) ->
      $(".snipet").map((i, x) -> window.Chart.load($(x)))
      $(".hidden").map((i, x) -> $(x).css("display", "none"))
    )
  )
)
