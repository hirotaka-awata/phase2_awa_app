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

  #カート内の商品の価格の合計を計算し、返す
  def cart_items_total_price
    total_price = 0
    current_user.cart_items.each do |cart_item|
      total_price += cart_item.item_price * cart_item.quantity
    end
    return total_price
  end

end
