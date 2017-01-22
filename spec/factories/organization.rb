FactoryGirl.define do
  factory :organization do
  	name 'Organization Test'

    trait :complet do
    	pipes  {[FactoryGirl.create(:pipe, :complet)]}
  	end
  end
end