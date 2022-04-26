FactoryBot.define do
  factory :post do
    title { "new title" }
    body { "new post content" }
    published { false }
    association :user
  end

  factory :published_post, class: Post do
    title { "published post" }
    body { "new post content published" }
    published { true }
    association :user
  end
end
