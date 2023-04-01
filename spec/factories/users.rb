# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }

    trait :read_only do
      access_level { User::AccessLevel::READ_ONLY }
    end

    trait :full do
      access_level { User::AccessLevel::FULL }
    end
  end
end
