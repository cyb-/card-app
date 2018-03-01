FactoryBot.define do
  factory :rule do
    skip_create
    initialize_with { new(card1, card2) }

    card1 { build(:card) }
    card2 { build(:card) }
  end
end
