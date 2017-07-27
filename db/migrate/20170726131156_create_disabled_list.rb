class CreateDisabledList < ActiveRecord::Migration[5.1]
  def change
    create_table :disabled_lists do |t|
      t.belongs_to :profile, index: true
      t.belongs_to :list, index: true
    end
  end
end
