require 'rails_helper'

RSpec.describe Field, type: :model do
  describe FactoryGirl.create(:field) do
    it { is_expected.to belong_to(:phase) }
    it { is_expected.to have_attributes(external_id:     21312) }
    it { is_expected.to have_attributes(label:          'BUGZÃO') }
    it { is_expected.to have_attributes(description:    'BUGOU EM PROD!!' ) }
    it { is_expected.to have_attributes(is_title_field: true) }
  end
end
