class ItemsController < ApplicationController
  def home
    @items = Item.all.paginate(page: params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end
end
