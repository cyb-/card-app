json.cards(@cards) do |card|
  json.partial! "api/v1/cards/#{card.class.name.demodulize.underscore}", card: card
end
