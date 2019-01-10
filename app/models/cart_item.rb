class CartItem < ApplicationRecord
  include SessionsHelper
  belongs_to :user, class_name: "User"
  belongs_to :item, class_name: "Item"
  validates :user_id, presence: true, uniqueness: { scope: :item_id }
  validates :item_id, presence: true, uniqueness: { scope: :user_id }
  validates :item_price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10,
            message: "カートに保持できる一つの商品数は10までです。"}
  validate :cart_item_number_less_than_30?, on: :create

 private
    def cart_item_number_less_than_30?
      if user.cart_items.count >= 30
        errors.add(:base, "カートに保持できる商品の種類数を超えています。新しくカートに商品を追加したい場合は、既存の商品を削除してください。")
      end
    end
end
