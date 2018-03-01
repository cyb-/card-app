# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  FactoryBot.create_list(:cards_dragon, 5, :with_random_attributes)
  FactoryBot.create_list(:cards_elf, 5, :with_random_attributes)
  FactoryBot.create_list(:cards_magus, 5, :with_random_attributes)
  FactoryBot.create_list(:cards_warrior, 5, :with_random_attributes)
  FactoryBot.create_list(:cards_developer, 4, :with_random_attributes)
  FactoryBot.create(:cards_developer, :ruby_on_rails)

  FactoryBot.create_list(:player, 5, :with_random_cards, cards_count: 15)

  puts "🍺   Seeding done !".colorize(:light_white)
end
