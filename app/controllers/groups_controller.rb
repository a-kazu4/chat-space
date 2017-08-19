class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update]
  before_action :set_users, only: [:new, :create, :edit, :update]

  def index
    @groups = Group.newest_order_by_messages_created_at
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_url, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to root_url, notice: 'グループが更新されました。'
    else
      render :edit
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def group_params
    params.require(:group).permit(:name, { user_ids:[] })
  end

end
