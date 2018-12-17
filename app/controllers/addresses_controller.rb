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

  def destroy
    Address.find(params[:id]).destroy
    redirect_to addresses_path
  end
end
