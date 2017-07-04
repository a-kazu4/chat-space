require 'rails_helper'
describe Message do
  describe '#create' do
  # メッセージを保存できる場合
    # メッセージと画像があれば保存できる
    it 'is valid with a body and an image' do
      message = build(:message)
      expect(message).to be_valid
    end

    # メッセージがあれば保存できる
    it 'is valid with a body' do
      message = build(:message, image: '')
      expect(message).to be_valid
    end

    # 画像があれば保存できる
    it 'is valid with a image' do
      message = build(:message, body: '')
      expect(message).to be_valid
    end

  # メッセージを保存できない場合
    # メッセージも画像も無いと保存できない
    it 'is invalid without a body and an image' do
      message = build(:message, body: '', image: nil)
      message.valid?
      expect(message.errors[:body_or_image]).to include('を入力してください。')
    end

    # group_idが無いと保存できない
    it 'is invalid without a group_id' do
      message = build(:message, group_id: '')
      message.valid?
      expect(message.errors[:group_id]).to include('を入力してください。')
    end

    # user_idが無いと保存できない
    it 'is invalid without a user_id' do
      message = build(:message, user_id: '')
      message.valid?
      expect(message.errors[:user_id]).to include('を入力してください。')
    end

    # 外部キー制約
      # user_idと同じidを持つユーザーがいれば保存できる
    it 'is valid with FOREIGN KEY constraint on user_id' do
      message = build(:message, user_id: 2)
      user = build(:user, id: 2)
      expect(message.user_id).to eq(user.id)
    end

  end
end
