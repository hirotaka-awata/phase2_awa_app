class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :stock, presence: true
end
