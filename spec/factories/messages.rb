FactoryGirl.define do

  factory :message do
    body     Faker::Pokemon.name
    user_id  Faker::Number.number(1)
    group_id Faker::Number.number(1)
  end

end
