# frozen_string_literal: true

class About < ApplicationRecord
  validates :description, presence: true

  def self.instance
    first_or_create(description: "hello world")
  end
end
