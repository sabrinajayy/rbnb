class ModifyPhoneNumber < ActiveRecord::Migration[5.0]
  def change
    change_column :consumers, :phone_number, :string
  end
end
