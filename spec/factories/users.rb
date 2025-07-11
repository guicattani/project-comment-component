FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    color { "green" }
  end
end
