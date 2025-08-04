# frozen_string_literal: true

# Configuration constants for the String Calculator
module CalculatorConfig
  # Default delimiter pattern
  DEFAULT_DELIMITER = /,|\n/

  # Error messages
  ERROR_MESSAGES = {
    invalid_input: 'Input must be a string',
    negative_numbers: 'negatives not allowed: %s'
  }.freeze
end
