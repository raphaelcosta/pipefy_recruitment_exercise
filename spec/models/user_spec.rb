require 'rails_helper'

RSpec.describe User, type: :model do
   describe FactoryGirl.create(:user) do
  	it { is_expected.to belong_to(:pipe) }
  	it { is_expected.to have_attributes(name:             'User Test') }
  	it { is_expected.to have_attributes(username:         'user_test') }
  	it { is_expected.to have_attributes(email:            'email@test.com') }
  	it { is_expected.to have_attributes(display_username: 'usertest') }
	end
end
