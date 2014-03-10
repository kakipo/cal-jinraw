class Event < ActiveRecord::Base

  validates :url,
    presence: true,
    url: true,
    length: { maximum: 2000 }

  validates :title,
    presence: true,
    length: { maximum: 30 }

  validates :event_date, 
    timeliness: {
      :on_or_after => lambda { Date.current }, 
      :type => :date
    }

  validates :place,
    presence: true,
    length: { maximum: 50 }

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



end
