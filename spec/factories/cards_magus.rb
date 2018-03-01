FactoryBot.define do
  factory :cards_magus, parent: :card, class: "Cards::Magus" do
    sequence(:name) { |n| "#{Faker::Hobbit.character} #{n}" }
    spellable
    # spell_names     { Spell.availables.sample((1..(Spell.availables.size)).to_a.sample) }
  end
end
