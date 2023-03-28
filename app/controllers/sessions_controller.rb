# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first
    render json: { jwt: token, message: "You are logged in." }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: "You are logged out." }, status: :ok
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
