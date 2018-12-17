class Order < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :address, presence: true
  validates :total_quantity, presence: true
  validates :total_price, presence: true
end
