class CartItemsController < ApplicationController
  include CartItemsHelper
  include OrdersHelper
  before_action :logged_in_user
  before_action :check_quantity, :check_item_price, only: [:show]

  def create
    # 関連付けでレコードを作りましょう（そしてなぜ、CartItem.find_byがダメなのかを明確にしましょう）
    if cart_item = current_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
    else
      cart_item = current_user.cart_items.build(item_id: params[:cart_item][:item_id], item_price: Item.find(params[:cart_item][:item_id]).price, quantity: params[:cart_item][:quantity])
    end
    if cart_item.save
      flash[:success] = "カートに商品が追加されました。"
    else
      flash[:danger] = "カートに商品を追加できませんでした。"
    end
    redirect_to cart_items_url
  end

  def destroy
    if cart_item = CartItem.find_by(id: params[:id])
      cart_item.destroy
    end
    redirect_to cart_items_url
  end

  def show   # Restfulなのか？
    @cart_items = current_user.cart_items
    @total_price = cart_items_total_price
    @cart_item = CartItem.new
  end

  def update
    unless params[:cart_item][:quantity].empty?
      @cart_item = CartItem.find(params[:cart_item][:id])
      if @cart_item.update_attribute(:quantity, params[:cart_item][:quantity])
        flash[:success] = "#{@cart_item.item.name}の数量を変更しました"
      else
        flash[:danger] = "商品数量を変更できませんでした"
      end
    else
      flash[:danger] = "変更する数量を選択してください。"  # どういう時にこれが発生するの？
    end
    redirect_to cart_items_url
  end

  private
  def cart_item_param
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
