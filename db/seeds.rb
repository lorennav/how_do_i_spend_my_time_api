# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(name: 'Test 1', password: '123123123', email: 'test@test.com')
category = user.categories.create!(name: 'Study')
activity = user.activities.create!(name: 'Api Project', description: 'Work on Ruby on rails application', 
  date: Date.today, start_time: '10:00', finish_time: '13:00')
activity.category = category
activity.save!
