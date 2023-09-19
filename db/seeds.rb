# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(email: 'admin@example.com', password: 'theadmin2020', password_confirmation: 'theadmin2020')
30.times do
  Course.create!([{
    title: Faker::Fantasy::Tolkien.poem,
    description: Faker::Games::Fallout.quote,
    user_id: User.first.id
  }])
end