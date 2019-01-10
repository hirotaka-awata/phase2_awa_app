class AddressesController < ApplicationController
  include AddressesHelper
  before_action :logged_in_user, only:[:new,:index]
  before_action :check_user_save_number, only: [:new, :create]
  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build(params.require(:address).permit(:address))
    if @address.save
      flash[:success] = "住所が追加されました"
      redirect_to addresses_path
    else
      render 'new'
    end
  end

  def index
    @addresses = current_user.addresses
  end


  def destroy
    Address.find(params[:id]).destroy
    redirect_to addresses_path
  rescue ActiveRecord::RecordNotFound => e
    flash[:danger] = '住所が見つかりません。'
    redirect_to addresses_path
  end
end
