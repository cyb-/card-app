json.partial! "api/v1/cards/card", card: card

json.extract! card, :howl_name, :spell_names, :weapon_name
