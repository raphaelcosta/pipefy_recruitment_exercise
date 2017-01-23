FactoryGirl.define do
  factory :card do
    phase
    title     'Card Test'
    due_date { Date.today }
    index     1.0
  end
end