FactoryBot.define do
  factory :cards_dragon, parent: :card, class: "Cards::Dragon" do
    sequence(:name) { |n| "#{Faker::GameOfThrones.dragon} #{n}" }
    howlable
  end
end
