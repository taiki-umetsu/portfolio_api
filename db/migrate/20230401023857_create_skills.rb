# frozen_string_literal: true

class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :title, null: false
      t.integer :level, default: 0, limit: 1, null: false

      t.timestamps
    end
  end
end
