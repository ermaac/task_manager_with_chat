class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.belongs_to :board, index: true
      t.string :enabled
    end
  end
end
