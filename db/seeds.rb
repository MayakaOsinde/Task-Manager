puts "STARTED SEEDING "
# Users.destroy_all
# Tasks.destroy_all
puts "Deleting old data..."

# Randomize Users
20.times do |n|
    User.create!(
      first_name: Faker::Name.first_name,
      middle_name: Faker::Name.middle_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      age: rand(18..60),
      password: Faker::Internet.password(min_length: 8)
    )
end
  
  # Randomize Tasks
20.times do |n|
    user = User.order(Arel.sql('RANDOM()')).first
    Task.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      due_date: Date.today + rand(1..10).days,
      collaborators: Faker::Internet.email,
      completed: Date.today + rand(1..10).days,
      created_at: Date.today - rand(1..10).days,
      updated_at: Date.today - rand(1..5).days,
      user_id: user.id
    )
end
  

puts "COMPLETED"