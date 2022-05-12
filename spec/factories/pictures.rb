# frozen_string_literal: true

FactoryBot.define do
  factory :picture do
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root,
                                                   'spec/fixtures/test.jpeg'),
                                                   'image/jpeg') }
  end
end
