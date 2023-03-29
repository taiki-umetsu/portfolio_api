# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json
  skip_load_and_authorize_resource

  private

  def respond_with(_resource, _opts = {})
    render json: { message: "You are logged in." }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: "You are logged out." }, status: :ok
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
