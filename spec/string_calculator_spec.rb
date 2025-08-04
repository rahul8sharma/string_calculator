# frozen_string_literal: true

require 'string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  describe '#add' do
    it 'returns 0 for an empty string' do
      expect(calculator.add('')).to eq(0)
    end

    it 'returns the number when a single number is passed' do
      expect(calculator.add('1')).to eq(1)
      expect(calculator.add('5')).to eq(5)
    end

    it 'returns the sum of two comma-separated numbers' do
      expect(calculator.add('1,2')).to eq(3)
      expect(calculator.add('5,3')).to eq(8)
    end

    it 'allows the add method to handle any amount of numbers' do
      expect(calculator.add('1,2,3')).to eq(6)
      expect(calculator.add('1,2,3,4,5')).to eq(15)
      expect(calculator.add('10,20,30,40,50')).to eq(150)
    end

    it 'handles new lines between numbers instead of commas' do
      expect(calculator.add("1\n2,3")).to eq(6)
      expect(calculator.add("1,2\n3")).to eq(6)
      expect(calculator.add("1\n2\n3")).to eq(6)
    end

    it 'supports different delimiters with //[delimiter]\\n[numbers] format' do
      expect(calculator.add("//;\n1;2")).to eq(3)
      expect(calculator.add("//|\n1|2|3")).to eq(6)
      expect(calculator.add("//.\n1.2.3.4")).to eq(10)
    end

    it 'throws an exception for negative numbers' do
      expect { calculator.add('1,-2,3') }.to raise_error('negatives not allowed: -2')
      expect { calculator.add('-1,2,-3') }.to raise_error('negatives not allowed: -1, -3')
    end

    it 'handles edge cases with empty delimiters' do
      expect(calculator.add('1,,2')).to eq(3)
      expect(calculator.add('1,2,')).to eq(3)
    end

    it 'handles whitespace in input' do
      expect(calculator.add(' 1 , 2 , 3 ')).to eq(6)
    end

    it 'handles nil input' do
      expect(calculator.add(nil)).to eq(0)
    end

    # Large number tests - accepts any number
    describe 'large number handling' do
      it 'accepts numbers larger than 1000' do
        expect(calculator.add('1,1001,2')).to eq(1004)
        expect(calculator.add('1001,1002,1003')).to eq(3006)
        expect(calculator.add('1,999,1001,2')).to eq(2003)
      end

      it 'handles very large numbers' do
        expect(calculator.add('999999,888888,777777')).to eq(2_666_664)
        expect(calculator.add('1000000,2000000,3000000')).to eq(6_000_000)
      end

      it 'handles negative large numbers' do
        expect { calculator.add('1,-1001,2') }.to raise_error(NegativeNumberError, /negatives not allowed: -1001/)
        expect do
          calculator.add('-1001,-1002')
        end.to raise_error(NegativeNumberError, /negatives not allowed: -1001, -1002/)
      end
    end

    # Error handling tests - only for negative numbers
    describe 'error handling' do
      it 'raises NegativeNumberError for negative numbers' do
        expect { calculator.add('1,-2,3') }.to raise_error(NegativeNumberError, /negatives not allowed: -2/)
        expect { calculator.add('-1,-2,-3') }.to raise_error(NegativeNumberError, /negatives not allowed: -1, -2, -3/)
      end
    end

    # Edge cases and robustness
    describe 'edge cases' do
      it 'handles zero values correctly' do
        expect(calculator.add('0,1,2')).to eq(3)
        expect(calculator.add('1,0,2')).to eq(3)
        expect(calculator.add('0,0,0')).to eq(0)
      end

      it 'handles single large numbers' do
        expect(calculator.add('1001')).to eq(1001)
        expect(calculator.add('1000')).to eq(1000)
        expect(calculator.add('999')).to eq(999)
      end

      it 'handles mixed operations with large numbers' do
        expect(calculator.add("//;\n1;1001;3")).to eq(1005)
        expect(calculator.add("//|\n1|1001|3")).to eq(1005)
      end

      it 'handles invalid number formats by treating them as 0' do
        expect(calculator.add('1,abc,3')).to eq(4)  # 1+0+3
        expect(calculator.add('1,2.5,3')).to eq(4)  # 1+0+3
        expect(calculator.add('abc,def,ghi')).to eq(0)  # 0+0+0
        expect(calculator.add('1,2.5,3.7,4')).to eq(5)  # 1+0+0+4
        expect(calculator.add('1,abc,def,4')).to eq(5)  # 1+0+0+4
      end

      it 'handles empty delimiters in custom format' do
        expect(calculator.add("//\n1,2")).to eq(3) # Should work with empty delimiter
        expect(calculator.add("//\n1\n2")).to eq(3) # Should work with empty delimiter
        expect(calculator.add("//\n1,2,3")).to eq(6) # Should work with empty delimiter
      end

      it 'handles various invalid input formats gracefully' do
        expect(calculator.add('1,2.5,3')).to eq(4)  # Decimal treated as 0
        expect(calculator.add('1,abc,3')).to eq(4)  # Text treated as 0
        expect(calculator.add('1,2.5,abc,4')).to eq(5)  # Mixed invalid formats
        expect(calculator.add('abc,def,ghi')).to eq(0)  # All invalid
        expect(calculator.add('1,2.5,3.7,abc,5')).to eq(6) # Multiple invalid formats
      end

      it 'handles special characters in numbers' do
        expect(calculator.add('1,2.5,3')).to eq(4) # Decimal point
        expect(calculator.add('1,2,5,3')).to eq(11) # Valid numbers
        expect(calculator.add('1,2.5,3.7,4')).to eq(5) # Multiple decimals
      end

      it 'handles mixed valid and invalid numbers' do
        expect(calculator.add('1,abc,3,def,5')).to eq(9) # 1+0+3+0+5
        expect(calculator.add('abc,1,def,2,ghi')).to eq(3) # 0+1+0+2+0
        expect(calculator.add('1,2.5,3,4.7,5')).to eq(9) # 1+0+3+0+5
      end
    end

    # Input length handling - accepts any length
    describe 'input length handling' do
      it 'handles long input strings' do
        long_input = "#{'1,' * 1000}2" # 1001 numbers
        expect { calculator.add(long_input) }.not_to raise_error
        expect(calculator.add(long_input)).to eq(1002) # 1000*1 + 2
      end

      it 'handles very long delimiter strings' do
        long_delimiter = "//#{'a' * 100}\n1#{'a' * 100}2#{'a' * 100}3"
        expect { calculator.add(long_delimiter) }.not_to raise_error
        expect(calculator.add(long_delimiter)).to eq(6)
      end

      it 'handles extremely large numbers in operations' do
        expect(calculator.add("//;\n1000000;2000000;3000000")).to eq(6_000_000)
        expect(calculator.add("//|\n1000001|1000002|1000003")).to eq(3_000_006)
      end
    end

    # Complex scenarios
    describe 'complex scenarios' do
      it 'handles multiple operations with different delimiters' do
        expect(calculator.add("//;\n1;2;3")).to eq(6)
        expect(calculator.add("//|\n1|2|3")).to eq(6)
        expect(calculator.add("//.\n1.2.3")).to eq(6)
      end

      it 'handles empty strings between delimiters' do
        expect(calculator.add("//;\n1;;3")).to eq(4)
        expect(calculator.add("//|\n1||3")).to eq(4)
      end

      it 'handles whitespace around delimiters' do
        expect(calculator.add("//;\n1 ; 2 ; 3")).to eq(6)
        expect(calculator.add("//|\n1 | 2 | 3")).to eq(6)
      end

      it 'handles complex mixed scenarios' do
        expect(calculator.add("//;\n1;abc;3;def;5")).to eq(9)  # 1+0+3+0+5
        expect(calculator.add("//|\n1|2.5|3|4.7|5")).to eq(9)  # 1+0+3+0+5
        expect(calculator.add("//.\n1.abc.3.def.5")).to eq(9)  # 1+0+3+0+5
      end
    end

    # Acceptance tests for specific requirements
    describe 'acceptance tests' do
      it 'accepts all string formats and sums numbers' do
        expect(calculator.add("//\n1,2")).to eq(3) # Empty delimiter with comma
        expect(calculator.add("//\n1\n2")).to eq(3) # Empty delimiter with newline
        expect(calculator.add('1,abc,3')).to eq(4)  # Invalid number treated as 0
        expect(calculator.add('1,2.5,3')).to eq(4)  # Decimal treated as 0
        expect(calculator.add('abc,def,ghi')).to eq(0) # All invalid treated as 0
      end

      it 'handles edge cases gracefully without errors' do
        expect { calculator.add("//\n1,2") }.not_to raise_error
        expect { calculator.add('1,abc,3') }.not_to raise_error
        expect { calculator.add('1,2.5,3') }.not_to raise_error
        expect { calculator.add('abc,def,ghi') }.not_to raise_error
      end

      it 'only raises exceptions for negative numbers' do
        expect { calculator.add('1,-2,3') }.to raise_error(NegativeNumberError)
        expect { calculator.add('-1,2,-3') }.to raise_error(NegativeNumberError)
        expect { calculator.add('1,abc,3') }.not_to raise_error
        expect { calculator.add('1,2.5,3') }.not_to raise_error
        expect { calculator.add("//\n1,2") }.not_to raise_error
      end
    end
  end
end
