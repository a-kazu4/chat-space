require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { create(:message) }

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


end
