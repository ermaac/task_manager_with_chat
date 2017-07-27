class UpdateColumnsInInvitings < ActiveRecord::Migration[5.1]
  def change
    remove_column :invitings, :invitor_id, :string
    remove_column :invitings, :user_to_invite_id, :string
    add_column :invitings, :invitor_id, :integer, limit: 8
    add_column :invitings, :user_to_invite_id, :integer, limit: 8
    remove_column :invitings, :accepted
    add_column :invitings, :accepted, :boolean
    add_foreign_key :invitings, :users, column: :invitor_id
    add_foreign_key :invitings, :users, column: :user_to_invite_id
    change_column_default :invitings, :accepted, from: nil, to: false
  end
end
