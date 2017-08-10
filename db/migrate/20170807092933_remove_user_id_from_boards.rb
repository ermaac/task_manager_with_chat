class RemoveUserIdFromBoards < ActiveRecord::Migration[5.1]
  def change
    remove_column :boards, :user_id
  end
end
