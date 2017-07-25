class ChangeForeignKeyOfProfile < ActiveRecord::Migration[5.1]
  def change
    rename_column :profiles, :User_id, :user_id
    change_column_null :profiles, :user_id, false
  end
end
