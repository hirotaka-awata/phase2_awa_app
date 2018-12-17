module CartItemsHelper
  def check_quantity
    current_user.cart_items.each do |cart_item|
      if cart_item.item.stock.zero?
        flash[:danger] = "カート内の商品（#{cart_item.item.name})の在庫がなくなったため、カートから削除しました。ご確認ください"
        cart_item.destroy
        redirect_to cart_items_url
      elsif cart_item.quantity > cart_item.item.stock
        flash[:danger] = "カート内の商品（#{cart_item.item.name})の在庫が足りなくなったため、カートの商品選択数を変更しました。ご確認ください"
        cart_item.quantity = cart_item.item.stock
        cart_item.save
        redirect_to cart_items_url
      end
    end
  end

  def check_item_price
    current_user.cart_items.each do |cart_item|
      unless cart_item.item_price == cart_item.item.price
        flash[:danger] = "カート内の商品（#{cart_item.item.name})の金額が変更されました。ご確認ください"
        cart_item.item_price = cart_item.item.price
        cart_item.save
        redirect_to cart_items_url
      end
    end
  end

  def check_cart_item_number
  end

  def check_existence_cart_items
    unless CartItem.where(user_id: current_user.id).exists?
      redirect_to root_path
      flash[:danger] = "カートに商品がありません。"
    end
  end

  def check_address_selected
    if current_user.delivery_address_id.nil?
      redirect_to addresses_select_path
      flash[:danger] = "住所が選択されていません。選択してください。"
    end
  end
end
