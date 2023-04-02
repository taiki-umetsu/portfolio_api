# frozen_string_literal: true

class SkillSerializer < ActiveModel::Serializer
  attributes :id, :title, :level, :level_description, :order, :created_at, :updated_at

  delegate :level_description, to: :object
end
