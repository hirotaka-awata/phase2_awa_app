class SelectAddressesController < ApplicationController
  include CartItemsHelper
  include OrdersHelper
  before_action :logged_in_user
  before_action :check_quantity, :check_item_price, :check_item_existance, only: [:show]
  before_action :check_params, only: [:update]

  def show
    @addresses = current_user.addresses
    @user = current_user
  end

  def update
    current_user.delivery_address_id = @address_id
    if current_user.save
      redirect_to orders_path
    end
  end

  # before
  # 住所選択ページにて住所が選択されているかどうか
  def check_params
    if !(@address_id = params[:user][:delivery_address_id])
      flash[:danger] = "住所が選択されていません。"
      redirect_to select_address_path
    elsif !(selected_address = Address.find_by(id: @address_id))
      flash[:danger] = "選択された住所は、登録されていません。"
      redirect_to select_address_path
    elsif !(current_user.id == selected_address.user_id)
      flash[:danger] = "パラメータが改竄されました。"
      redirect_to select_address_path
    end
  end
end
