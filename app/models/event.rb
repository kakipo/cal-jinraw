class Event < ActiveRecord::Base

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  before_save   :set_cat_flags

  validates :url,
    presence: true,
    url: true,
    length: { maximum: 2000 }

  validates :title,
    presence: true,
    length: { maximum: 30 }

  validates :start_at, 
    presence: true,
    timeliness: {
      :on_or_after => '1984/07/23',
      :on_or_before => '2084/07/23',
      :type => :datetime
    }

  validates :end_at, 
    timeliness: {
      :allow_blank => true,
      :on_or_after => :start_at,
      :on_or_before => '2084/07/23',
      :type => :datetime
    }

  validates :place,
    presence: true,
    length: { maximum: 50 }

  validates :prefecture,
    presence: true

  validates :address,
    presence: true,
    length: { maximum: 100 }

  validates :price,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 999999
    }

  validates :capacity,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 999
    }

  def set_cat_flags
    self.cat_weekday_flg = !self.is_holiday?
    self.cat_holiday_flg = self.is_holiday?
    self.cat_allnight_flg = self.is_allnight?
  end

  def is_holiday?
    self.start_at.saturday? or self.start_at.sunday? or self.start_at.to_date.national_holiday?
  end

  # オールナイトイベント？
  def is_allnight?
    return false if self.end_at.blank?

    is_over_day = ((self.end_at.midnight - self.start_at.midnight).to_i / 1.day) > 0
    start_at_midnight = self.start_at < self.start_at.midnight + 4.hour

    return (is_over_day or start_at_midnight)
  end

end
