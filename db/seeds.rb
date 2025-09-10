require "faker"

# Clear existing data
Order.destroy_all
Item.destroy_all
Member.destroy_all
ProfileSetting.destroy_all
User.destroy_all

puts "🌱 Seeding database..."

# Create 10 items
items = 10.times.map do
  Item.create!(
    name: Faker::Commerce.product_name,
    quantity: rand(1..50),
    status: %w[tracked available unavailable].sample
  )
end
puts "✅ Created #{items.count} items"

# Create 10 members
members = 10.times.map do
  Member.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    phone_number: Faker::Number.number(digits: 10)
  )
end
puts "✅ Created #{members.count} members"

# Create 10 orders (each linked to random item & member)
orders = 10.times.map do
  item = items.sample
  member = members.sample

  Order.create!(
    item: item,
    member: member,
    quantity: rand(1..1000),
    return_by: Faker::Date.forward(days: 30),
    borrowed_by: member.name,
    status: %w[borrowed returned expired].sample,
    description: Faker::Lorem.sentence(word_count: 8)
  )
end
puts "✅ Created #{orders.count} orders"

# Create 10 profile settings
profile_settings = 10.times.map do
  ProfileSetting.create!(
    company_name: Faker::Company.name,
    address: Faker::Address.full_address,
    gst_number: Faker::Alphanumeric.alphanumeric(number: 15).upcase,
    email: Faker::Internet.unique.email,
    phone: Faker::Number.number(digits: 10)
  )
end
puts "✅ Created #{profile_settings.count} profile settings"

# Create admin user
user = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end
puts "✅ Created/Found user: #{user.email}"

puts "🌟 Seeding complete!"