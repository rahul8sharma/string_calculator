# frozen_string_literal: true

require_relative 'exceptions'
require_relative 'config'

# Validator handles validation of calculator input
class Validator
  def initialize(numbers)
    @numbers = numbers
  end

  def validate!
    validate_negatives
    true
  end

  private

  def validate_negatives
    negatives = @numbers.select(&:negative?)
    return if negatives.empty?

    raise NegativeNumberError, format(
      CalculatorConfig::ERROR_MESSAGES[:negative_numbers],
      negatives.join(', ')
    )
  end
end
