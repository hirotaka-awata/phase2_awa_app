class Address < ApplicationRecord
  belongs_to :user, class_name: "User"
  validates :user_id, presence: true
  validates :address, presence: true
end
