module OrdersHelper
  def cart_items_total_price
    total_price = 0
    current_user.cart_items.each do |cart_item|
      total_price += cart_item.item_price * cart_item.quantity
    end
    return total_price
  end

end
