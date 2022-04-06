FactoryBot.define do
  factory :user do
    name { "Naoyuki" }
    sequence(:email) { |n| "tester#{n}@example.com" }
  end
end
