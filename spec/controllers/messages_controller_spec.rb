require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { attributes_for(:message) }
  let(:invalid_message) { attributes_for(:invalid_message) }
  describe 'GET #index' do

    context 'if user signs in' do
      before do
        login_user user
        get :index, params: { group_id: group.id }
      end

      it "assigns the requested group to @group" do
        expect(assigns(:group)).to eq group
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    context 'unless user signs in' do
      it 'redirects to user_sesssion_path' do
        get :index, params: { group_id: group.id }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

  end

  describe 'POST #create' do
    context 'if user signs in' do
      before do
        login_user user
      end

      context 'if message can be saved' do
        it 'saves the new contact in the database' do
          expect{
            post :create, group_id: group.id, message: message
          }.to change{ Message.count }.by(1)
        end

        it 'renders the :index template' do
          post :create, group_id: group.id, message: message
          expect(response).to redirect_to "/groups/#{group.id}/messages"
        end
      end

      context 'unless message can be saved' do
        it 'does not save the new contact in the database' do
          expect{
            post :create, group_id: group.id, message: invalid_message
          }.not_to change{ Message.count }
        end

        it 'renders the :index template' do
          post :create, group_id: group.id, message: invalid_message
          expect(response).to render_template :index
        end
      end

    end

    context 'unless user signs in' do
      it 'redirects to user_sesssion_path' do
        get :create, params: { group_id: group.id }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

  end

end
