require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'should save with all required fields set' do
      @category = Category.new(name: "Exotic")
      @product = Product.new(name: "Torch Ginger", price: "14900", quantity: 4, category: @category)
      @product.save!
      expect(@product).to be_valid
    end
    
    it 'should throw an error if name is empty' do
      @category = Category.new(name: "Exotic")
      @product = Product.new(name: nil, price: "14900", quantity: 4, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should throw an error if price is empty' do
      @category = Category.new(name: "Exotic")
      @product = Product.new(name: "Torch Ginger", price: nil, quantity: 4, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should throw an error if quantity is empty' do
      @category = Category.new(name: "Exotic")
      @product = Product.new(name: "Torch Ginger", price: "14900", quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should throw an error if category is empty' do
      @category = Category.new(name: "Exotic")
      @product = Product.new(name: "Torch Ginger", price: "14900", quantity: 4, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
