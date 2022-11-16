# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
FriendRequest.destroy_all

p "Deleted all users and friend requests"

(10).times do User.create!([{
  email: Faker::Internet.email,
  name: Faker::Name.name,
  provider: rand(2) == 0 ? "Facebook" : "",
  uid: rand(999999),
  password: "xxxxxx"
}])
end

p "Created #{User.count} users"

ids = User.all.map{ |u| u.id }
ids.each do |id|
Post.create!([{
  body: Faker::Lorem.words(number: rand(2..10)).join(' '),
  user_id: id
}])
Post.create!([{
  body: Faker::Lorem.words(number: rand(2..10)).join(' '),
  user_id: id
}])
end

p "Created #{Post.count} posts"
