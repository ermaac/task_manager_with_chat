class UpdateForeignKeyInBoards < ActiveRecord::Migration[5.1]
  def change
    change_column :boards, :profile_id, :integer, limit: 8, index: true
  end
end
