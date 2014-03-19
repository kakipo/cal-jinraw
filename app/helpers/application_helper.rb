module ApplicationHelper

  def simple_datetime(dt)
    return if dt.blank?
    # dt.strftime("%Y-%m-%d(#{%w(日 月 火 水 木 金 土)[dt.wday]})") 
    dt.strftime("%H:%M")
  end

  def fa_tag(class_name)
    content_tag(:i, "", class: "fa #{class_name}")
  end

  def icon_type(url)
    host = URI.parse(url).host
    ret = "dummy"
    ["facebook", "mixi", "twipla", "tweetvite"].each do |h|
      if host.include?(h)
        ret = h
        break
      end
    end
    ret
  end

  def price_range_ids(price)
    ret = "0"
    case price
    when 0..1000
      ret = "3 2 1"
    when 0..2000
      ret = "3 2"
    when 0..3000
      ret = "3"
    else
      ret = "N/A"
    end
    ret
  end

end
