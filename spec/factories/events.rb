FactoryGirl.define do
  factory :event do
    url "http://hoge.com"
    title "hoge"
    place "hogehogehoge"
    address "aaaaaaa"
    price 1000
    capacity 10
    start_at Time.now
    end_at Time.now
  end
end