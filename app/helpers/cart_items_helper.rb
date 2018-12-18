module CartItemsHelper
  # カート内の個数と、その商品の在庫を比較する
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

  # カート内の商品金額と、商品テーブルの商品金額を比較する
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

  # 商品種類数が30を超えていないか確認する
  def check_cart_item_number
    unless @cart_item = current_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      if CartItem.where(user_id: current_user.id).count == 30
        flash[:danger] = "カートに保存できる商品は30種類までです。新しい商品を追加したい場合は、既存の商品を削除してください。"
        redirect_to cart_items_url
      end
    end
  end

  # カートに商品が存在するか確認する
  def check_existence_cart_items
    unless CartItem.where(user_id: current_user.id).exists?
      redirect_to root_path
      flash[:danger] = "カートに商品がありません。"
    end
  end
end
