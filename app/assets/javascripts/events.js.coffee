# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on("ready pjax:success", () ->

  do () ->
    $(".aboutBtn").colorbox({
      returnFocus:false,
      inline:true,
      width:"98%"
    })

    $(".searchBtn").colorbox({
      returnFocus:false,
      inline:true,
      width:"98%"
    })

    $(".addEventBtn").colorbox({
      returnFocus:false,
      inline:true,
      width:"98%"
    })

    $(".eventDetail").colorbox({
      returnFocus:false,
      inline:true,
      width:"98%"
    })

  do () ->
    $("#cal").datepicker({
        onSelect: (dateText, inst) ->
          $("#date_val").html(dateText + "のイベント")
      })

  do () ->
    $(document)
      .on('ajax:success', 'form', (data, res, xhr) ->
        # console.log res
        $('body').html(res)
      )
      .on('ajax:fail', 'form', (data, res, xhr) ->
        # console.log res
        $('body').html(res)
      )
) # end of onready function



