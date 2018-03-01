# CARD APP

Using **Ruby 2.4.1** and **Rails 5.1.5**

* Mongoid as ORM (MongoDB)
* RSpec as tests suite

## Installation

    cd card-app
    bundle install
    rails generate mongoid:config
    rails db:setup

You may have to configure yourself your ``config/mongoid.yml``

Run your server with ``rails server`` and enjoy this great 'responsive' app at [http://localhost:3000](http://localhost:3000) :sunglasses:

### Tests

**You need to install `geckodriver` in your path to run selenium-webdriver**

Running tests suite :

    bundle exec rspec

## API

CardApp provides an API at ``/api/v1`` scoped path.

| URL | METHOD |  | Default |
|---|---|---|---|
| ``/cards`` | **GET** | Returns a list of all playable cards. | **json** |
| ``/cards/:card_id`` | **GET** | Returns the card attributes. | **json** |
| ``/players`` | **GET** | Returns a list of all players. | **json** |
| ``/players/:player_id`` | **GET** | Returns the player attributes. | **json** |
| ``/players/:player_id/cards`` | **GET** | Returns a list of all player cards. | **json** |
| ``/players/:player_id/games`` | **GET** | Returns a list of all player games. | **json** |
| ``/games`` | **GET** | Returns a list of all games. | **json** |
| ``/games`` | **POST** | Creates a new game. | **json** |
| ``/games/:game_id`` | **GET** | Returns the game attributes. | **json** |
| ``/games/:game_id/fights`` | **GET** | Returns a list of all game fights. | **json** |
| ``/games/:game_id/fights`` | **POST** | Creates a new fight and returns its full attributes. | **json** |
| ``/games/:game_id/winner`` | **GET** | Returns winner and looser attributes (or no_content if unfinished game) | **json** |

## Extending

### Create new card type

You can create new card type with generator :

    rails generate card foo [field:type, ...] [options]

This will generate a custom card type class ``Cards::Foo``, you can now create your custom cards like :

```ruby
Cards::Foo.create(name: "Foo", health: 75, strength: 25, shield: 10)
```

#### Custom card behaviors

You can add specific behaviors on card types by adding methods on ``before_fight`` and ``after_fighted`` callbacks.

```ruby
class Cards::Foo < Card
  before_fight  :minimize_versus_damages!
  after_fighted :kill_versus!

  private

  def minimize_versus_damages!
    self.shield_ratio = 2.0
    versus.strength_ratio = 0.1
  end

  def kill_versus!
    versus.kill!
  end

end
```

### Create specific rule

You can create specific rule between two card types with generator like :

    rails generate card foo
    rails generate card baz
    rails generate rule foo baz

This will generate a custom rule class ``Rules::BazVsFoo`` which will be used when ``Cards::Foo`` type will fight ``Cards::Baz`` type.

```ruby
class Rules::BazVsFoo < Rule

  private

  def set_winner!
    @winner = [baz, foo].sample
  end

end
```

Look at ``app/models/rule.rb`` to see the default behavior and how to overwrite it ;)

### Create new weapon

You can create a new weapon with generator :

    rails generate weapon sword

This will generate a new weapon class at ``app/models/weapons/sword.rb``

```ruby
class Weapons::Sword < Weapon
  before_using :maximize_strength!

  private

  def maximize_strength!
    source.strength_ratio = 2
  end

end
```

You can use weapon on any card by including the ``Weaponable`` module, or passing ``--weaponable`` option to the card generator.

### Create new howl

You can create new howl with generator :

    rails generate howl of_the_death

This will generate a new howl class at ``app/models/howls/of_the_death.rb``

```ruby
class Howls::OfTheDeath < Howl
  after_using :kill_target!

  private

  def kill_target!
    target.kill!
  end

end
```

You can use howl on any card by including ``Howlable`` module or pasing ``--howlable`` option to the card generator.

### Create new spell

You can create new spell with generator :

    rails generate spell resurrection

This will generate a new spell class at ``app/models/spells/resurection.rb``

```ruby
class Spells::Resurrection < Spell
  after_fighted :resurrect_source!

  private

  def resurrect_source!
    source.resurrect!
  end

end
```

You can use spells on any card by including ``Spellable`` module or passing ``--spellable`` option to the card generator.

You can mannually add/delete spell on spellable card with helpers :

```ruby
card.add_spell!("Resurrection")
card.delete_spell!("Resurrection")
```
