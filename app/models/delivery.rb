class Delivery < ApplicationRecord
  belongs_to :order_detail
end
