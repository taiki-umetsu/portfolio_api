# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/abouts", type: :request do
  let(:read_only_user) { create(:user, :read_only) }
  let(:full_access_user) { create(:user, :full) }

  path "/api/v1/abouts" do
    get("get abouts") do
      before do
        sign_in read_only_user
      end

      tags "Abouts"
      produces "application/json"
      response(200, "successful") do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   description: { type: :string }
                 },
                 required: %w[id description]
               }
        header "X-Total-Count", schema: { type: :integer }, description: "Total count of about items"
        run_test!
      end
    end
  end

  path "/api/v1/abouts/{id}" do
    get("show about") do
      before do
        sign_in read_only_user
      end

      tags "Abouts"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, required: true
      let(:id) { About.instance.id }

      response(200, "successful") do
        schema type: :object,
               properties: {
                 description: { type: :string }
               },
               required: %w[description]
        run_test!
      end

      response(404, "Record not found") do
        let(:id) { 0 }
        run_test!
      end
    end

    patch("update about.description") do
      tags "Abouts"
      consumes "application/json"
      let(:id) { About.instance.id }
      parameter name: :about, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: %w[description]
      }
      parameter name: :id, in: :path, type: :integer, required: true

      context "when user has full access" do
        before do
          sign_in full_access_user
        end

        response(200, "successful") do
          let(:about) { { description: "Updated description" } }
          run_test!
        end

        response(422, "Unprocessable Entity") do
          let(:about) { { description: "" } }
          run_test!
        end
      end

      context "when user has read-only access" do
        before do
          sign_in read_only_user
        end

        response(403, "Forbidden") do
          let(:about) { { description: "Updated description" } }
          run_test!
        end
      end
    end
  end
end
