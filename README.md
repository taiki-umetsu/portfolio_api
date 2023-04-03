# Versions

- Ruby: 3.2.1
- Ruby on Rails: 7.0.4.3

# Gems

### API Document

- rswag
- URL: https://portfolio-api.taikiumetsu.dev/api-docs/index.html
  <img src="public/images/readme/api_docs.png">

### Authentication

- devise
- devise-jwt

### User Access Level

- cancancan
- To manage permissions and restrict access to the APIs, users have one of the following access levels:
  - _Read-only_
  - _Full access_

### Serializer

- active_model_serializers

### Test

- rspec-rails
- rswag-specs
- database_cleaner
- factory_bot_rails

### Formatter

- rubocop
- VSCode settings.json is like this:

  ```json
    "[ruby]": {
      "editor.defaultFormatter": "misogi.ruby-rubocop",
      "editor.formatOnSave": true
    }
  ```

# CI/CD

- GitHub Actions
- setting file: `.github/workflows/fly.yml`
- trigger branch: main
- run tests
- run deployment
- run `rails db:seed`

# Infrastructure

- [Fly.io](https://fly.io/dashboard/)

# DB

- PostgreSQL

# Domain

- [Google Domains](https://domains.google.com/registrar/)

# This API is used in the following locations:

### Portfolio page

- https://portfolio.taikiumetsu.dev/
- https://github.com/taiki-umetsu/portfolio-ui

### Admin page

- https://portfolio-admin.taikiumetsu.dev/
- https://github.com/taiki-umetsu/portfolio-admin
