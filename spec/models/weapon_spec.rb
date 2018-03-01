require 'rails_helper'

RSpec.describe Weapon, type: :model do
  subject { build(:weapon) }

  describe "Configurations" do
    it { is_expected.to respond_to(:source) }
    it { is_expected.to respond_to(:target) }
  end

  context "Instance Methods" do
    pending
  end
end
