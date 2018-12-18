module AddressesHelper
  def check_user_save_number
    if Address.where(user_id: current_user.id).count == 10
      flash[:danger] = "登録できる住所数は10個です。新しい住所を登録したい場合は、既存の住所を削除してください。"
      redirect_to addresses_path
    end
  end
end
