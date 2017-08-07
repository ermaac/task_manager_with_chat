class RemoveColumnSexFromProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :sex, :string
    add_column :profiles, :sex, :integer
  end
end
