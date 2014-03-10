# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on("ready pjax:success", () ->
  do () ->
    $("#cal").datepicker({
        onSelect: (dateText, inst) ->
          $("#date_val").html(dateText+"のイベント")
      })
) # end of onready function



