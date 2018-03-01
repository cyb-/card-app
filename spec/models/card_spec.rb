require 'rails_helper'

RSpec.describe Card, type: :model do
  subject { build(:card) }

  context "Mongoid" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:health).of_type(Integer) }
    it { is_expected.to have_field(:strength).of_type(Integer) }
    it { is_expected.to have_field(:shield).of_type(Integer) }
  end

  context "Relations" do
    it { is_expected.to have_and_belong_to_many(:players) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:_type).case_insensitive }
  end

  context "Instance Methods" do
    pending
  end

end
