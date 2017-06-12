class GroupsController < ApplicationController

  def index
    @groups = Group.order('updated_at DESC')
  end

  def new
    @group = Group.new
    @users = User.all
  end

  def create
    @group = Group.new(group_params)
    @group.save
    if @group.save
      redirect_to root_path, notice: 'グループが作成されました。'
    end
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.all
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name, {user_ids:[]})
  end

end
