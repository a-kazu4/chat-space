FactoryGirl.define do

  factory :message do
    body     Faker::Pokemon.name
    user_id  Faker::Number.number(1)
    group_id Faker::Number.number(1)
  end

  factory :invalid_message, parent: :message do
    body nil
  end

end
