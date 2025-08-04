# frozen_string_literal: true

# StringCalculator provides functionality to add numbers from a string input
class StringCalculator
  def add(input)
    return 0 if input.empty?

    if input.start_with?('//')
      delimiter_line, numbers = input.split("\n", 2)
      delimiter = delimiter_line[2..]
      numbers.split(delimiter).map(&:to_i).sum
    else
      input.split(/[,|\n]/).map(&:to_i).sum
    end
  end
end
