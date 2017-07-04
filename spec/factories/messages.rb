FactoryGirl.define do

  factory :message do
    body Faker::Pokemon.name
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image/image.jpg'))
    user_id Faker::Number.number(3)
    group_id Faker::Number.number(3)
  end

end
