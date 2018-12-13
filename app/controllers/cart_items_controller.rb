class CartItemsController < ApplicationController
  before_action :logged_in_user, only:[:show, :create]

  def create
    if @exist_cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], user_id: current_user.id)
      @exist_cart_item.quantity += params[:cart_item][:quantity].to_i
      @exist_cart_item.save
      redirect_to cart_items_url
    else
      @cart_item = CartItem.new(cart_item_param)
      @cart_item.save
      redirect_to cart_items_url
    end
  end

  def destroy
    CartItem.find(params[:id]).destroy
    redirect_to cart_items_url
  end

  def show
    @cart_items = current_user.cart_items
  end

 def edit
   if params['/cart_items'][:quantity].empty?
    redirect_to cart_items_url
  else
     @cart_item = CartItem.find(params[:cart_item][:id])
     @cart_item.update_attribute(:quantity, params['/cart_items'][:quantity])
     @cart_item.update_attribute(:updated_at, Time.zone.now)
     if @cart_item.save
       redirect_to cart_items_url
     end
   end
 end

private
 def cart_item_param
   params.require(:cart_item).permit(:user_id, :item_id, :item_price, :quantity)
 end
end
