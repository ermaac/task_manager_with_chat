class CreateInvitedUserPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :invited_user_permissions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :board, index: true
      t.boolean :create_message, default: true

      t.boolean :create_note, default: true
      t.boolean :edit_note, default: true
      t.boolean :delete_note, default: true
      t.boolean :move_note_to_other_list, default: true

      t.boolean :create_list, default: true
      t.boolean :edit_list_name, default: true
      t.boolean :delete_list, default: true
      t.boolean :freeze_list, default: false
      t.timestamps
    end
  end
end
