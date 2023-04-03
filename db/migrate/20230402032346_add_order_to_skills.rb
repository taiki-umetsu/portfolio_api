# frozen_string_literal: true

class AddOrderToSkills < ActiveRecord::Migration[7.0]
  def change
    add_column :skills, :order, :integer, default: 0, limit: 1, null: false
  end
end
