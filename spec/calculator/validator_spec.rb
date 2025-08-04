# frozen_string_literal: true

require 'calculator/validator'
require 'calculator/exceptions'

RSpec.describe Validator do
  describe '#validate!' do
    it 'passes validation for positive numbers' do
      validator = Validator.new([1, 2, 3])
      expect { validator.validate! }.not_to raise_error
    end

    it 'passes validation for empty array' do
      validator = Validator.new([])
      expect { validator.validate! }.not_to raise_error
    end

    it 'raises NegativeNumberError for negative numbers' do
      validator = Validator.new([1, -2, 3])
      expect { validator.validate! }.to raise_error(NegativeNumberError, 'negatives not allowed: -2')
    end

    it 'raises NegativeNumberError for multiple negative numbers' do
      validator = Validator.new([1, -2, 3, -4])
      expect { validator.validate! }.to raise_error(NegativeNumberError, 'negatives not allowed: -2, -4')
    end

    it 'raises NegativeNumberError for all negative numbers' do
      validator = Validator.new([-1, -2, -3])
      expect { validator.validate! }.to raise_error(NegativeNumberError, 'negatives not allowed: -1, -2, -3')
    end
  end
end
