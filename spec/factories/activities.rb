FactoryBot.define do
  factory :activity do
    initialize_with { type.present? ? type.constantize.new : Activity.new }
    association :user
    association :activitable, factory: :project

    trait :comment do
      type { "Comment" }
      content { { "text" => "This is a test comment" } }
    end

    trait :status_update do
      type { "StatusUpdate" }
      content { { "from" => "to_do", "to" => "active", "field" => "status" } }
    end
  end
end
