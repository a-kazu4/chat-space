class GroupsController < ApplicationController

  def index
    @groups = Group.order('updated_at DESC')
  end

  def new
    @group = Group.new
    @users = User.all
  end

  def create
    @group = Group.create(group_params)
    if @group
      redirect_to root_path, notice: 'グループが作成されました。'
    end
  end

  def edit
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name, {user_ids:[]})
  end

end
