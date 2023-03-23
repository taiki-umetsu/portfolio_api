# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/about", type: :request do
  path "/api/v1/about" do
    get("GET About.description") do
      tags "About"
      produces "application/json"
      response(200, "successful") do
        schema type: :object,
               properties: {
                 description: { type: :string }
               },
               required: ["description"]
        run_test!
      end
    end

    patch("UPDATE About.description") do
      tags "About"
      consumes "application/json"
      parameter name: :about, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ["description"]
      }

      response(200, "successful") do
        let(:about) { { description: "Updated description" } }
        run_test!
      end

      response(422, "Unprocessable Entity") do
        let(:about) { { description: "" } }
        run_test!
      end
    end
  end
end
