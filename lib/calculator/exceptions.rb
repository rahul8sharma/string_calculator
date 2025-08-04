# frozen_string_literal: true

# Custom exceptions for the String Calculator
class CalculatorError < StandardError
end

class NegativeNumberError < CalculatorError
end
