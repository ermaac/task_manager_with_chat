class AddIsDisabledColumnForList < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :is_disabled, :boolean
  end
end
