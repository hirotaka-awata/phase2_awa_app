class ItemsController < ApplicationController
  def home
    @items = Item.all.paginate(page: params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new
    @item.name = params[:item][:name]
    @item.price = params[:item][:price]
    @item.picture = params[:item][:picture]
    @item.description = params[:item][:description]
    @item.stock = params[:item][:stock]
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end
end
