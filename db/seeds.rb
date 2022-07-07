# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

user = User.new(
  email: "kipo.cto@gmail.com",
  password: "Azerty77"
)

# binding.pry

if user.valid? 
  user.save
  puts "user #{user.email} was created!"
else
  puts user.errors
end