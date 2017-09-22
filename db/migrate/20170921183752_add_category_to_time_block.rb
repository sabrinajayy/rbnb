class AddCategoryToTimeBlock < ActiveRecord::Migration[5.0]
  def change
    add_column :time_blocks, :category, :string
  end
end
