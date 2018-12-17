class OrdersController < ApplicationController
  include CartItemsHelper
  include OrdersHelper
  before_action :logged_in_user
  before_action :check_quantity, :check_item_price, :check_existence_cart_items, :check_address_selected, only: [:show, :create]

  def show
    @cart_items = current_user.cart_items
    @order = Order.new
    @total_quantity = @cart_items.sum(:quantity)
    @total_price = @cart_items.sum(:item_price)
  end

  def create
    order = current_user.orders.build(address: current_user.selected_address.address, total_quantity: current_user.cart_items.sum(:quantity), total_price: cart_items_total_price )
    if order.save
      current_user.cart_items.each do |cart_item|
        order_item = OrderItem.new(order_id: order.id, item_id: cart_item.item.id, item_price: cart_item.item_price, item_quantity: cart_item.quantity)
        order_item.save
        item = cart_item.item
        item.stock -= cart_item.quantity
        item.save
      end
      current_user.cart_items.destroy_all
      render 'completed' # renderの問題点を調べましょう（悪いとは言っていない）
    else
      flash[:danger] = "住所が選択されていないため、注文が確定できませんでした。" #なぜ、注文が確定しなかったのかユーザに知らせましょう。
      redirect_to orders_path
    end
  end

  def completed
  end

private
    def order_param
      params.require(:order).permit(:user_id, :address, :total_quantity, :total_price)
    end

end
