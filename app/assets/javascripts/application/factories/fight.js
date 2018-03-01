angular.module("cardApp").factory("Fight", ["Hand", "Player", function(Hand, Player)
{
  function Fight(id, hands, winner)
  {
    this.id = id;
    this.hands = (hands || []);
    this.hand1 = this.hands[0];
    this.hand2 = this.hands[1];
    this.winner = winner;
  }

  Fight.prototype.toString = function()
  {
    return hand1.toString() + " vs " + hand2.toString();
  }

  Fight.prototype.toParams = function()
  {
    return { hands_attributes: [this.hand1.toParams(), this.hand2.toParams()] };
  }

  Fight.prototype.setHands = function(datas)
  {
    this.hands = Hand.buildList(datas);
    if (this.hands)
    {
      this.hand1 = this.hands[0];
      this.hand2 = this.hands[1];
    }
  }

  Fight.prototype.addHand = function(hand)
  {
    if (this.hands >= 2)
      return;

    this.hands.push(hand);
    if (this.hands)
    {
      this.hand1 = this.hands[0];
      this.hand2 = this.hands[1];
    }
  }

  Fight.build = function(datas)
  {
    if (!datas)
      return;
  
    return new Fight(
      datas.id.$oid,
      Hand.buildList(datas.hands),
      Player.build(datas.winner)
    );
  }

  Fight.buildList = function(datas)
  {
    var list= [];

    if (datas == undefined || !datas.length)
      return list;

    for(var i = 0; i < datas.length; i++)
      list.push(Fight.build(datas[i]));

    return list;
  }

  return Fight;
}]);
