FactoryBot.define do
  factory :activity do
    name { Faker::Marketing.buzzwords }
    date { Date.today }
    start_time { DateTime.now }
    finish_time { start_time { DateTime.now } + 1.hour }
    category
    user
  end
end
