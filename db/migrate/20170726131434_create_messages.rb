class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :text
      t.belongs_to :profile, index: true
      t.belongs_to :chat, index: true
    end
  end
end
