class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :sex
      t.string :phone
      t.string :photo_url
      t.belongs_to :user, index: true
    end
  end
end
