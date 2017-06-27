class MessagesController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @message = Message.new
    @users = @group.users
    @groups = Group.newest
    @messages = @group.messages.includes(:user)
  end

  def create
    create_valiables
    if @message.save
      redirect_to group_messages_url(@group)
    else
      redirect_to group_messages_url(@group), alert: 'メッセージを入力してください。'
    end
  end

  private

  def create_valiables
    @message = current_user.messages.new(message_params)
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

end
