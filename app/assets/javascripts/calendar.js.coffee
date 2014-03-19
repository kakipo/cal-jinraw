window.kufu = {}
window.kufu.cal = {}

kufu.IMG_BASE_URL = "assets"

# 絞込保存用のキー
kufu.cal.FILTER_KEY_PLACE = "filter_key_place"
kufu.cal.FILTER_KEY_PRICE_RANGE = "filter_key_price_range"
kufu.cal.FILTER_KEY_BEGINNER_FLG = "filter_key_beginner_flg"
kufu.cal.FILTER_KEY_PRO_FLG = "filter_key_pro_flg"
kufu.cal.FILTER_KEY_WEEKDAY_FLG = "filter_key_weekday_flg"
kufu.cal.FILTER_KEY_HOLIDAY_FLG = "filter_key_holiday_flg"
kufu.cal.FILTER_KEY_ALLNIGHT_FLG = "filter_key_allnight_flg"

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
#
# selectedDate: yyyy-mm-dd
kufu.cal.drawCalList = (selectedDate) ->
  $("#date_val").html(selectedDate + "のイベント")
  $("#eventList ul li").addClass("hidden")
  $("#eventList ul li.ed-" + selectedDate + "[data-filtered=false]").removeClass("hidden")


# カレンダーの初期化
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
