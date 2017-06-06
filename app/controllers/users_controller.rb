class UsersController < ApplicationController

  def edit
  end

  def update
    current_user.update(update_params)
    if current_user.update(update_params)
      redirect_to root_path, notice: 'アカウントが更新されました'
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :email)
  end

end
