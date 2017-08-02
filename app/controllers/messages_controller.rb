class MessagesController < ApplicationController

  before_action :common_valiables, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_url(@group) }
        format.json
      end
    # else
    #   flash[:alert] = 'メッセージを入力してください。'
    #   render :index
    end
  end

  private

  def common_valiables
    @group = Group.find(params[:group_id])
    @groups = Group.newest
    @users = @group.users
    @messages = @group.messages.includes(:user)
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

end
