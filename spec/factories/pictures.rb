# frozen_string_literal: true

FactoryBot.define do
  factory :picture do
    sequence(:picture) { |n| "test#{n}.png" }
  end
end
