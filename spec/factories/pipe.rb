FactoryGirl.define do
  factory :pipe do
    organization

    name 'fy'
    token 'token1234'
    can_edit false

    trait :complet do
      users  {[FactoryGirl.create(:user)]}
      phases {[FactoryGirl.create(:phase, :complet) ]}
      labels {[FactoryGirl.create(:label) ]}
    end
  end
end