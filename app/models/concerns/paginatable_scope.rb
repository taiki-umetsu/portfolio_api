# frozen_string_literal: true

module PaginatableScope
  extend ActiveSupport::Concern

  included do
    scope :sorted, ->(sort, order) { order("#{sort} #{order}") }
    scope :paginated, ->(start, end_param) { offset(start).limit(end_param - start) }
  end
end
