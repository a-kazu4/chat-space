FactoryGirl.define do

  factory :message do
    body 'hello world'
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image/image.jpg'))
    user_id 1
    group_id 1
  end

end
