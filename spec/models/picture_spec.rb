# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Picture, type: :model do
  before do
    @picture = FactoryBot.build(:picture)
  end

  it 'is valid with photo' do
    expect(@picture).to be_valid
  end

  it 'is invalid without photo' do
    @picture.photo = nil
    @picture.valid?
    expect(@picture.errors[:photo]).to include("can't be blank")
  end
end
