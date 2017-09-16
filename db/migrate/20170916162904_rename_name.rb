class RenameName < ActiveRecord::Migration[5.0]
  def change
    rename_column :consumers, :name, :first_name
  end
end
