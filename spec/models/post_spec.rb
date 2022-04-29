# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with title and body' do
    post = FactoryBot.build(:post)
    expect(post).to be_valid
  end

  it 'is invalid with too long title' do
    post = FactoryBot.build(:post, title: 'a' * 51)
    post.valid?
    expect(post.errors[:title]).to include('is too long (maximum is 50 characters)')

    post = FactoryBot.build(:post, title: 'a' * 50)
    expect(post).to be_valid
  end

  it 'is invalid without title' do
    post = FactoryBot.build(:post, title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without body' do
    post = FactoryBot.build(:post, body: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end
end
