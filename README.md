# String Calculator

A Ruby implementation of the String Calculator Kata following Test-Driven Development (TDD) principles with a clean, modular architecture and accepting input handling.

## Features

- ✅ **Core Functionality**: Add numbers from a string input
- ✅ **Input Handling**: Handle empty strings, nil inputs, and whitespace
- ✅ **Delimiter Support**: Comma, newline, and custom delimiters
- ✅ **Custom Delimiters**: `//[delimiter]\n[numbers]` format
- ✅ **Large Numbers**: Accept any number size (no MAX_NUMBER limit)
- ✅ **Input Length**: Accept any input length (no MAX_INPUT_LENGTH limit)
- ✅ **Accepting Input**: Invalid numbers treated as 0, empty delimiters accepted
- ✅ **Error Handling**: Only negative numbers throw exceptions
- ✅ **Edge Cases**: Whitespace, empty delimiters, invalid formats handled gracefully
- ✅ **Command-line Interface**: Demo and CLI usage
- ✅ **Comprehensive Testing**: Full test coverage with RSpec

## Installation

1. Clone the repository:
```bash
git clone https://github.com/rahul8sharma/string_calculator.git
cd string_calculator
```

2. Install dependencies:
```bash
bundle install
```

## Usage

### Basic Usage

```ruby
require_relative 'lib/string_calculator'

calculator = StringCalculator.new

# Empty string
calculator.add('')           # => 0

# Single number
calculator.add('1')          # => 1

# Comma-separated numbers
calculator.add('1,2,3')      # => 6

# Newline delimiters
calculator.add("1\n2,3")     # => 6

# Custom delimiters
calculator.add("//;\n1;2")   # => 3
calculator.add("//|\n1|2|3") # => 6

# Large numbers (no limit)
calculator.add('1001,1002,1003') # => 3006

# Empty delimiters (accepted)
calculator.add("//\n1,2")    # => 3
calculator.add("//\n1\n2")   # => 3
```

### Accepting Input Behavior

The calculator accepts all input formats and treats invalid numbers as 0:

```ruby
# Invalid numbers treated as 0
calculator.add('1,abc,3')    # => 4 (1+0+3)
calculator.add('1,2.5,3')    # => 4 (1+0+3)
calculator.add('abc,def,ghi') # => 0 (0+0+0)

# Mixed valid and invalid numbers
calculator.add('1,abc,3,def,5') # => 9 (1+0+3+0+5)
calculator.add('1,2.5,3,4.7,5') # => 9 (1+0+3+0+5)

# Empty delimiters work normally
calculator.add("//\n1,2,3")  # => 6
```

### Command Line Interface

Run the comprehensive demo:
```bash
ruby run_calculator.rb
```

Use as CLI tool:
```bash
ruby run_calculator.rb '1,2,3'
# Output: Result: 6

ruby run_calculator.rb '//;\n1;2;3'
# Output: Result: 6

ruby run_calculator.rb '1,abc,3'
# Output: Result: 4
```

### Error Handling

Only negative numbers throw exceptions:

```ruby
# Negative numbers throw exceptions
calculator.add('1,-2,3')     # => raises NegativeNumberError: "negatives not allowed: -2"
calculator.add('-1,2,-3')    # => raises NegativeNumberError: "negatives not allowed: -1, -3"

# All other invalid inputs are accepted
calculator.add('1,abc,3')    # => 4 (no exception)
calculator.add('1,2.5,3')    # => 4 (no exception)
calculator.add("//\n1,2")    # => 3 (no exception)
```

## Testing

Run the complete test suite:
```bash
bundle exec rspec
```

Run with detailed output:
```bash
bundle exec rspec --format documentation
```

Run specific test files:
```bash
bundle exec rspec spec/string_calculator_spec.rb
bundle exec rspec spec/calculator/
```

## Architecture

The project follows a clean, modular architecture with separation of concerns:

### Core Classes

