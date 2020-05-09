class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    
    if @user.save
      flash[:success] = 'ユーザ登録を完了しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました'
      render :new
    end
  end
end
