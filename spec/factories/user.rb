FactoryGirl.define do
  factory :user do
    pipe
    name 'User Test'
    username 'user_test'
    email  'email@test.com'
    display_username 'usertest'
  end
end