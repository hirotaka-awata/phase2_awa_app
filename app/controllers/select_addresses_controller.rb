class SelectAddressesController < ApplicationController

  def show
    @addresses = current_user.addresses
    @user = current_user
  end

  def update
    if (address_id = params[:user][:delivery_address_id]) && Address.find_by(id: params[:user][:delivery_address_id])
      current_user.delivery_address_id = address_id
      if current_user.save
        redirect_to orders_path
      end
    else
      flash[:danger] = "住所が選択されていません。"
      redirect_to select_address_path
    end
  end

end
