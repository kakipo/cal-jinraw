module ApplicationHelper

  def simple_datetime(dt)
    return if dt.blank?
    # dt.strftime("%Y-%m-%d(#{%w(日 月 火 水 木 金 土)[dt.wday]})") 
    dt.strftime("%H:%M")
  end
end
