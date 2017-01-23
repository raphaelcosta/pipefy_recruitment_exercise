require 'rails_helper'

RSpec.describe Label, type: :model do
  describe FactoryGirl.create(:label) do
    it { is_expected.to belong_to(:pipe) }
    it { is_expected.to have_attributes(name:  'Label test') }
    it { is_expected.to have_attributes(color: '#000000' ) }
  end
end
