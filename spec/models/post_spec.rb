require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with title and body' do
    post = Post.new(title: 'new title', body: 'new post content')
    expect(post).to be_valid
  end

  it 'is invalid with too long title' do
    post = Post.new(title: 'a' * 51, body: 'new post content')
    post.valid?
    expect(post.errors[:title]).to include('is too long (maximum is 50 characters)')

    post = Post.new(title: 'a' * 50, body: 'new post content')
    expect(post).to be_valid
  end

  it 'is invalid without title' do
    post = Post.new(title: nil, body: 'new post content')
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without body' do
    post = Post.new(title: 'new title', body: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end
end
