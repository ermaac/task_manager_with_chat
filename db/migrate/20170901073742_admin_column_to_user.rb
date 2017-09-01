class AdminColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, column_options: { null: false }
  end
end
