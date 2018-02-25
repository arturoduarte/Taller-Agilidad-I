class Product < ApplicationRecord
	mount_uploader :image, ImageUploader
	has_many :order_details
	has_many :orders, through: :order_details

end
