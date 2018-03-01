require 'rails_helper'

RSpec.describe Fight, type: :model do
  subject { build(:fight) }

  context "Relations" do
    it { is_expected.to be_embedded_in(:game).as_inverse_of(:fights) }
    it { is_expected.to embed_many(:hands).as_inverse_of(:fight) }
    it { is_expected.to belong_to(:winner).of_type(Player) }
    it { is_expected.to accept_nested_attributes_for(:hands) }
  end

  context "Callbacks" do
    it { is_expected.to callback(:fight!).before(:create) }
  end

  context "Instance Methods" do
    pending
  end

end
