class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "アカウントが作成されました。"
      redirect_to @user
      log_in @user
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    @addresses = current_user.addresses
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit_address
    redirect_to orders_path
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
