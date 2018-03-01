FactoryBot.define do
  factory :hand do
    association :fight, factory: :fight

    player { build(:player) }
    card   { build(:card) }

    after :create do |hand|
      hand.player.cards << hand.card
    end
  end
end
