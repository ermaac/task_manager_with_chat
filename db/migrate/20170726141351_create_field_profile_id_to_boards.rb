class CreateFieldProfileIdToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :profile_id, :integer
  end
end
