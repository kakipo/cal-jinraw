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



  # 絞込条件を cookie に保存する
  saveFilterConditions = (prefId, priceRangeId, beginnerFlg, proFlg, weekdayFlg, holidayFlg, allnightFlg) ->

    $.cookie(kufu.cal.FILTER_KEY_PLACE, prefId, { expires: 7 });
    $.cookie(kufu.cal.FILTER_KEY_PRICE_RANGE, priceRangeId, { expires: 7 });
    $.cookie(kufu.cal.FILTER_KEY_BEGINNER_FLG, beginnerFlg, { expires: 7 });
    $.cookie(kufu.cal.FILTER_KEY_PRO_FLG, proFlg, { expires: 7 });
    $.cookie(kufu.cal.FILTER_KEY_WEEKDAY_FLG, weekdayFlg, { expires: 7 });
    $.cookie(kufu.cal.FILTER_KEY_HOLIDAY_FLG, holidayFlg, { expires: 7 });
    $.cookie(kufu.cal.FILTER_KEY_ALLNIGHT_FLG, allnightFlg, { expires: 7 });

  # 絞り込み条件を cookie からリストアする
  restoreFilterConditions = () ->

    # cookie には全て string で保存されるので
    # boolean への変換が必要
    toBool = (str) ->
      str == "true"

    prefId = $.cookie(kufu.cal.FILTER_KEY_PLACE)
    priceRangeId = $.cookie(kufu.cal.FILTER_KEY_PRICE_RANGE)
    beginnerFlg = $.cookie(kufu.cal.FILTER_KEY_BEGINNER_FLG)
    proFlg = $.cookie(kufu.cal.FILTER_KEY_PRO_FLG)
    weekdayFlg = $.cookie(kufu.cal.FILTER_KEY_WEEKDAY_FLG)
    holidayFlg = $.cookie(kufu.cal.FILTER_KEY_HOLIDAY_FLG)
    allnightFlg = $.cookie(kufu.cal.FILTER_KEY_ALLNIGHT_FLG)

    $("#js-filter-pref-id").val(prefId) if prefId?
    $("#js-filter-price-range-id").val(priceRangeId) if priceRangeId?
    $("#js-filter-beginner-flg").prop("checked", toBool(beginnerFlg)) if beginnerFlg?
    $("#js-filter-pro-flg").prop("checked", toBool(proFlg)) if proFlg?
    $("#js-filter-weekday-flg").prop("checked", toBool(weekdayFlg)) if weekdayFlg?
    $("#js-filter-holiday-flg").prop("checked", toBool(holidayFlg)) if holidayFlg?
    $("#js-filter-allnight-flg").prop("checked", toBool(allnightFlg)) if allnightFlg?

  # 絞り込み条件を表示する
  refreshFilterConditonLabel = () ->
    txtArr = []

    txtArr.push $("#js-filter-pref-id option:selected").text()
    txtArr.push $("#js-filter-price-range-id option:selected").text()

    beginnerFlg = $("#js-filter-beginner-flg").prop("checked")
    proFlg = $("#js-filter-pro-flg").prop("checked")
    weekdayFlg = $("#js-filter-weekday-flg").prop("checked")
    holidayFlg = $("#js-filter-holiday-flg").prop("checked")
    allnightFlg = $("#js-filter-allnight-flg").prop("checked")

    if beginnerFlg
      txtArr.push "初心者OK"
    if proFlg
      txtArr.push "玄人向け"
    if weekdayFlg
      txtArr.push "平日開催"
    if holidayFlg
      txtArr.push "土日・祝日開催"
    if allnightFlg
      txtArr.push "オールナイト"

    $("#search-cond-container span.content").text(txtArr.join(" / "))

  # 絞込処理の実施
  doFilterEvents = (prefId, priceRangeId, beginnerFlg, proFlg, weekdayFlg, holidayFlg, allnightFlg) ->
    $("#eventList ul li").attr("data-filtered", true)
    $available = $("#eventList ul li")

    unless prefId == "na"
      $available = $available.filter("[data-pref-id=" + prefId + "]")
    unless priceRangeId == "na"
      console.log "priceRangeId=#{priceRangeId}"
      $available = $available.filter("[data-price-range-ids~='" + priceRangeId + "']")
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

    $available.attr("data-filtered", false)
    $("#cal").datepicker("refresh")

  # 絞込フォームの設定
  do () ->
    $("#js-do-filter").click(()->

      # 絞込条件の取得
      prefId = $("#js-filter-pref-id").val()
      priceRangeId = $("#js-filter-price-range-id").val()
      beginnerFlg = $("#js-filter-beginner-flg").prop("checked")
      proFlg = $("#js-filter-pro-flg").prop("checked")
      weekdayFlg = $("#js-filter-weekday-flg").prop("checked")
      holidayFlg = $("#js-filter-holiday-flg").prop("checked")
      allnightFlg = $("#js-filter-allnight-flg").prop("checked")

      # 絞込の実施
      doFilterEvents(prefId, priceRangeId, beginnerFlg, proFlg, weekdayFlg, holidayFlg, allnightFlg)

      # 絞込条件の表示
      refreshFilterConditonLabel()

      # 絞込条件を cookie に保存
      saveFilterConditions(prefId, priceRangeId, beginnerFlg, proFlg, weekdayFlg, holidayFlg, allnightFlg)

      # モーダルを閉じる
      $("#cboxClose").click()
    )


  do () ->
    # カレンダー初期化
    kufu.cal.initDatepicker()

    # 絞込条件を復元
    restoreFilterConditions()

    # 絞込の実施
    $("#js-do-filter").click()


  # イベントが指定されている場合は開く
  do () ->
    eid = $.url().param('eid')
    $(".eventDetail[href=#event-#{eid}]").click()

  # 新規作成の場合はフォームを開く
  do () ->
    return unless $("body.events.new, body.events.create").size() == 1
    $(".addEventBtn").click()


  do () ->
    # スワイプの設定
    $("#cal").on('swipeleft', (e) ->
      $(this).find(".ui-datepicker-next").click()
    ).on('swiperight', (e) ->
      $(this).find(".ui-datepicker-prev").click()
    ).on('movestart', (e) ->
      if ((e.distX > e.distY && e.distX < -e.distY) or
          (e.distX < e.distY && e.distX > -e.distY))
        e.preventDefault();
    )


) # end of onready function
