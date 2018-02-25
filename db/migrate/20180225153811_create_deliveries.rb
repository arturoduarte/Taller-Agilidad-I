class CreateDeliveries < ActiveRecord::Migration[5.1]
	def change
		create_table :deliveries do |t|
			t.datetime :date_delivery, default: nil
			t.text :observation, default: nil
			t.references :order_detail, foreign_key: true

			t.timestamps
		end
	end
end
