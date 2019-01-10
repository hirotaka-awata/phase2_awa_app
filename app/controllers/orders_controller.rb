class OrdersController < ApplicationController
  include CartItemsHelper
  include OrdersHelper
  before_action :logged_in_user
  before_action :check_quantity, :check_item_price, :check_existence_cart_items, :check_address_selected, only: [:show]
  before_action :check_item_existance, only: [:create]

  def show
    @cart_items = current_user.cart_items
    @order = Order.new
    @total_quantity = @cart_items.sum(:quantity)
    @total_price = cart_items_total_price
    @address_id = Digest::SHA256.hexdigest "#{current_user.delivery_address_id}"
    @cart_item_array = []
    @cart_items.each do |cart_item|
      @cart_item_array.push(cart_item.item_id, cart_item.item_price, cart_item.quantity)
    end
    @cart_item_secret = Digest::SHA256.hexdigest "#{@cart_item_array}"
  end

  def create
    ActiveRecord::Base.transaction do
      if current_user.cart_items.exists?
        CartItem.where(id: current_user.cart_items.ids).lock!.reload
      end
      @cart_item_array = []
      current_user.cart_items.each do |cart_item|
        if cart_item.item.stock.zero?
          flash[:danger] = "カート内の商品（#{cart_item.item.name})の在庫がなくなったため、カートから削除しました。ご確認ください"
          cart_item.destroy
          return redirect_to cart_items_url
        elsif cart_item.quantity > cart_item.item.stock
          flash[:danger] = "カート内の商品（#{cart_item.item.name})の在庫が足りなくなったため、カートの商品選択数を変更しました。ご確認ください"
          cart_item.quantity = cart_item.item.stock
          cart_item.save!
          return redirect_to cart_items_url
        elsif !(cart_item.item_price == cart_item.item.price)
          flash[:danger] = "カート内の商品（#{cart_item.item.name})の金額が変更されました。ご確認ください"
          cart_item.item_price = cart_item.item.price
          cart_item.save!
          return redirect_to cart_items_url
        end
        @cart_item_array.push(cart_item.item_id, cart_item.item_price, cart_item.quantity)
      end
    end
    if (Digest::SHA256.hexdigest "#{@cart_item_array}") != params[:order][:cart_data]
      flash[:danger] = "カートの商品が変更されました。ご確認ください。"
      return redirect_to orders_path
    end
    selected_address = Address.find(current_user.delivery_address_id)
    if !((Digest::SHA256.hexdigest ("#{current_user.delivery_address_id}")) == params[:order][:address_id])
      flash[:danger] = "選択された住所が変更されました。ご確認ください。"
      return redirect_to orders_path
    end
    order = current_user.orders.build(address: selected_address.address, total_quantity: current_user.cart_items.sum(:quantity), total_price: cart_items_total_price )
    order.save!
    current_user.cart_items.each do |cart_item|
      order_item = order.order_items.create(item_id: cart_item.item.id, item_price: cart_item.item_price, item_quantity: cart_item.quantity)
      item = cart_item.item
      item.stock -= cart_item.quantity
      item.save!
    end
    current_user.cart_items.destroy_all
    render 'completed'
  rescue ActiveRecord::RecordNotFound
    redirect_to select_address_path
    flash[:danger] = "住所が選択されていません"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to orders_path,
    alert: e.record.errors.messages.values
  end

  def completed
  end

  #before_action
  def check_cart_item_data
    cart_items = current_user.cart_items
    cart_item_array = []
    cart_items.each do |cart_item|
      cart_item_array.push(cart_item.item_id, cart_item.item_price, cart_item.item_price)
    end
    if (Digest::SHA256.hexdigest "#{cart_item_array}") != params[:order][:cart_data]
      flash[:danger] = "カートの商品が変更されました。ご確認ください。"
      return redirect_to orders_path
    end
  end
end
