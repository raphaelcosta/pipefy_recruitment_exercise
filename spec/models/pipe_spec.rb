require 'rails_helper'

RSpec.describe Pipe, type: :model do
  describe FactoryGirl.create(:pipe) do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_attributes(name:     'fy') }
    it { is_expected.to have_attributes(token:    'token1234') }
    it { is_expected.to have_attributes(can_edit: false)     }
    it { is_expected.to have_many(:users)  }
    it { is_expected.to have_many(:phases) }
    it { is_expected.to have_many(:labels) }
  end
end