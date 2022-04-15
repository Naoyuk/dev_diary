# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'has valid factory' do
    expect(@user).to be_valid
  end

  it 'is invalid without a name' do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with a too long name' do
    @user.name = 'a' * 50
    expect(@user).to be_valid

    @user.name = 'a' * 51
    @user.valid?
    expect(@user.errors[:name]).to include('is too long (maximum is 50 characters)')
  end

  it 'is invalid without an email' do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicated email' do
    User.create(name: 'test', email: 'user1@example.com',
                password: 'password', password_confirmation: 'password')
    duplicated_email_user = User.new(name: 'test', email: 'user1@example.com',
                                     password: 'password', password_confirmation: 'password')

    duplicated_email_user.valid?
    expect(duplicated_email_user.errors[:email]).to include('has already been taken')
  end

  it 'is valid with a valid email address' do
    valid_addresses = %w[USER@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      @user.valid?
      expect(@user.errors[:email]).not_to include('is invalid')
    end
  end

  it 'is invalid with an invalid email address' do
    invalid_addresses = %w[foo@example,com foo_at_example.com foo.bar@example.foo@bar_baz.com foo@bar+baz.com
                           foo@bar..com test]
    invalid_addresses.each do |address|
      @user.email = address
      @user.valid?
      expect(@user.errors[:email]).to include('is invalid')
    end
  end

  it 'saves email address as a lower-case' do
    mixed_case_email = 'Foo@ExAmpLe.cOm'
    @user.email = mixed_case_email
    @user.save
    expect(@user.reload.email).to eq mixed_case_email.downcase
  end

  it 'is valid with more than 6 characters password' do
    @user.password = @user.password_confirmation = 'a' * 6
    expect(@user).to be_valid
  end

  it 'is invalid with less than 6 characters password' do
    @user.password = @user.password_confirmation = 'a' * 5
    @user.valid?
    expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end

  it 'is invalid with blank password' do
    @user.password = @user.password_confirmation = ' ' * 6
    @user.valid?
    expect(@user.errors[:password]).to include("can't be blank")
  end
end
