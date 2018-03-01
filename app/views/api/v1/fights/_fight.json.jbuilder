json.extract! fight, :id, :created_at, :updated_at, :winner_id

json.hands do
  json.array! fight.hands, partial: "api/v1/hands/hand", as: :hand
end
