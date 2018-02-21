class CreateProducts < ActiveRecord::Migration[5.1]
	def change
		create_table :products do |t|
			t.string :code
			t.string :name
			t.text :description
			t.float :price, precision: 10, scale: 2
			t.integer :stock
			t.string :stock_minimum
			t.integer :tax
			t.string :image

			t.timestamps
		end
	end
end
