FactoryBot.define do
  factory :game do
    players           { build_list(:player, 2) }

    trait :with_fights do
      transient do
        fights_count  5
      end

      after :create do |game, evaluator|
        game.fights = create_list(:fight, evaluator.fights_count)
      end
    end
  end
end
