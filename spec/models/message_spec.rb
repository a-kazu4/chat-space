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

    # 外部キー制約
      # user_idと同じidを持つユーザーがいれば保存できる
    it 'is valid with FOREIGN KEY constraint on user_id' do
      num = Faker::Number.number(10)
      message = build(:message, user_id: num)
      user = build(:user, id: num)
      expect(message.user_id).to eq(user.id)
    end
      # group_idと同じidを持つユーザーがいれば保存できる
    it 'is valid with FOREIGN KEY constraint on group_id' do
      num = Faker::Number.number(10)
      message = build(:message, group_id: num)
      group = build(:group, id: num)
      expect(message.group_id).to eq(group.id)
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
      # user_idと同じidを持つユーザーがいないと保存できない
    it 'is invalid with FOREIGN KEY constraint on user_id' do
      message = build(:message, user_id: 2)
      user = build(:user, id: 3)
      message.valid?
      expect(message.user_id).not_to eq(user.id)
    end
      # group_idと同じidを持つユーザーがいないと保存できない
    it 'is invalid with FOREIGN KEY constraint on group_id' do
      message = build(:message, group_id: 2)
      group = build(:user, id: 3)
      message.valid?
      expect(message.group_id).not_to eq(group.id)
    end
  end
end
