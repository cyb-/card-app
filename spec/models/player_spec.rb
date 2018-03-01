require 'rails_helper'

RSpec.describe Player, type: :model do
  subject { build(:player) }

  context "Mongoid" do
    it { is_expected.to have_field(:name).of_type(String) }
  end

  context "Relations" do
    it { is_expected.to have_and_belong_to_many(:cards) }
    it { is_expected.to have_and_belong_to_many(:games) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

end
