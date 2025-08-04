# frozen_string_literal: true

require_relative 'exceptions'
require_relative 'config'
require_relative 'delimiter_extractor'

# InputParser handles parsing calculator input strings
class InputParser
  def initialize(input)
    @input = input
  end

  def parse
    return [] if @input.empty?

    delimiter, numbers_string = extract_delimiter_and_numbers
    parse_number_strings(numbers_string, delimiter)
  end

  private

  def extract_delimiter_and_numbers
    if @input.start_with?('//')
      _, numbers_string = @input.split("\n", 2)
      numbers_string ||= ''
      delimiter_extractor = DelimiterExtractor.new(@input)
      delimiter = delimiter_extractor.extract
      return [CalculatorConfig::DEFAULT_DELIMITER, numbers_string] if delimiter.empty?

      [delimiter, numbers_string]

    else
      [CalculatorConfig::DEFAULT_DELIMITER, @input]
    end
  end

  def parse_number_strings(numbers_string, delimiter)
    number_strings = numbers_string.split(delimiter)
    number_strings.reject(&:empty?).map { |str| parse_single_number(str.strip) }
  end

  def parse_single_number(str)
    Integer(str)
  rescue ArgumentError
    0 # Return 0 for any invalid number format
  end
end
