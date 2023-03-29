# frozen_string_literal: true

require "swagger_helper"

describe "Authentication API" do
  let(:valid_user) { create(:user) }

  path "/users/sign_in" do
    post "Sign in" do
      tags "Authentication"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response "200", "logged in" do
        produces "application/json"
        header "Authorization", schema: { type: :string }, description: "JWT token for the authenticated user"

        let(:user) do
          { user: { email: valid_user.email, password: valid_user.password } }
        end
        run_test! do
          expect(response.headers["Authorization"]).to be_present
        end
      end

      response "401", "invalid credentials" do
        let(:user) do
          { user: { email: valid_user.email, password: "wrong_password" } }
        end
        run_test! do
          expect(response.headers["Authorization"]).not_to be_present
        end
      end
    end
  end

  path "/users/sign_out" do
    delete "Sign out" do
      tags "Authentication"
      security [Bearer: []]
      consumes "application/json"

      response "200", "logged out" do
        let(:Authorization) { "Bearer #{valid_user.generate_jwt}" }
        run_test! do
          expect(response.headers["Authorization"]).not_to be_present
        end
      end
    end
  end
end
