# frozen_string_literal: true

users = [
  {
    email: "demo-user@example.com",
    password: "demouserpassword",
    access_level: User::AccessLevel::READ_ONLY
  },
  {
    email: "portfolio-ui@example.com",
    password: "portfoliouipassword",
    access_level: User::AccessLevel::READ_ONLY
  },
  { email: ENV.fetch("ADMIN_USER_EMAIL", nil),
    password: ENV.fetch("ADMIN_USER_PASSWORD", nil),
    access_level: User::AccessLevel::FULL }
]

users.each do |user|
  User.find_or_create_by(email: user[:email]) do |u|
    u.password = user[:password]
    u.access_level = user[:access_level]
  end
end
