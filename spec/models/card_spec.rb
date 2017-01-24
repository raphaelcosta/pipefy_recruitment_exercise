require 'rails_helper'

RSpec.describe Card, type: :model do
  describe FactoryGirl.create(:card) do
    it { is_expected.to belong_to(:phase) }
    it { is_expected.to have_many(:field_values) }
    it { is_expected.to have_attributes(title:     'Card Test') }
    it { is_expected.to have_attributes(due_date: Date.today ) }
    it { is_expected.to have_attributes(index:     1.0) }
  end
end
