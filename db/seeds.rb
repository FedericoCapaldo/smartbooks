# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new(name: "Anna Bella", email: "anna@email.com", school: "ucla", password: "Anna11", password_confirmation: "Anna11")
User.new(name: "Michael Hartl", email: "michael@email.com", school: "uci", password: "Michael1", password_confirmation: "Micheal1")
User.new(name: "John Long", email: "john@email.com", school: "uci", password: "John1", password_confirmation: "John1")
