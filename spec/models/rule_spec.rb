require 'rails_helper'

RSpec.describe Rule, type: :model do
  subject { build(:rule) }

  context "Callbacks" do
    it { is_expected.to callback(:run_cards_before_callbacks!).before(:fighting) }
    it { is_expected.to callback(:run_cards_after_callbacks!).after(:fighting) }
  end

  context "Instance Methods" do
    it { is_expected.to respond_to :winner }
    it { is_expected.to respond_to :card1 }
    it { is_expected.to respond_to :card2 }
  end

end
