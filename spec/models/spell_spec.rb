require 'rails_helper'

RSpec.describe Spell, type: :model do
  subject { build(:spell) }

  context "Configurations" do
    it { is_expected.to respond_to(:source) }
    it { is_expected.to respond_to(:target) }
  end

  context "Instance Methods" do
    pending
  end

end
