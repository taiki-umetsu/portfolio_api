# frozen_string_literal: true

class Skill < ApplicationRecord
  validates :title, presence: true
  validates :level, presence: true, numericality: { only_integer: true }, inclusion: { in: LEVEL_DESCRIPTION.keys }

  LEVEL_DESCRIPTION = {
    0 => "beginner",
    10 => "professional"
  }.freeze

  def level_description
    LEVEL_DESCRIPTION[self.level]
  end
end
