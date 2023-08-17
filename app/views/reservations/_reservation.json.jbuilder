json.extract! reservation, :id, :city, :reservation_date, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
