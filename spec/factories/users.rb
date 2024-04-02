# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    transient do
      quantity { 3 }
    end

    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }

    trait :with_activities_and_categories do
      after(:create) do |user, evaluator|
        category = create(:category, user:)
        create_list(:activity, evaluator.quantity, user:, category:)
      end
    end
  end
end
