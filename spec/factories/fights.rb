FactoryBot.define do
  factory :fight do
    association :game, factory: :game

    hands { [Hand.new(player: game.players.first, card: build(:card)), Hand.new(player: game.players.last, card: build(:card))] }

    after :build do |fight|
      fight.hands { [build(:hand, player: game.players.first, card: build(:card), fight: fight), build(:hand, player: game.players.last, card: build(:card), fight: fight)] }
    end
  end
end
