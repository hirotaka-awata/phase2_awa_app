require 'rails_helper'

RSpec.describe User,type: :model do
# 名前、メール、パスワード、配達住所IDがあれば有効な状態であること
it "is valid with a first name, last name, email, and password" do
  user = User.new(
    id: 1,
    name: "Awata Hirotaka",
    email: "awata.hirotaka@lmi.ne.jp",
    password_digest: "$2a$10$cCq6tBqHl/GYfAdrrsY13Ounj04AdvCvBNBmnXdRVX6ijkK2j6QYK",
    delivery_address_id: 1,
    created_at: "2018-12-26 09:40:00",
    updated_at: "2019-01-06 05:16:08"
  )
  expect(user).to be_valid
end

# 名前がなければ無効な状態であること
it "is invalid without name" do
  user = User.new(name: nil)
  user.valid?
  expect(user.errors[:name]).to include("can't be blank")
end

# メールアドレスがなければ無効な状態であること
it "is invalid without an email address" do
  user = User.new(email: nil)
  user.valid?
  expect(user.errors[:email]).to include("can't be blank")
end

# 重複したメールアドレスなら無効な状態であること
it "is invalid with a duplicate email address" do
  User.create(
  )
end
# ユーザーのフルネームを文字列として返すこと
it "returns a user's full name as a string"
end
