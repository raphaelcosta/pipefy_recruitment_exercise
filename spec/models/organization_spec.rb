require 'rails_helper'

describe Organization, type: :model do

  describe FactoryGirl.create(:organization) do
    it { is_expected.to have_attributes(name: 'Organization Test') }
    it { is_expected.to have_many(:pipes) }
  end

end
