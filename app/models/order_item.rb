class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :item_price, presence: true
  validates :item_quantity, presence: true
end
