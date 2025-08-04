# frozen_string_literal: true

#!/usr/bin/env ruby

require_relative 'lib/string_calculator'

class CalculatorExamples
  def self.run
    calculator = StringCalculator.new

    puts 'String Calculator Demo'
    puts '====================='
    puts

    examples = [
      { input: '', description: 'Empty string', expected: '0' },
      { input: '1,2,3', description: 'Comma-separated numbers', expected: '6' },
      { input: "1\n2,3", description: 'Newline-delimited numbers', expected: '6' },
      { input: "//;\n1;2", description: 'Custom delimiter', expected: '3' }
    ]

    examples.each_with_index do |example, index|
      puts "Example #{index + 1}: #{example[:description]}"
      puts "Input: \"#{example[:input].gsub("\n", "\\n")}\""
      result = calculator.add(example[:input])
      puts "Result: #{result}"
      puts
    end

    puts 'Example 5: Error case (negative numbers)'
    puts 'Input: "1,-2,3"'
    begin
      result = calculator.add('1,-2,3')
      puts "Result: #{result}"
    rescue => e
      puts "Error: #{e.message}"
    end
    puts

    puts 'Demo completed!'
  end

  def self.cli_mode
    calculator = StringCalculator.new
    input = ARGV.join(' ')

    if input.empty?
      puts "Usage: ruby run_calculator.rb '1,2,3'"
      puts "Example: ruby run_calculator.rb '1,2,3'"
      return
    end

    begin
      result = calculator.add(input)
      puts "Result: #{result}"
    rescue => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
end

if ARGV.any?
  CalculatorExamples.cli_mode
else
  CalculatorExamples.run
end
