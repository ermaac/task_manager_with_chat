# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.belongs_to :board, index: true
      t.string :title

      t.timestamps
    end
  end
end
