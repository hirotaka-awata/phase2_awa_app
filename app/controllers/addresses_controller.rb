class AddressesController < ApplicationController
  before_action :logged_in_user, only:[:new,:index]
  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build(params.require(:address).permit(:address))
    if @address.save
      flash[:success] = "住所が追加されました"
      redirect_to '/addresses'
    else
      render 'new'
    end
  end

  def index
    @addresses = current_user.addresses
  end

  def select
    @addresses = current_user.addresses
    @user = current_user
  end

  def update
    if params['/edit_address'][:address].empty?
      flash[:error] = "住所が選択されていません。"
      redirect_to addresses_select_path
    else
      address_id = params['/edit_address'][:address]
      current_user.address_id = address_id
      if current_user.save
        redirect_to orders_path
      end
    end
  end
end
