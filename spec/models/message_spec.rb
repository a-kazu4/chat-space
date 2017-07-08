require 'rails_helper'
describe Message do
  describe '#create' do
    let(:message) { Message.new(message_params) }
    let(:message_params) { { body: body, image: image, user_id: user_id, group_id: group_id } }

    let(:text) { Faker::Pokemon.name }
    let(:url) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image/image.jpg')) }
    let(:num) { Faker::Number.number(10) }

    # メッセージを保存できる場合
    context 'if a message can be saved' do
      subject { message }

      # メッセージと画像があれば保存できる
      context 'with a message and an image' do
        let(:body) { text }
        let(:image) { url }
        let(:user_id) { num }
        let(:group_id) { num }
        it { is_expected.to be_valid }
      end

      # メッセージがあれば保存できる
      context 'with a body' do
        let(:body) { text }
        let(:image) { nil }
        let(:user_id) { num }
        let(:group_id) { num }
        it { is_expected.to be_valid }
      end

      # 画像があれば保存できる
      context 'with a image' do
        let(:body) { '' }
        let(:image) { url }
        let(:user_id) { num }
        let(:group_id) { num }
        it { is_expected.to be_valid }
      end

      # 外部キー制約
      context 'with FOREIGN KEY constraint' do
        let(:body) { text }
        let(:image) { url }
        let(:user_id) { num }
        let(:group_id) { num }

        # user_idと同じidを持つユーザーがいれば保存できる
        context 'on user_id if there is User who has a same id' do
          it 'should be valid' do
            user = build(:user, id: num)
            expect(message.user_id).to eq(user.id)
          end
        end

        # group_idと同じidを持つユーザーがいれば保存できる
        context 'on group_id if there is Group who has a same id' do
          it 'should be valid' do
            group = build(:group, id: num)
            expect(message.group_id).to eq(group.id)
          end
        end
      end
    end

    # メッセージを保存できない場合
    context 'if a messsage cannot be saved' do

    #   # メッセージも画像も無いと保存できない
      context 'without a body and an image' do
        let(:body) { '' }
        let(:image) { '' }
        let(:user_id) { num }
        let(:group_id) { num }
        it 'should be invalid' do
          message.valid?
          expect(message.errors[:body_or_image]).to include('を入力してください。')
        end
      end

    #   # user_idが無いと保存できない
      context 'without a user_id' do
        let(:body) { text }
        let(:image) { url }
        let(:user_id) { '' }
        let(:group_id) { num }
        it 'should be invalid' do
          message.valid?
          expect(message.errors[:user_id]).to include('を入力してください。')
        end
      end

      # group_idが無いと保存できない
      context 'without a group_id' do
        let(:body) { text }
        let(:image) { url }
        let(:user_id) { num }
        let(:group_id) { '' }
        it 'should be invalid' do
          message.valid?
          expect(message.errors[:group_id]).to include('を入力してください。')
        end
      end

      # 外部キー制約
      context 'with FOREIGN KEY constraint' do
        let(:body) { text }
        let(:image) { url }
        let(:user_id) { 2 }
        let(:group_id) { 2 }
          # user_idと同じidを持つユーザーがいないと保存できない
        context 'on user_id unless there is User who has a same id' do
          it 'should be invalid' do
            user = build(:user, id: 3)
            message.valid?
            expect(message.user_id).not_to eq(user.id)
          end
        end

          # group_idと同じidを持つユーザーがいないと保存できない
        context 'on group_id unless there is Group who has a same id' do
          it 'should be invalid' do
            group = build(:user, id: 3)
            message.valid?
            expect(message.group_id).not_to eq(group.id)
          end
        end
      end
    end
  end
end
