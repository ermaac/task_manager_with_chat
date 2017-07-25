class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :User
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.integer :sex
      t.string :phone
      t.text :photo_url
    end
  end
end
