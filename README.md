# String Calculator

A Ruby implementation of the String Calculator Kata following Test-Driven Development (TDD) principles.

## Features

- ✅ Add numbers from a string input
- ✅ Handle empty strings and nil inputs
- ✅ Support comma and newline delimiters
- ✅ Custom delimiter support with `//[delimiter]\n[numbers]` format
- ✅ Negative number validation with descriptive error messages
- ✅ Edge case handling (whitespace, empty delimiters)
- ✅ Command-line interface
- ✅ Comprehensive test suite

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
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
```

### Command Line Interface

Run the demo:
```bash
ruby run_calculator.rb
```

Use as CLI tool:
```bash
ruby run_calculator.rb '1,2,3'
# Output: Result: 6
```

### Error Handling

```ruby
# Negative numbers throw exceptions
calculator.add('1,-2,3')     # => raises "negatives not allowed: -2"
calculator.add('-1,2,-3')    # => raises "negatives not allowed: -1, -3"
```

## Testing

Run the test suite:
```bash
bundle exec rspec
```

Run with coverage:
```bash
bundle exec rspec --format documentation
```

## TDD Progression

This project follows the TDD Red-Green-Refactor cycle:

1. **Empty String**: Returns 0 for empty input
2. **Single Number**: Returns the number itself
3. **Two Numbers**: Returns sum of comma-separated numbers
4. **Multiple Numbers**: Handles any amount of numbers
5. **Newlines**: Supports newline delimiters
6. **Custom Delimiters**: Supports `//[delimiter]\n[numbers]` format
7. **Negative Numbers**: Throws exceptions for negative numbers

## Project Structure

```
string_calculator/
├── lib/
│   └── string_calculator.rb    # Main calculator implementation
├── spec/
│   └── string_calculator_spec.rb # Test suite
├── run_calculator.rb           # Demo and CLI runner
├── Gemfile                     # Dependencies
└── README.md                   # This file
```

## Requirements Met

- ✅ Start with empty string test case
- ✅ Handle one and two numbers
- ✅ Allow any amount of numbers
- ✅ Support newlines between numbers
- ✅ Support custom delimiters with `//[delimiter]\n[numbers]` format
- ✅ Throw exception for negative numbers
- ✅ Show all negative numbers in exception message
- ✅ Follow TDD principles with frequent commits

## Development

### Running Tests
```bash
bundle exec rspec
```

### Code Style
```bash
bundle exec rubocop
```

### Auto-fix Code Style
```bash
bundle exec rubocop -a
```

## License

This project is open source and available under the [MIT License](LICENSE). 