require 'rails_helper'

RSpec.describe Hand, type: :model do
  subject { build(:hand) }

  context "Relations" do
    it { is_expected.to be_embedded_in(:fight).as_inverse_of(:hands) }
    it { is_expected.to belong_to(:card).of_type(Card) }
    it { is_expected.to belong_to(:player).of_type(Player) }
  end

  context "Instance Methods" do
    pending
  end

end
