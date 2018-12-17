class User < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_one :selected_address, class_name: "Address"
  has_many :items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders
  before_save   :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end



  private
  # メールアドレスをすべて小文字にする
   def downcase_email
     self.email = email.downcase
   end
end
