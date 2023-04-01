# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  def pagination_params
    {
      sort: params.fetch(:_sort, "id"),
      order: params.fetch(:_order, "ASC"),
      start: params.fetch(:_start, 0).to_i,
      end_param: params.fetch(:_end, 10).to_i
    }
  end
end
