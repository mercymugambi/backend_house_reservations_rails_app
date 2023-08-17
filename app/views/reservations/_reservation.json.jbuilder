json.extract! reservation, :id, :city, :reservation_date, :user_id, :house_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
