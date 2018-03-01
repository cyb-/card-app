FactoryBot.define do
  factory :cards_elf, parent: :card, class: "Cards::Elf" do
    sequence(:name) { |n| "#{Faker::GameOfThrones.character} #{n}" }
    weaponable
    spellable
  end
end
