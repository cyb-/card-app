require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { build(:game) }

  context "Relations" do
    it { is_expected.to embed_many(:fights).as_inverse_of(:game) }
    it { is_expected.to have_and_belong_to_many(:players) }
  end

  context "Instance Methods" do
    pending
  end

end
