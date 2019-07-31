json.extract! receive_email, :id, :name, :phone, :message, :vehicle, :price, :year, :link_vehicle, :brand_vehicle, :model_vehicle, :kilometer_vehicle, :accessories_vehicle, :created_at, :updated_at
json.url receive_email_url(receive_email, format: :json)
