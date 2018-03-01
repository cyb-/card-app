angular.module("cardApp").factory("Card", [function()
{
  function Card(id, type, name, health, strength, shield, howlName, weaponName, spellNames)
  {
    this.id = id;
    this.type = type;
    this.name = name;
    this.health = health;
    this.strength = strength;
    this.shield= shield;
    this.howlName = howlName;
    this.weaponName = weaponName;
    this.spellNames = (spellNames || []);
  }

  Card.prototype.toString = function()
  {
    return this.name;
  }

  Card.build = function(datas)
  {
    if (!datas)
      return;

    return new Card(
      datas.id.$oid,
      datas.type,
      datas.name,
      datas.health,
      datas.strength,
      datas.shield,
      datas.howl_name,
      datas.weapon_name,
      datas.spell_names
    );
  }

  Card.buildList = function(datas)
  {
    var list = [];

    if (datas == undefined || !datas.length)
      return list;

    for(var i = 0; i < datas.length; i++)
      list.push(Card.build(datas[i]));

    return list;
  }

  return Card;
}]);
