require 'rails_helper'
describe Message do
  describe '#create' do
    let(:message) { Message.new(message_params) }

    let(:message_params) do
      hash = {}
      hash[:body] = Faker::Pokemon.name
      hash[:image] = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image/image.jpg'))
      hash[:user_id] = Faker::Number.number(3)
      hash[:group_id] = Faker::Number.number(3)
      hash
    end

    let(:num) { Faker::Number.number(10) }

    # メッセージを保存できる場合
    context 'if a message can be saved' do

      # メッセージと画像があれば保存できる
      it 'is valid with a body and an image' do
        expect(message).to be_valid
      end

      # メッセージがあれば保存できる
      it 'is valid with a body' do
        message_params.merge!(image: '')
        expect(message).to be_valid
      end

      # 画像があれば保存できる
      it 'is valid with a image' do
        message_params.merge!(body: '')
        expect(message).to be_valid
      end

      # 外部キー制約
        # user_idと同じidを持つユーザーがいれば保存できる
      it 'is valid with FOREIGN KEY constraint on user_id' do
        message_params.merge!(user_id: num)
        user = build(:user, id: num)
        expect(message.user_id).to eq(user.id)
      end

        # group_idと同じidを持つユーザーがいれば保存できる
      it 'is valid with FOREIGN KEY constraint on group_id' do
        message_params.merge!(group_id: num)
        group = build(:group, id: num)
        expect(message.group_id).to eq(group.id)
      end
    end

    # メッセージを保存できない場合
    context 'if a messsage cannot be saved' do

      # メッセージも画像も無いと保存できない
      it 'is invalid without a body and an image' do
        message_params.merge!(body: '', image: nil)
        message.valid?
        expect(message.errors[:body_or_image]).to include('を入力してください。')
      end

      # group_idが無いと保存できない
      it 'is invalid without a group_id' do
        message_params.merge!(group_id: '')
        message.valid?
        expect(message.errors[:group_id]).to include('を入力してください。')
      end

      # user_idが無いと保存できない
      it 'is invalid without a user_id' do
        message_params.merge!(user_id: '')
        message.valid?
        expect(message.errors[:user_id]).to include('を入力してください。')
      end

      # 外部キー制約
        # user_idと同じidを持つユーザーがいないと保存できない
      it 'is invalid with FOREIGN KEY constraint on user_id' do
        message_params.merge!(user_id: 2)
        user = build(:user, id: 3)
        message.valid?
        expect(message.user_id).not_to eq(user.id)
      end

        # group_idと同じidを持つユーザーがいないと保存できない
      it 'is invalid with FOREIGN KEY constraint on group_id' do
        message_params.merge!(group_id: 2)
        group = build(:user, id: 3)
        message.valid?
        expect(message.group_id).not_to eq(group.id)
      end
    end
  end
end
