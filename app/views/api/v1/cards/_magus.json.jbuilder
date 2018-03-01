json.partial! "api/v1/cards/card", card: card

json.extract! card, :spell_names
