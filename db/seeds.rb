# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear old data
Comment.destroy_all
Post.destroy_all
Habit.destroy_all
Community.destroy_all
User.destroy_all

puts "Seeding users..."
# Users for Devise must have email and password
users = [
  { username: "Nathalia", email: "nathalia@example.com", password: "password" },
  { username: "Jessica", email: "jessica@example.com", password: "password" },
  { username: "Rayan", email: "rayan@example.com", password: "password" },
  { username: "Ati", email: "ati@test.com", password: "password" }
]

users.each { |user| User.create!(user) }
puts "✅ Created #{User.count} users"


puts "Seeding communities..."
communities = [
  { title: "Movement" },
  { title: "Fitness" },
  { title: "Hydration" },
  { title: "Reading" },
  { title: "Meditation" },
  { title: "Healthy Eating" },
  { title: "Gardening" }
]

communities.each { |community| Community.create!(community) }
puts "✅ Created #{Community.count} communities"

puts "Seeding habits..."
habits = [
  { title: "Walk", description: "Walk 10.000 steps per day", color: nil, streak: 1, user: User.first, community: Community.first },
  { title: "Run", description: "Run 5km per day", color: nil, streak: 0, user: User.second, community: Community.first },
  { title: "Workout", description: "Workout 1 hour, 4 times a week", color: nil, streak: 1, user: User.third, community: Community.second },
  { title: "Drink water", description: "Drink 3L of water every day", color: nil, streak: 3, user: User.fourth, community: Community.third },
  { title: "Read a book", description: "Read one book per week", color: nil, streak: 0, user: User.first, community: Community.fourth },
  { title: "Meditation", description: "Meditate 30 minutes per day", color: nil, streak: 5, user: User.second, community: Community.fifth },
  { title: "Eat healthier", description: "Eat one fruit per day", color: nil, streak: 10, user: User.third, community: Community.offset(5).first },
  { title: "Water the plants", description: "Water the plants twice a day", color: nil, streak: 6, user: User.fourth, community: Community.offset(6).first }
]

habits.each { |habit| Habit.create!(habit) }
puts "✅ Created #{Habit.count} habits"


puts "Seeding posts..."
posts = [
  { title: "Starting today", content: "Hey, I'm really happy to join the community! Looking forward to start my walking/running routine.", user: User.first, community: Community.first },
  { title: "Favorite books", content: "What are some of your favorite books? I'm looking for recommendations.", user: User.first, community: Community.fourth },
  { title: "Morning meditation", content: "I find that meditating in the morning helps me stay focused throughout the day.", user: User.second, community: Community.fifth },
  { title: "Running routine", content: "I've been trying to improve my running routine. Any tips for a beginner?", user: User.second, community: Community.second },
  { title: "Healthy recipes", content: "Does anyone have some healthy recipes to share? I'm looking for something easy to make.", user: User.third, community: Community.offset(5).first },
  { title: "I love working out", content: "Working out has become a crucial part of my routine. It helps me stay energized and focused.", user: User.third, community: Community.second },
  { title: "Watering plants", content: "I just started a small herb garden on my balcony. Any tips on how to keep them healthy?", user: User.fourth, community: Community.offset(6).first },
  { title: "Drink more water", content: "Drinking water improved a lot my energy throughout the day, it's hard to remember, but this app helps a lot!", user: User.fourth, community: Community.third }
]

posts.each { |post| Post.create!(post) }
puts "✅ Created #{Post.count} posts"

puts "Seeding comments..."
comments = [
  { content: "Welcome to the community! Good luck with your new habit!", user: User.second, post: Post.first },
  { content: "Thanks! I'm excited to get started.", user: User.first, post: Post.first },
  { content: "I love making smoothies with lots of fruits and veggies. Super easy and healthy!", user: User.third, post: Post.fifth },
  { content: "That sounds delicious! I'll have to try it out.", user: User.second, post: Post.fifth },
  { content: "I agree, morning meditation sets a positive tone for the day.", user: User.first, post: Post.third },
  { content: "For beginners, I recommend starting with short runs and gradually increasing distance.", user: User.fourth, post: Post.fourth },
  { content: "I highly recommend 'The Alchemist' by Paulo Coelho. It's a great read!", user: User.second, post: Post.second },
  { content: "Thanks for the recommendation! I'll add it to my reading list.", user: User.third, post: Post.second },
  { content: "Make sure to water your herbs in the morning to avoid evaporation during the day.", user: User.first, post: Post.offset(6).first },
  { content: "Great tip! I'll try that out.", user: User.fourth, post: Post.offset(6).first },
  { content: "Staying hydrated has made a big difference in my energy levels too!", user: User.third, post: Post.offset(7).first },
  { content: "I used to hate working out, but then I found a routine that I enjoy. Keep the good work!", user: User.second, post: Post.offset(5).first }
]

comments.each { |comment| Comment.create!(comment) }
puts "✅ Created #{Comment.count} comments"

puts "Seeding days..."
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

days.each do |day|
  Day.find_or_create_by!(name: day)
end
puts "✅ Created #{Day.count} days"
