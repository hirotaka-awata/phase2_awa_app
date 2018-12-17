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

  def select_address
    @addresses = current_user.addresses
    @user = current_user
  end

  def update_address
    if (address_id = params['/edit_address'][:address]) && Address.find_by(id: params['/edit_address'][:address])
      current_user.delivery_address_id = address_id
      if current_user.save
        redirect_to orders_path
      end
    else
      flash[:danger] = "住所が選択されていません。"
      redirect_to addresses_select_path
    end
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
