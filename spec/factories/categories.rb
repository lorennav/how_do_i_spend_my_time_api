FactoryBot.define do
  factory :category do
    name { Faker::Hobby.activity }
    user
  end
end
