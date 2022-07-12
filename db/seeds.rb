# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
JwtDenylist.destroy_all
Restaurant.destroy_all
Address.destroy_all

user = User.new(
  email: "kipo.cto@gmail.com",
  password: "Azerty77"
)

# # binding.pry

if user.valid? 
  user.save
  puts "user #{user.email} was created!"
else
  puts user.errors
end


puts "-----------------------"
puts "-------- USERS --------"
puts "-----------------------"

users = (1..5).map do
  email = Faker::Internet.email
  puts "User email: #{email}"
  user = User.new(
    email: email,
    password: "Azerty11"
  )
  if user.valid?
    user.save
    puts "#{email} created!"
  else
    puts "#{email} can't be created - #{email.errors }!"
  end
end

puts "-----------------------"
puts "----- RESTAURANTS -----"
puts "-----------------------"

restaurants = (1..200).map do
  name = Faker::Restaurant.name
  restaurant = Restaurant.new(
    name: name,
    user_id: User.all.sample.id
  )
  if restaurant.valid?
    restaurant.save
    puts "#{restaurant.name} created!"
  else
    puts "#{restaurant.name} can't be created - #{restaurant.errors }!"
  end
  # puts "#{restaurant.name} was created!" if restaurant.valid?
end

puts "-----------------------"
puts "------ ADDRESSES ------"
puts "-----------------------"
List = [75001, 75002, 75003, 75004, 75005, 75006, 75007, 75008, 75009, 75010, 75011, 75012, 75013, 75014, 75015, 75016, 75017, 75018, 75019, 75020]

first_restaurant = Restaurant.first.id
addresses = (1..200).map do
  address = Address.new(
    street: Faker::Address.street_name,
    zipcode: List.sample,
    town: Faker::Address.city,
    country: Faker::Address.country,
    restaurant_id: first_restaurant
  )
  if address.valid?
    address.save
    puts "restaurant address created!"
    first_restaurant += 1
  else
    puts "------------------"
    puts "#{address.valid?}"
    puts "------------------"
    puts "ERROR restaurant address - #{address.errors}
    
      zipcode: #{address.errors["zipcode"] } - #{address.zipcode} / 
      street:  #{address.errors["street"] } - #{address.street} / 
      town:  #{address.errors["town"] } - #{address.town} /
      country  #{address.errors["country"] } - #{address.country} !"
  end
end

puts Restaurant.all.count
puts Address.all.count