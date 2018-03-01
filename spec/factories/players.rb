FactoryBot.define do
  factory :player do
    sequence(:name)   { |n| "#{Faker::Simpsons.character}-#{n}" }

    trait :invalid do
      name            nil
    end

    trait :with_games do
      transient do
        games_count   3
      end

      after :create do |player, evaluator|
        player.games = create_list(:game, evaluator.games_count)
      end
    end

    trait :with_cards do
      transient do
        cards_count   5
      end

      after(:create) do |player, evaluator|
        player.cards = create_list(:card, evaluator.cards_count)
      end
    end

    trait :with_random_cards do
      transient do
        cards_count   { rand(3..10) }
      end

      after :create do |player, evaluator|
        player.cards = Card.all.to_a.sample(evaluator.cards_count)
      end
    end
  end
end
