class CreateBoardsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_boards do |t|
      t.belongs_to :user
      t.belongs_to :board
    end
  end
end
