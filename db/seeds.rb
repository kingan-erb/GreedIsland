# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :ja
greeds = ["金", "癒", "力", "食", "愛"]
images = ["1", "2", "3", "4", "5"]
greeds.zip(images).each do |greed, image|
	Greed.create!(greed_type: greed,
				  greed_image_name: File.open("./app/assets/images/#{image}.jpg")
				)
end

50.times do |n|
	gimei = Gimei.name
	email = Faker::Internet.email
	phone_number = Faker::PhoneNumber.subscriber_number(11)
	greed_id = rand(1..5)
	payment_method = rand(1..2)
	User.create!(email: email,
				password:"111111",
				password_confirmation:"111111",
				last_name: gimei.last.kanji,
				first_name: gimei.first.kanji ,
				last_name_kana: gimei.last.katakana,
				first_name_kana: gimei.first.katakana,
				phone_number: phone_number,
				greed_id: greed_id,
				payment_method: "#{payment_method}",
				)

	address = Gimei.address
	postal_code = Faker::Number.number(7)
	Address.create!(user_id: "#{n+1}",
					postal_code: postal_code,
					address: address.kanji,
					)

	artist_name = Faker::Name.name
	product_name = Faker::Music.album
	image = rand(1..5)
	price = rand (400..3000)
	inventry_status = rand(1..100)
	label_name = rand(0..4)
	Product.create!(product_image_name: File.open("./app/assets/images/#{image}.jpg"),
					greed_id: greed_id,
					artist_name: artist_name,
					product_name: product_name,
					label_name: label_name,
					genre_name: label_name,
					price: price,
					inventry_status: inventry_status,
					)
	order_datetime = Faker::Date.backward(30)
	payment_method = rand(1..2)
	delivery_date = Faker::Date.forward(3)
	delivery_time = rand(1..3)
	Order.create!(order_datetime: order_datetime,
					payment_method: payment_method,
					delivery_date: delivery_date,
					delivery_time: delivery_time,
					postal_code: postal_code,
					delivery_address: address.kanji,
					delivery_status: delivery_time,
					user_id: "#{n+1}",
					total_price: price,
					)
end
500.times do |n|
	music_name = Faker::Music.album
	disk_number = rand(1..3)
	product_id = rand(1..50)
	Music.create!(music_name: music_name,
				  disk_number: disk_number,
				  product_id: product_id,
				  )
end




