class DropDisabledLists < ActiveRecord::Migration[5.1]
  def change
    drop_table :disabled_lists
  end
end
