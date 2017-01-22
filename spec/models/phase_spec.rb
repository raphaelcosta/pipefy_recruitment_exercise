require 'rails_helper'

RSpec.describe Phase, type: :model do
	describe FactoryGirl.create(:phase) do
  	it { is_expected.to belong_to(:pipe) }
  	it { is_expected.to have_many(:cards) }
  	it { is_expected.to have_attributes(name: 			 'Phase Test') }
  	it { is_expected.to have_attributes(description: 'testing =D') }
  	it { is_expected.to have_attributes(done:  true) }
  	it { is_expected.to have_attributes(index: 1.0) }
  	it { is_expected.to have_attributes(draft: false) }
	end
end