json.fight do
  json.extract! @fight, :id, :created_at, :updated_at, :winner_id

  json.hands(@fight.hands) do |hand|
    json.partial! "api/v1/hands/hand", hand: hand

    json.player do
      json.partial! "api/v1/players/player", player: hand.player
    end

    json.card do
      json.partial! "api/v1/cards/card", card: hand.card
    end
  end

  json.winner do
    if @fight.winner?
      json.partial! "api/v1/players/player", player: @fight.winner
    else
      json.nil!
    end
  end
end
