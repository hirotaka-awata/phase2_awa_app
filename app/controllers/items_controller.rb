class ItemsController < ApplicationController
  def home
    @items = Item.all.paginate(page: params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
    secret_value = Digest::SHA256.hexdigest "#{@item.id}"
    @item_id = Digest::SHA256.hexdigest "#{@item.id}#{secret_value}"
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path
    flash[:danger] = '商品が見つかりません。'
  end
end
