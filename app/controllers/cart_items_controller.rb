class CartItemsController < ApplicationController
  include CartItemsHelper
  include OrdersHelper
  before_action :logged_in_user, :check_item_existance
  before_action :check_quantity, :check_item_price, only: [:index]
  before_action :check_item_id_params_alter, only: [:create]
  before_action :check_cart_item_params_alter, only: [:update, :destroy]

  def index
    @cart_items = current_user.cart_items
    @total_price = cart_items_total_price
    @cart_item = CartItem.new
  end

  def create
    ActiveRecord::Base.transaction do
      # if current_user.cart_items.exists?
      #   CartItem.where(id: current_user.cart_items.ids).lock!.reload
      # end
      current_user.cart_items.lock!.reload
      if @cart_item = current_user.cart_items.find_by(item_id: @item_id)
        @cart_item.quantity += params[:cart_item][:quantity].to_i
      else
        @cart_item = current_user.cart_items.build(item_id: @item_id, item_price: @item.price, quantity: params[:cart_item][:quantity])
      end
      @cart_item.save!
    end
    flash[:success] = "カートに商品が追加されました。"
    redirect_to cart_items_path
  rescue ActiveRecord::RecordInvalid
    redirect_to cart_items_path,
    alert: @cart_item.errors.messages.values
  end

  def destroy
    CartItem.find(params[:id]).destroy
    flash[:success] = "商品をカートから削除しました。"
    redirect_to cart_items_url
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update!(quantity: params[:cart_item][:quantity])
    flash[:success] = "#{@cart_item.item.name}の数量を変更しました"
    redirect_to cart_items_path
  rescue ActiveRecord::RecordInvalid
    redirect_to cart_items_path
    flash[:danger] = @cart_item.errors.full_messages
  end

  # beforeアクション

  # items_idのパラメータの改竄のチェック
  # itemsテーブル中の当該の商品の存在の確認
  # itemsテーブル中の当該の商品の在庫数の確認
  def check_item_id_params_alter #メソッド名要変更
    @item_id = params[:cart_item][:id].to_i
    secret_value = Digest::SHA256.hexdigest "#{@item_id}"
    if !((Digest::SHA256.hexdigest "#{@item_id}#{secret_value}") == params[:cart_item][:hash_id])
      flash[:danger] = "パラメータが改竄されたため、カートに追加できませんでした。"
      redirect_to cart_items_path
    elsif !(@item = Item.find_by(id: @item_id))
      flash[:danger] = "選択した商品はなくなったため、カートに追加できませんでした。"
      redirect_to cart_items_path
    elsif !(@item.stock > 0)
      flash[:danger] = "選択した商品の在庫がなくなったため、カートに追加できませんでした。"
      redirect_to cart_items_path
    end
  end

  # パラメータの改竄をチェックする
  def check_cart_item_params_alter
    if !((Digest::SHA256.hexdigest "#{params[:id]}") == params[:cart_item][:hash_id])
      flash[:danger] = "パラメータが改竄されたため、商品を削除できませんでした。"
      redirect_to cart_items_path
    end
  end


end
