FactoryBot.define do
  factory :cards_developer, parent: :card, class: "Cards::Developer" do
    sequence(:name)   { |n| "#{Faker::ProgrammingLanguage.creator} #{n}" }
    howlable
    weaponable
    spellable

    trait :ruby_on_rails do
      sequence(:name) { |n| "Ruby on Rails #{n}" }

      health          200
      strength        100
      shield          100
      weapon_name     "LaserSaber"
      howl_name       "OfTheDeath"
      spell_names     Spell.availables
    end
  end
end
