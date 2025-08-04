# frozen_string_literal: true

require_relative 'exceptions'
require_relative 'config'

# DelimiterExtractor handles extracting delimiters from input
class DelimiterExtractor
  attr_reader :delimiter

  def initialize(input)
    @input = input
    @delimiter = nil
  end

  def extract
    return nil unless @input.start_with?('//')

    delimiter_line = @input.split("\n").first
    delimiter = delimiter_line[2..]
    @delimiter = delimiter
  end
end
