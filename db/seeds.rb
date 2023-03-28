# frozen_string_literal: true

User.find_or_create_by(email: "demo-user@example.com") do |user|
  user.password = "demouserpassword"
end
