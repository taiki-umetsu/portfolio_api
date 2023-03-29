# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  include CanCan::ControllerAdditions
  load_and_authorize_resource

  private

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
