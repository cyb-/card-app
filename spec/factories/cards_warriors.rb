FactoryBot.define do
  factory :cards_warrior, parent: :card, class: "Cards::Warrior" do
    sequence(:name) { |n| "#{Faker::WorldOfWarcraft.hero} #{n}" }
    weaponable
  end
end
