FactoryBot.define do
  factory :weapon do
    skip_create
    initialize_with { new(source, target) }

    source { build(:card) }
    target { build(:card) }
  end
end
