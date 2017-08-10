class AddCreatorIdToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :creator_id, :bigint
  end
end
