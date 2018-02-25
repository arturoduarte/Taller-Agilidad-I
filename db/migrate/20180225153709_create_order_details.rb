class CreateOrderDetails < ActiveRecord::Migration[5.1]
	def change
		create_table :order_details do |t|
			t.integer :quantity, default: 0
			t.float :price, precision: 10, scale: 2
			t.boolean :delivered, default: false
			t.references :order, foreign_key: true
			t.references :product, foreign_key: true

			t.timestamps
		end
	end
end
