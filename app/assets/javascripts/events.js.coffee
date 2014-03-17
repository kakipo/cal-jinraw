# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.kufu = {}
window.kufu.cal = {}

kufu.IMG_BASE_URL = "assets"


# date 取得用関数
kufu.cal.getSelectedDate = () ->
  $.format.date($('#cal').datepicker('getDate'), 'yyyy-MM-dd')

# カレンダーアイコンの設定
# $eventDOMs: jQuery Objects on a day
kufu.cal.createIconClasses = ($eventDOMs) ->
  classNames = []

  # left
  if 1 <= $eventDOMs.size()
    iconName = $eventDOMs.eq(0).attr("data-icon-type")
    classNames.push("js-datepicker-left-icon-" + iconName)
  # center
  if 2 <= $eventDOMs.size()
    iconName = $eventDOMs.eq(1).attr("data-icon-type")
    classNames.push("js-datepicker-center-icon-" + iconName)
  # right
  if 3 == $eventDOMs.size()
    iconName = $eventDOMs.eq(2).attr("data-icon-type")
    classNames.push("js-datepicker-right-icon-" + iconName)

  if 3 < $eventDOMs.size()
    classNames.push("js-datepicker-right-icon-plus")

  return classNames

# カレンダーアイコン、色付けの実行
# kufu.cal.createIconClasses で設定された class を目印に
# アイコンを data-css-background-image に設定する
kufu.cal.setIcons = () ->
  # アイコンの設定
  for pos in ["left", "center", "right"]
    for iconName in ["facebook", "mixi", "twipla", "tweetvite", "dummy", "plus"]
      $(".js-datepicker-#{pos}-icon-#{iconName}").each(()->
        kufu.cal.replaceBGImg($(this), pos, "icon-#{iconName}")
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
  $("#date_val").html(selectedDate + "のイベント")
  $("#eventList ul li").addClass("hidden")
  $("#eventList ul li.ed-" + selectedDate + "[data-filtered=false]").removeClass("hidden")


# カレンダーの設定
kufu.cal.initDatepicker = () ->
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
     
      if ui.drawMonth < ui.currentMonth
        $(this).find(".ui-datepicker-next").click()
      else if ui.currentMonth < ui.drawMonth
        $(this).find(".ui-datepicker-prev").click()

      fmtDate = selectedDate.replace(/\//g, "-")
      kufu.cal.drawCalList(fmtDate)
    ,
    beforeShowDay: (date) ->
      console.log "beforeShowDay"
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

      $eventDOMs = $("#eventList li.ed-#{fmtDate}[data-filtered=false]")

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

      # 描画
      d = kufu.cal.getSelectedDate()
      kufu.cal.drawCalList(d)
  })





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
    kufu.cal.initDatepicker()

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


  # 絞込フォームの設定
  do () ->
    $("#js-do-filter").click(()->

      # 絞込の実施
      prefId = $("#js-filter-pref-id").val()
      priceRangeId = $("#js-filter-price-range-id").val()
      beginnerFlg = $("#js-filter-beginner-flg").prop("checked")
      proFlg = $("#js-filter-pro-flg").prop("checked")
      weekdayFlg = $("#js-filter-weekday-flg").prop("checked")
      holidayFlg = $("#js-filter-holiday-flg").prop("checked")
      allnightFlg = $("#js-filter-allnight-flg").prop("checked")

      $("#eventList ul li").attr("data-filtered", true)
      $available = $("#eventList ul li")

      unless prefId == "na"
        $available = $available.filter("[data-pref-id=" + prefId + "]")
      unless priceRangeId == "na"
        $available = $available.filter("[data-price-range-id=" + priceRangeId + "]")
      if beginnerFlg
        $available = $available.filter("[data-beginner-flg=" + beginnerFlg + "]")
      if proFlg
        $available = $available.filter("[data-pro-flg=" + proFlg + "]")
      if weekdayFlg
        $available = $available.filter("[data-weekday-flg=" + weekdayFlg + "]")
      if holidayFlg
        $available = $available.filter("[data-holiday-flg=" + holidayFlg + "]")
      if allnightFlg
        $available = $available.filter("[data-allnight-flg=" + allnightFlg + "]")

      # 絞込条件の表示
      prefTxt = $("#js-filter-pref-id option:selected").text()
      priceRangeTxt = $("#js-filter-price-range-id option:selected").text()
      $("#search-cond-container span.content").text("#{prefTxt}/#{priceRangeTxt}")

      # datepicker をリフレッシュしてモーダルを閉じる
      $available.attr("data-filtered", false)
      $("#cal").datepicker("refresh")
      $("#cboxClose").click()
    )


) # end of onready function



