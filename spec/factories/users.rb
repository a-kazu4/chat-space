FactoryGirl.define do

  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password Faker::Number.number(8)
  end

end
