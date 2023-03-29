# frozen_string_literal: true

class AddAccessLevelToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :access_level, :integer, default: 0, limit: 1
  end
end
