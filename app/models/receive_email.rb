class ReceiveEmail < ApplicationRecord
	validates :name, :email, :phone, :message, :vehicle, :price, :year, :link_vehicle, :brand_vehicle, :model_vehicle, :kilometer_vehicle, :accessories_vehicle, presence: true
end
