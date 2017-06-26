class MessagesController < ApplicationController

  def index
    @groups = Group.updated_at
    @group = Group.find(params[:group_id])
    @users = @group.users
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    message = current_user.messages.new(message_params)
    group = Group.find(params[:group_id])
    if message.save
      redirect_to group_messages_url(group)
    else
      redirect_to group_messages_url(group), alert: 'メッセージを入力してください。'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

end
