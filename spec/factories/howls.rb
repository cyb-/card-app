FactoryBot.define do
  factory :howl do
    skip_create
    initialize_with { new(source, target) }

    source { build(:card) }
    target { build(:card) }
  end
end
