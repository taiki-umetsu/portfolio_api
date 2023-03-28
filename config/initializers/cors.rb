# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "portfolio.taikiumetsu.dev",
            "portfolio-admin.taikiumetsu.dev",
            "portfolio-admin-git-staging-taiki-umetsu.vercel.app",
            "localhost:3000",
            "localhost:8080"
    resource "*",
             headers: :any,
             methods: %i[get post patch put delete options head],
             credentials: true,
             expose: %w[X-Total-Count Authorization]
  end
end
