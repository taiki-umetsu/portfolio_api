# frozen_string_literal: true

class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts do |t|
      t.text :description, null: false

      t.timestamps
    end
  end
end