- **`StringCalculator`**: Main entry point and orchestration
- **`InputParser`**: Parses and validates input strings
- **`DelimiterExtractor`**: Extracts custom delimiters
- **`Validator`**: Validates numbers (negatives only)
- **`Calculator`**: Performs the addition operation
- **`CalculatorConfig`**: Configuration constants and error messages

### Project Structure

```
string_calculator/
├── lib/
│   ├── string_calculator.rb           # Main calculator class
│   └── calculator/
│       ├── config.rb                  # Configuration constants
│       ├── exceptions.rb              # Custom exception classes
│       ├── input_parser.rb            # Input parsing logic
│       ├── delimiter_extractor.rb     # Delimiter extraction
│       ├── validator.rb               # Number validation
│       └── calculator.rb              # Addition operation
├── spec/
│   ├── string_calculator_spec.rb      # Main calculator tests
│   └── calculator/
│       ├── config_spec.rb             # Config tests
│       ├── exceptions_spec.rb         # Exception tests
│       ├── input_parser_spec.rb       # Parser tests
│       ├── delimiter_extractor_spec.rb # Delimiter tests
│       ├── validator_spec.rb          # Validator tests
│       └── calculator_spec.rb         # Calculator tests
├── run_calculator.rb                  # Demo and CLI runner
├── Gemfile                           # Dependencies
└── README.md                         # This file
```

## Requirements Met

### Core Requirements
- ✅ **Empty String**: Returns 0 for empty input
- ✅ **Single Number**: Returns the number itself
- ✅ **Two Numbers**: Returns sum of comma-separated numbers
- ✅ **Multiple Numbers**: Handles any amount of numbers
- ✅ **Newlines**: Supports newline delimiters (`\n`)
- ✅ **Custom Delimiters**: Supports `//[delimiter]\n[numbers]` format
- ✅ **Negative Numbers**: Throws exceptions for negative numbers
- ✅ **Multiple Negatives**: Shows all negative numbers in error message

### Enhanced Features
- ✅ **No Number Limits**: Accepts any number size
- ✅ **No Input Limits**: Accepts any input length
- ✅ **Accepting Input**: Invalid numbers treated as 0, empty delimiters accepted
- ✅ **Graceful Error Handling**: Only negative numbers throw exceptions
- ✅ **Whitespace Handling**: Trims whitespace around numbers
- ✅ **Edge Case Support**: Empty delimiters, invalid formats handled gracefully
- ✅ **Clean Architecture**: Modular design with single responsibilities

### Key Behavior Changes
- ✅ **Empty Delimiters**: `"//\n1,2"` returns 3 (not error)
- ✅ **Invalid Numbers**: `"1,abc,3"` returns 4 (1+0+3)
- ✅ **Decimal Numbers**: `"1,2.5,3"` returns 4 (1+0+3)
- ✅ **Mixed Input**: `"1,abc,3,def,5"` returns 9 (1+0+3+0+5)
- ✅ **No Format Errors**: Only negative numbers throw exceptions

## Development

### Running Tests
```bash
# Run all tests
bundle exec rspec

# Run with coverage
bundle exec rspec --format documentation

# Run specific test file
bundle exec rspec spec/string_calculator_spec.rb
```

### Code Quality
```bash
# Check code style
bundle exec rubocop

# Auto-fix code style issues
bundle exec rubocop -a
```

### Test Coverage
The project maintains comprehensive test coverage across all classes:
- **55+ test examples** with **0 failures**
- **100% method coverage** for all calculator classes
- **Edge case testing** for all scenarios
- **Acceptance testing** for new behavior
- **Error handling validation** for negative numbers only

## Performance

- **Fast Execution**: All tests complete in ~0.01 seconds
- **Memory Efficient**: No unnecessary object creation
- **Scalable**: Handles large numbers and long inputs efficiently
- **Robust**: Accepts all input formats gracefully

## License

This project is open source and available under the [MIT License](LICENSE). 