# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Naoyuki' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :other_user, class: 'User' do
    name { 'Takehiro' }
    email { 'take@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
