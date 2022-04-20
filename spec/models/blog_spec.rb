require 'rails_helper'

RSpec.describe Blog, type: :model do
  it 'is valid with title and body' do
    blog = Blog.new(title: 'new title', body: 'new blog content')
    expect(blog).to be_valid
  end

  it 'is invalid with too long title' do
    blog = Blog.new(title: 'a' * 51, body: 'new blog content')
    blog.valid?
    expect(blog.errors[:title]).to include('is too long (maximum is 50 characters)')

    blog = Blog.new(title: 'a' * 50, body: 'new blog content')
    expect(blog).to be_valid
  end

  it 'is invalid without title' do
    blog = Blog.new(title: nil, body: 'new blog content')
    blog.valid?
    expect(blog.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without body' do
    blog = Blog.new(title: 'new title', body: nil)
    blog.valid?
    expect(blog.errors[:body]).to include("can't be blank")
  end
end
