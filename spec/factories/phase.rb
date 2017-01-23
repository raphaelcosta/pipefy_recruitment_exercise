FactoryGirl.define do
  factory :phase do
    pipe
    name 'Phase Test'
    description 'testing =D'
    done true
    index 1.0
    draft false
    trait :complet do
      cards {[FactoryGirl.create(:card)]}
    end
  end
end