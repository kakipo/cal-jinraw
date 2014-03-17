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
      width:"100%"
    })



  # イベントが指定されている場合は開く
  do () ->
    eid = $.url().param('eid')
    $(".eventDetail[data-id=#{eid}]").click()

  # 新規作成の場合はフォームを開く
  do () ->
    return unless $("body.events.new, body.events.create").size() == 1
    $(".addEventBtn").click()


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



