angular.module("cardApp").factory("Game", ["Fight", "Player", function(Fight, Player)
{
  function Game(id, players, fights)
  {
    this.id = id;
    if (players)
    {
      this.player1 = players[0];
      this.player2 = players[1];
    }
    else
    {
      this.player1 = null;
      this.player2 = null;
    }
    this.fights = fights;
  }

  Game.prototype.toString = function()
  {
    return this.player1.name + " vs " + this.player2.name;
  }

  Game.prototype.toParams = function()
  {
    return { player_ids: [this.player1.id, this.player2.id] };
  }

  Game.prototype.setFights = function(datas)
  {
    this.fights = Fight.buildList(datas);
  }

  Game.prototype.isFinished = function()
  {
    return this.fights.length == 10;
  }

  Game.build = function(datas)
  {
    if (!datas)
      return;
  
    return new Game(
      datas.id.$oid,
      Player.buildList(datas.players),
      Fight.buildList(datas.fights)
    );
  }

  Game.buildList = function(datas)
  {
    var list = [];

    if (datas == undefined || !datas.length)
      return list;

    for(var i = 0; i < datas.length; i++)
      list.push(Game.build(datas[i]));

    return list;
  }

  return Game;
}]);
