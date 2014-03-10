FactoryGirl.define do
  factory :event do
    url "http://hoge.com"
    title "hoge"
    place "hogehogehoge"
    address "aaaaaaa"
    price 1000
    capacity 10
    event_date Date.today
  end
end