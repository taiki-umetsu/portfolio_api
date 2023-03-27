# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PortfolioApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.middleware.insert_before 0, Rack::Cors do
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
                 expose: ["X-Total-Count"]
      end
    end
  end
end
