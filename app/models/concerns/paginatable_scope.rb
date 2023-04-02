# frozen_string_literal: true

module PaginatableScope
  extend ActiveSupport::Concern

  included do
    scope :sorted, ->(column, order) {
      if column_names.include?(column) && %w[ASC DESC].include?(order.upcase)
        order({ column => order })
      end
    }
    scope :paginated, ->(start, end_param) { offset(start).limit(end_param - start) }
  end
end
