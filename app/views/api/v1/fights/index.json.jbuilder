json.fights do
  json.array! @fights, partial: "api/v1/fights/fight", as: :fight
end
