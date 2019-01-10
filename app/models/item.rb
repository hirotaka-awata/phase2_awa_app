class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :stock, presence: true

  # 渡された数字のハッシュ値を返す
  def Item.digest(integer)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(integer, cost: cost)
  end
end
