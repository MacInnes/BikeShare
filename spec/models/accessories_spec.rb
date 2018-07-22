require 'rails_helper'

describe Accessories do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:image)}
  end
  describe 'relationships' do
    xit {should have_many(:order_items)}
    xit {should have_many(:orders).through(:order_items)}
  end
end
