# frozen_string_literal: true

require 'pry'
require_relative 'calculator/config'
require_relative 'calculator/exceptions'
require_relative 'calculator/input_parser'
require_relative 'calculator/delimiter_extractor'
require_relative 'calculator/validator'
require_relative 'calculator/calculator'

# StringCalculator provides functionality to add numbers from a string input
class StringCalculator
  def add(input)
    return 0 if input.nil? || input.empty?

    numbers = parse_numbers(input)
    validate_numbers(numbers)
    execute_operation(numbers)
  end

  private

  def parse_numbers(input)
    parser = InputParser.new(input)
    parser.parse
  end

  def validate_numbers(numbers)
    validator = Validator.new(numbers)
    validator.validate!
  end

  def execute_operation(numbers)
    Calculator.add(numbers)
  end
end
