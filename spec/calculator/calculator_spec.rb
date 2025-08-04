# frozen_string_literal: true

require 'calculator/calculator'

RSpec.describe Calculator do
  describe '.add' do
    it 'sums all numbers' do
      result = Calculator.add([1, 2, 3])
      expect(result).to eq(6)
    end

    it 'returns 0 for empty array' do
      result = Calculator.add([])
      expect(result).to eq(0)
    end

    it 'returns the number for single element' do
      result = Calculator.add([5])
      expect(result).to eq(5)
    end

    it 'handles large numbers' do
      result = Calculator.add([1000, 2000, 3000])
      expect(result).to eq(6000)
    end

    it 'handles zero values' do
      result = Calculator.add([0, 1, 2])
      expect(result).to eq(3)
    end
  end
end
