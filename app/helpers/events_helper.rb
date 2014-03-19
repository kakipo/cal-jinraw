module EventsHelper

  def my_event?(event)
    event.session_id == request.session_options[:id]
  end

  def str_categories(event)
    t_event = I18n.t("activerecord.attributes.event")
    arr = []
    arr << t_event[:cat_beginner_flg] if event.cat_beginner_flg
    arr << t_event[:cat_pro_flg] if event.cat_pro_flg
    arr << t_event[:cat_weekday_flg] if event.cat_weekday_flg
    arr << t_event[:cat_holiday_flg] if event.cat_holiday_flg
    arr << t_event[:cat_allnight_flg] if event.cat_allnight_flg
    arr.join("/")
  end

end
