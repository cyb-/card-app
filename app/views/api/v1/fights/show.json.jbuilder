json.fight do
  json.partial! "api/v1/fights/fight", fight: @fight

  json.winner do
    if @fight.winner?
      json.partial "api/v1/players/player", player: @fight.winner
    else
      json.nil!
    end
  end
end
