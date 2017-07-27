class CreateTableInvitings < ActiveRecord::Migration[5.1]
  def change
    create_table :invitings do |t|
      t.string :invitor_id
      t.string :user_to_invite_id
      t.belongs_to :board, index: true
      t.string :accepted
    end
  end
end
