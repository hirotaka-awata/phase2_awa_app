class CartItem < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :item, class_name: "Item"
  validates :user_id, presence: true, uniqueness: { scope: :item_id }
  validates :item_id, presence: true, uniqueness: { scope: :user_id }
  validates :item_price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10} 
end
