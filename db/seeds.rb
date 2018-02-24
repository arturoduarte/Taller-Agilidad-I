# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.destroy_all

# urls = ['technics', 'business', 'sports', 'transport' ]
urls = ['technics' ]


5.times do
	Product.create(
		code: Faker::Commerce.promotion_code,
		name: Faker::Commerce.product_name,
		description: Faker::Lorem.paragraphs(1),
		price: Faker::Commerce.price.to_i,
		stock: Random.rand(60...100),
		stock_minimum: Random.rand(20...30),
		tax: [0,5,10].sample,
		remote_image_url: "https://lorempixel.com/500/400/"
		# remote_image_url: "https://lorempixel.com/500/400/#{urls.sample}/"
		# remote_image_url: Faker::LoremPixel.image("500x400", false, urls.sample)
	)
end