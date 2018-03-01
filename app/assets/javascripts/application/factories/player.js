angular.module("cardApp").factory("Player", ["$filter", "Card", function($filter, Card)
{
  function Player(id, name, createdAt, updatedAt, cards)
  {
    this.id = id;
    this.name = name;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.cards = (cards || []);
  }

  Player.prototype.toString = function()
  {
    return this.name;
  }

  Player.prototype.setCards = function(datas)
  {
    this.cards = Card.buildList(datas);
  }

  Player.prototype.victoryCountFor = function(game)
  {
    return $filter('filter')(game.fights, {winner: {id: this.id}}).length;
  }

  Player.build = function(datas)
  {
    if (!datas)
      return;
  
    return new Player(
      datas.id.$oid,
      datas.name,
      datas.created_at,
      datas.updated_at,
      Card.buildList(datas.cards)
    );
  }

  Player.buildList = function(datas)
  {
    var list = [];

    if (datas == undefined || !datas.length)
      return list;

    for(var i = 0; i < datas.length; i++)
      list.push(Player.build(datas[i]));

    return (list);
  }

  return Player;
}]);
