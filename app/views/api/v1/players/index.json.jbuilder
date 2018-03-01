json.players do
  json.array! @players, partial: "api/v1/players/player", as: :player
end
