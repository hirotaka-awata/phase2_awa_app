class OrdersController < ApplicationController
  before_action :logged_in_user, only:[:show, :completed]
  
  def show
    @cart_items = current_user.cart_items
    @order = Order.new
    @total_quantity = @cart_items.sum(:quantity)
    @total_price = @cart_items.sum(:item_price)
  end

  def create
    @order = Order.new(order_param)
    if @order.save
      current_user.cart_items.each do |cart_item|
        @order_item = OrderItem.new(order_id: @order.id, item_id: cart_item.item.id, item_price: cart_item.item_price, item_quantity: cart_item.quantity)
        @order_item.save
        @item = cart_item.item
        @item.stock -= cart_item.quantity
        @item.save
      end
      current_user.cart_items.destroy_all
      redirect_to orders_completed_path
    end
  end

  def completed
  end

private
 def order_param
   params.require(:order).permit(:user_id, :address, :total_quantity, :total_price)
 end

end
