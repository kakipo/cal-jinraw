json.array!(@events) do |event|
  json.extract! event, :id, :url, :event_date, :title, :place, :address, :price, :capacity, :description
  json.url event_url(event, format: :json)
end
