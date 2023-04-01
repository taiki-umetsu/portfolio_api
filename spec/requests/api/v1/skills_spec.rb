# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/skills", type: :request do
  let(:read_only_user) { create(:user, :read_only) }
  let(:full_access_user) { create(:user, :full) }

  path "/api/v1/skills" do
    get("list skills") do
      before do
        sign_in read_only_user
        create_list(:skill, 11)
      end

      tags "Skills"
      produces "application/json"
      parameter name: "_start", in: :query, type: :integer, required: false, description: "Start index for pagination"
      parameter name: "_end", in: :query, type: :integer, required: false, description: "End index for pagination"
      parameter name: "_order", in: :query, type: :string, required: false, description: "Order direction (ASC or DESC)"
      parameter name: "_sort", in: :query, type: :string, required: false, description: "Sort by attribute"

      let(:_start) { 0 }
      let(:_end) { 10 }
      let(:_order) { "ASC" }
      let(:_sort) { "id" }

      response(200, "successful") do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   level: { type: :integer },
                   level_description: { type: :string },
                   created_at: { type: :string, format: "date-time" },
                   updated_at: { type: :string, format: "date-time" }
                 },
                 required: %w[id title level level_description created_at updated_at]
               }
        header "X-Total-Count", schema: { type: :integer }, description: "Total count of skills"
        run_test! do |response|
          expect(JSON.parse(response.body).size).to eq(10)
        end
      end
    end

    post("create skill") do
      tags "Skills"
      consumes "application/json"
      parameter name: :skill, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          level: { type: :integer }
        },
        required: %w[title level]
      }

      context "when user has full access" do
        before do
          sign_in full_access_user
        end

        response(201, "created") do
          let(:skill) { { title: "New skill", level: Skill::LEVEL_DESCRIPTION.keys.sample } }
          run_test! do
            expect(Skill.count).to eq(1)
          end
        end

        response(422, "Unprocessable Entity") do
          let(:skill) { { title: "", level: "" } }
          run_test! do
            expect(Skill.count).to eq(0)
          end
        end
      end

      context "when user has read-only access" do
        before do
          sign_in read_only_user
        end

        response(403, "Forbidden") do
          let(:skill) { { title: "New skill", level: 1 } }
          run_test!
        end
      end
    end
  end

  path "/api/v1/skills/{id}" do
    parameter name: "id", in: :path, type: :integer, required: true, description: "id"
    let(:skill) { create(:skill) }
    let(:id) { skill.id }

    get("show skill") do
      before do
        sign_in read_only_user
      end
      tags "Skills"
      produces "application/json"

      response(200, "successful") do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 level: { type: :integer },
                 level_description: { type: :string },
                 created_at: { type: :string, format: "date-time" },
                 updated_at: { type: :string, format: "date-time" }
               },
               required: %w[id title level level_description created_at updated_at]
        run_test!
      end

      response(404, "Record not found") do
        let(:id) { 0 }
        run_test!
      end
    end

    patch("update skill") do
      tags "Skills"
      consumes "application/json"
      let(:id) { create(:skill).id }
      parameter name: :skill, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          level: { type: :integer }
        },
        required: %w[title level]
      }
      parameter name: :id, in: :path, type: :integer, required: true

      context "when user has full access" do
        before do
          sign_in full_access_user
        end

        response(200, "successful") do
          let(:skill) { { title: "Updated title", level: 10 } }
          run_test!
        end

        response(422, "Unprocessable Entity") do
          let(:skill) { { title: "", level: "" } }
          run_test!
        end
      end

      context "when user has read-only access" do
        before do
          sign_in read_only_user
        end

        response(403, "Forbidden") do
          let(:skill) { { title: "Updated title", level: 10 } }
          run_test!
        end
      end
    end

    delete("destroy skill") do
      tags "Skills"

      context "when user has full access" do
        before do
          sign_in full_access_user
        end

        response(200, "successful") do
          schema type: :object,
                 properties: {
                   message: { type: :string }
                 },
                 required: %w[message]
          run_test!
        end
      end

      context "when user has read-only access" do
        before do
          sign_in read_only_user
        end

        response(403, "Forbidden") do
          run_test!
        end
      end
    end
  end
end
