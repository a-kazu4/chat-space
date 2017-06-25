class MessagesController < ApplicationController

  def index
    @groups = Group.updated_at
    @group = Group.find(params[:group_id])
    @users = @group.users
    @message = Message.new
    @messages = @group.messages
  end

  def create
    @message = Message.new(message_params)
    @group = Group.find(params[:group_id])
    if @message.save
      redirect_to group_messages_url(@group)
    else
      redirect_to group_messages_url(@group), alert: 'メッセージを入力してください。'
    end
  end

  private

  def message_params
    group = Group.find(params[:group_id])
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: group.id)
  end

end
