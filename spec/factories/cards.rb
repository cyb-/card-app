FactoryBot.define do
  factory :card do
    sequence(:name)   { |n| "#{Faker::LeagueOfLegends.champion} #{n}" }

    trait :invalid do
      name            nil
    end

    trait :with_random_health do
      health          { rand(50..100) }
    end

    trait :with_random_strength do
      strength        { rand(5..50) }
    end

    trait :with_random_shield do
      shield          { rand(5..50) }
    end

    trait :with_random_attributes do
      with_random_strength
      with_random_shield
    end

    trait :weaponable do
      weapon_name     { Weapon.availables.reject{|klass| klass == "LaserSaber"}.sample }
    end

    trait :howlable do
      howl_name       { Howl.availables.sample }
    end

    trait :spellable do
      transient do
        spells_count  { rand(1..Spell.availables.size) }
      end

      spell_names     { Spell.availables.sample(spells_count) }
    end
  end
end
