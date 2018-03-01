json.game do
  json.partial! "api/v1/games/game", game: @game

  json.players do
    json.array! @game.players, partial: "api/v1/players/player", as: :player
  end

  json.fights do
    json.array! @game.fights, partial: "api/v1/fights/fight", as: :fight
  end
end
