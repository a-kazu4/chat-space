class GroupsController < ApplicationController

  def index
    @groups = Group.order_by_updated_at
  end

  def new
    @group = Group.new
    @users = User.all
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_url, notice: 'グループが作成されました。'
    else
      @users = User.all
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.all
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_url, notice: 'グループが更新されました。'
    else
      @users = User.all
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids:[] })
  end

end
