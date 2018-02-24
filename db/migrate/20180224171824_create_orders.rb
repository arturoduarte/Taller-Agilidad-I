class CreateOrders < ActiveRecord::Migration[5.1]
	def change
		create_table :orders do |t|
			t.boolean :payed, default: false
			t.references :user, foreign_key: true
			t.references :product, foreign_key: true
			t.integer :quantity,  default: 0
			t.float :price, precision: 10, scale: 2
			t.timestamps
		end
	end
end
