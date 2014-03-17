# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.kufu = {}
window.kufu.cal = {}

kufu.IMG_BASE_URL = "assets"


# カレンダーアイコンの設定
# $eventDOMs: jQuery Objects on a day
kufu.cal.createIconClasses = ($eventDOMs) ->
  classNames = []

  for iconName in ["facebook", "mixi", "twipla", "tweetvite", "dummy"]
    if 0 < $eventDOMs.filter("[data-icon-type=" + iconName + "]").size()
      classNames.push("js-datepicker-icon-" + iconName)

  return classNames

# カレンダーアイコン、色付けの実行
# kufu.cal.createIconClasses で設定された class を目印に
# アイコンを data-css-background-image に設定する
kufu.cal.setIcons = () ->
  # アイコンの設定
  $(".js-datepicker-icon-facebook").each(()->
    kufu.cal.replaceBGImg($(this), "left", "icon-facebook")
  )
  $(".js-datepicker-icon-mixi").each(()->
    kufu.cal.replaceBGImg($(this), "left", "icon-mixi")
  )
  $(".js-datepicker-icon-dummy").each(()->
    kufu.cal.replaceBGImg($(this), "center", "icon-dummy")
  )

# Android OS 2.3.X 対応
#   $(...).css("background-image") で複数指定した値を取得した際に、
#   最初の値のみしか取得できない問題への対応
# data-css-background-image の値を更新する
kufu.cal.replaceBGImg = ($dom, position, iconName) ->
  bg = $dom.find("a").attr("data-css-background-image")
  $dom.find("a").attr("data-css-background-image", bg.replace("dummy-#{position}", iconName))


# イベント一覧エリアの描画
# 一度初期化し、指定の日付の情報を取得、設定する
#
# selectedDate: yyyy-mm-dd
kufu.cal.drawCalList = (selectedDate) ->
  $("#eventList ul li").addClass("hidden")
  $("#eventList ul li.ed-" + selectedDate).removeClass("hidden")






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


  # カレンダーの設定
  do () ->
    $("#cal").datepicker({
      showOtherMonths: true,
      selectOtherMonths: true,
      onChangeMonthYear: (year, month, ui) ->
        # 初日を選択状態とする
        fmtMonth = (if month < 10 then "0#{month}" else month)
        if ui.drawMonth != ui.currentMonth
          $(this).datepicker('setDate', "#{year}/#{fmtMonth}/01")
      ,
      onSelect: (selectedDate, ui) ->
        $("#date_val").html(selectedDate + "のイベント")
        if ui.drawMonth < ui.currentMonth
          $(this).find(".ui-datepicker-next").click()
        else if ui.currentMonth < ui.drawMonth
          $(this).find(".ui-datepicker-prev").click()

        fmtDate = selectedDate.replace(/\//g, "-")
        kufu.cal.drawCalList(fmtDate)
      ,
      beforeShowDay: (date) ->
        classNames = []
        if date.getDay() == 0
          # 日曜日
          classNames.push("ui-datepicker-sunday_feteday")
        else if date.getDay() == 1
          classNames.push("icon-facebook")
        else if date.getDay() == 6
            # 土曜日
          classNames.push("ui-datepicker-saturday")

        fmtDate = $.format.date(date, 'yyyy-MM-dd')
        $eventDOMs = $("#eventList li.ed-#{fmtDate}")

        classNames = classNames.concat(kufu.cal.createIconClasses($eventDOMs))

        return [true, classNames.join(" ")];
      ,
      afterShow: () ->
        console.log "afterShow"
        # Android OS 2.3.X 対応
        #   $(...).css("background-image") で複数指定した値を取得した際に、
        #   最初の値のみしか取得できない問題への対応
        $dates = $(".ui-datepicker-calendar td a.ui-state-default")
        $dates.attr("data-css-background-image", "url(\"#{kufu.IMG_BASE_URL}/dummy-left.png\"), url(\"#{kufu.IMG_BASE_URL}/dummy-center.png\"), url(\"#{kufu.IMG_BASE_URL}/dummy-right.png\")")

        kufu.cal.setIcons()

        $dates.each(() ->
          bg = $(this).attr("data-css-background-image")
          $(this).css("background-image", bg)
        )
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



