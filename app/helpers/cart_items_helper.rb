module CartItemsHelper
# メソッド名がおかしい

  # カート内商品がitemsテーブルに存在するかどうかを確認する
  def check_item_existance
    @cart_items = current_user.cart_items
    current_user.cart_items.each do |cart_item|
      if cart_item.item.nil?
        cart_item.destroy
        flash[:danger] = "カートの中の商品がなくなりました。ご確認ください。"
        redirect_to cart_items_path
      end
    end
  end


  # カート内の商品の個数と、その商品の在庫を比較する
  def check_quantity
    if !(current_user.cart_items.empty?)
      current_user.cart_items.each do |cart_item|
        if cart_item.item.nil?
          flash[:danger] = "カート内の商品がなくなりました。ご確認ください。"
          cart_item.destroy
          redirect_to cart_items_url
        else
          if cart_item.item.stock.zero?
            flash[:danger] = "カート内の商品（#{cart_item.item.name})の在庫がなくなったため、カートから削除しました。ご確認ください"
            cart_item.destroy
            return redirect_to cart_items_url
          elsif cart_item.quantity > cart_item.item.stock
            flash[:danger] = "カート内の商品の在庫が足りなくなったため、カートの商品選択数を変更しました。ご確認ください"
            cart_item.quantity = cart_item.item.stock
            cart_item.save
            return redirect_to cart_items_url
          end
        end
      end
    end
  end

  # カート内の商品金額と、商品テーブルの商品金額を比較する
  def check_item_price
    if !(current_user.cart_items.empty?)
      current_user.cart_items.each do |cart_item|
        if cart_item.item.nil?
          flash[:danger] = "カート内の商品がなくなりました。ご確認ください。"
          cart_item.destroy
          redirect_to cart_items_url
        else
          unless cart_item.item_price == cart_item.item.price
            flash[:danger] = "カート内の商品（#{cart_item.item.name})の金額が変更されました。ご確認ください"
            cart_item.item_price = cart_item.item.price
            cart_item.save
            redirect_to cart_items_url
          end
        end
      end
    end
  end

  # # 商品種類数が30を超えていないか確認する => バリデーションに移行
  # def check_cart_item_number
  #   unless @cart_item = current_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
  #     if CartItem.where(user_id: current_user.id).count > 2
  #       flash[:danger] = "カートに保存できる商品は30種類までです。新しい商品を追加したい場合は、既存の商品を削除してください。"
  #       redirect_to cart_items_url
  #     end
  #   end
  # end

  # カートに商品が存在するか確認する
  def check_existence_cart_items
    unless CartItem.where(user_id: current_user.id).exists?
      redirect_to root_path
      flash[:danger] = "カートに商品がありません。"
    end
  end
end
