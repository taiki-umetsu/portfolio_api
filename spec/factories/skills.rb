FactoryBot.define do
  factory :skill do
    title { "skill example" }
    level { 0 }
    sequence(:order) { |n| n }
  end
end
