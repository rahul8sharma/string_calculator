# frozen_string_literal: true

# !/usr/bin/env ruby

require_relative 'lib/string_calculator'

# CalculatorExamples provides demo functionality and CLI interface for StringCalculator
# rubocop:disable Metrics/ClassLength
class CalculatorExamples
  def self.run
    calculator = StringCalculator.new

    puts 'String Calculator Demo'
    puts '====================='
    puts

    run_basic_examples(calculator)
    run_large_number_examples(calculator)
    run_edge_case_examples(calculator)
    run_error_examples(calculator)
    run_complex_examples(calculator)

    puts 'Demo completed!'
  end

  def self.cli_mode
    calculator = StringCalculator.new
    input = ARGV.join(' ')

    if input.empty?
      show_usage
      return
    end

    process_cli_input(calculator, input)
  end

  def self.run_basic_examples(calculator)
    puts '=== Basic Examples ==='
    examples = [
      { input: '', description: 'Empty string', expected: '0' },
      { input: '1', description: 'Single number', expected: '1' },
      { input: '1,2', description: 'Two comma-separated numbers', expected: '3' },
      { input: '1,2,3,4,5', description: 'Multiple comma-separated numbers', expected: '15' },
      { input: "1\n2,3", description: 'Newline-delimited numbers', expected: '6' },
      { input: "1,2\n3,4", description: 'Mixed comma and newline', expected: '10' },
      { input: "//;\n1;2", description: 'Custom delimiter (semicolon)', expected: '3' },
      { input: "//|\n1|2|3", description: 'Custom delimiter (pipe)', expected: '6' }
    ]

    display_examples(calculator, examples, 'Example')
  end

  def self.run_large_number_examples(calculator)
    puts '=== Large Number Examples ==='
    examples = [
      { input: '1001,1002,1003', description: 'Numbers larger than 1000 (now accepted)', expected: '3006' },
      { input: '999999,888888,777777', description: 'Very large numbers', expected: '2666664' },
      { input: "//;\n1000;2000;3000", description: 'Large numbers with custom delimiter', expected: '6000' }
    ]

    display_examples(calculator, examples, 'Large Number')
  end

  def self.run_edge_case_examples(calculator)
    puts '=== Edge Cases ==='
    examples = [
      { input: '0,1,2', description: 'Zero values', expected: '3' },
      { input: '1,0,2', description: 'Zero in middle', expected: '3' },
      { input: '0,0,0', description: 'All zeros', expected: '0' },
      { input: '1,,2', description: 'Empty string between delimiters', expected: '3' },
      { input: '1,2,', description: 'Empty string at end', expected: '3' },
      { input: ' 1 , 2 , 3 ', description: 'Whitespace around numbers', expected: '6' },
      { input: "//;\n1 ; 2 ; 3", description: 'Whitespace around custom delimiter', expected: '6' },
      { input: '1,abc,3', description: 'Invalid number format (treated as 0)', expected: '4' },
      { input: '1,2.5,3', description: 'Decimal number (treated as 0)', expected: '4' },
      { input: "//\n1,2", description: 'Empty delimiter (works normally)', expected: '3' },
      { input: "//\n1\n2", description: 'Empty delimiter with newlines', expected: '3' }
    ]

    display_examples(calculator, examples, 'Edge Case')
  end

  def self.run_error_examples(calculator)
    puts '=== Error Handling Examples ==='
    error_examples = [
      { input: '1,-2,3', description: 'Single negative number', expected_error: 'negatives not allowed: -2' },
      { input: '-1,2,-3', description: 'Multiple negative numbers', expected_error: 'negatives not allowed: -1, -3' },
      { input: '-1001,-1002', description: 'Large negative numbers',
        expected_error: 'negatives not allowed: -1001, -1002' }
    ]

    display_error_examples(calculator, error_examples, 'Error Example')
  end

  def self.run_complex_examples(calculator)
    puts '=== Complex Scenarios ==='
    examples = [
      { input: "//;\n10;20;30;40;50", description: 'Large numbers with custom delimiter', expected: '150' },
      { input: "//|\n100|200|300", description: 'Large numbers with pipe delimiter', expected: '600' },
      { input: "//.\n1.2.3.4.5", description: 'Dot delimiter with multiple numbers', expected: '15' },
      { input: "//-\n10-20-30", description: 'Hyphen delimiter', expected: '60' }
    ]

    display_examples(calculator, examples, 'Complex Example')
  end

  def self.display_examples(calculator, examples, prefix)
    examples.each_with_index do |example, index|
      puts "#{prefix} #{index + 1}: #{example[:description]}"
      puts "Input: \"#{example[:input].gsub("\n", '\\n')}\""
      result = calculator.add(example[:input])
      puts "Result: #{result}"
      puts
    end
  end

  def self.display_error_examples(calculator, examples, prefix)
    examples.each_with_index do |example, index|
      puts "#{prefix} #{index + 1}: #{example[:description]}"
      puts "Input: \"#{example[:input].gsub("\n", '\\n')}\""
      begin
        result = calculator.add(example[:input])
        puts "Result: #{result}"
      rescue StandardError => e
        puts "Error: #{e.message}"
      end
      puts
    end
  end

  def self.show_usage
    puts "Usage: ruby run_calculator.rb '1,2,3'"
    puts "Example: ruby run_calculator.rb '1,2,3'"
    puts "Example: ruby run_calculator.rb '//;\n1;2;3'"
  end

  def self.process_cli_input(calculator, input)
    result = calculator.add(input)
    puts "Result: #{result}"
  rescue StandardError => e
    puts "Error: #{e.message}"
    exit 1
  end
end
# rubocop:enable Metrics/ClassLength

if ARGV.any?
  CalculatorExamples.cli_mode
else
  CalculatorExamples.run
end
