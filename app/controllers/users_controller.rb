class UsersController < ApplicationController

  def search
    keyword = "%#{params[:keyword]}%"
    @users = User.where('name LIKE(?)', keyword).order('id ASC').limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def update
    current_user.update(update_params)
    if current_user.update(update_params)
      redirect_to root_path, notice: 'アカウント情報が変更されました'
    else
      redirect_to edit_user_path(current_user), alert: 'アカウント情報が更新されませんでした。'
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :email)
  end

end
