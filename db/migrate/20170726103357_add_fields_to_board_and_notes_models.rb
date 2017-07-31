class AddFieldsToBoardAndNotesModels < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :description, :text
    add_column :notes, :text, :text
  end
end
