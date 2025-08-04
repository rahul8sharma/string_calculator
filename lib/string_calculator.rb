# frozen_string_literal: true

# StringCalculator provides functionality to add numbers from a string input
class StringCalculator
  def add(input)
    return 0 if input.empty?

    numbers = parse_numbers(input)
    validate_negatives(numbers)
    numbers.sum
  end

  private

  def parse_numbers(input)
    if input.start_with?('//')
      delimiter_line, numbers_string = input.split("\n", 2)
      delimiter = delimiter_line[2..]
      numbers_string.split(delimiter).map(&:to_i)
    else
      input.split(/[,|\n]/).map(&:to_i)
    end
  end

  def validate_negatives(numbers)
    negatives = numbers.select(&:negative?)
    return if negatives.empty?

    raise "negatives not allowed: #{negatives.join(', ')}"
  end
end
