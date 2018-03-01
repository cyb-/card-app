json.winner do
  if @game.winner
    json.partial! "api/v1/players/player", player: @game.winner
    json.fights_count @game.winner_fights_count
  else
    json.nil!
  end
end

json.looser do
  if @game.looser
    json.partial! "api/v1/players/player", player: @game.looser
    json.fights_count @game.looser_fights_count
  else
    json.nil!
  end
end
