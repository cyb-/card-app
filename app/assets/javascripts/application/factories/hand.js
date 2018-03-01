angular.module("cardApp").factory("Hand", ["Card", "Player", function(Card, Player)
{
  function Hand(id, player, card)
  {
    this.id = id;
    this.player = player;
    this.card = card;
  }

  Hand.prototype.toString = function()
  {
    if (!this.player || !this.card)
      return;

    return this.player.toString() + " (" + this.card.toString() + ")";
  }

  Hand.prototype.toParams = function()
  {
    return { player_id: this.player.id, card_id: this.card.id };
  }

  Hand.build = function(datas)
  {
    if (!datas)
      return;
  
    return new Hand(
      datas.id.$oid,
      Player.build(datas.player),
      Card.build(datas.card)
    );
  }

  Hand.buildList = function(datas)
  {
    var list = [];

    if (datas == undefined || !datas.length)
      return list;

    for(var i = 0; i < datas.length; i++)
      list.push(Hand.build(datas[i]));

    return list;
  }

  return Hand;
}]);
