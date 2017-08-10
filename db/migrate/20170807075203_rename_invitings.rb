class RenameInvitings < ActiveRecord::Migration[5.1]
  def change
    rename_table :invitings, :invitations
  end
end
