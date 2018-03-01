json.games do
  json.array! @games, partial: "api/v1/games/game", as: :game
end
