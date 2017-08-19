class MessagesController < ApplicationController

  before_action :common_valiables, only: [:index, :create]

  def index
    @message = Message.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_url(@group) }
        format.json { render :create, handlers: 'jbuilder' }
      end
    end
  end

  private

  def common_valiables
    @group = Group.find(params[:group_id])
    @groups = Group.newest_order_by_messages_created_at
    @users = @group.users
    @messages = @group.messages.includes(:user)
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

end
