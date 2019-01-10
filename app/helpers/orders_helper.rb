module OrdersHelper
  # 住所が選択されているかどうか確認する
  def check_address_selected
    if current_user.delivery_address_id.nil?
      redirect_to select_address_path
      flash[:danger] = "住所が選択されていません。選択してください。"
    elsif Address.find_by(id: current_user.delivery_address_id).nil?
      redirect_to select_address_path
      flash[:danger] = "住所が選択されていません。選択してください。"
    end
  end

  #注文確定確認画面にて表示されている商品が、Itemテーブルに存在するか確認する
  # def check_item_existance_before
  #   current_user.cart_items.each do |cart_item|
  #     unless Item.find_by(id: cart_item.item.id)
  #       cart_item.destroy
  #       flash[:danger] = "カートの中の商品が削除されました。ご確認ください。"
  #       redirect_to cart_items_path
  #     end
  #   end
  # end

  # orders/showページに表示されている住所がusersテーブルのdelivery_address_idカラムに保存されているに紐づいた住所を確認する
  def check_delivery_address
    unless (Digest::SHA256.hexdigest ("#{current_user.delivery_address_id}")) == params[:order][:address_id]
      redirect_to orders_path
      flash[:danger] = "選択された住所が変更されました。ご確認ください。"
    end
  end

  #カート内の商品の価格の合計を計算し、返す
  def cart_items_total_price
    total_price = 0
    current_user.cart_items.each do |cart_item|
      total_price += cart_item.item_price * cart_item.quantity
    end
    return total_price
  end

end
