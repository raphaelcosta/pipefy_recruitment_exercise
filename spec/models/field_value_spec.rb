require 'rails_helper'

RSpec.describe FieldValue, type: :model do
  describe FactoryGirl.create(:field_value) do
    it { is_expected.to belong_to(:card) }
    it { is_expected.to have_attributes(value:         "Esse foi o João que postou!") }
    it { is_expected.to have_attributes(display_value: "Esse foi o João que postou!") }
  end
end
