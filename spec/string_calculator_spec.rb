require 'string_calculator'

RSpec.describe StringCalculator do
  describe ".add" do
    it "returns 0 for an empty string" do
      expect(StringCalculator.add("")).to eq(0)
    end

    it "returns the number for a single number" do
      expect(StringCalculator.add("1")).to eq(1)
    end

    it "returns the sum of two numbers separated by a comma" do
      expect(StringCalculator.add("1,5")).to eq(6)
    end

    it "returns the sum of multiple numbers separated by commas or newlines" do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it "handles custom delimiters" do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it "throws an exception when there are negative numbers" do
      expect { StringCalculator.add("1,-2,3") }.to raise_error("Negative numbers not allowed: -2")
    end

    it "throws an exception with multiple negative numbers" do
      expect { StringCalculator.add("1,-2,-3") }.to raise_error("Negative numbers not allowed: -2, -3")
    end

    it "correctly handles multiple delimiters" do
      expect(StringCalculator.add("//[;][#]\n1;2#3")).to eq(6)
    end

    it "throws an exception when multiple negative numbers are present with custom delimiters" do
      expect { StringCalculator.add("//;\n1;-2;3;-4") }.to raise_error("Negative numbers not allowed: -2, -4")
    end

    it "handles numbers that are zero" do
      expect(StringCalculator.add("0")).to eq(0)
    end

    it "ignores zero values in the sum" do
      expect(StringCalculator.add("0,1,0,2")).to eq(3)
    end

    it "handles empty delimiters gracefully" do
      expect { StringCalculator.add("//\n1,2") }.to raise_error("Delimiter cannot be empty")
    end

    it "works with multi-line input with mixed delimiters" do
      expect(StringCalculator.add("//;\n1;2\n3")).to eq(6)
    end
  end
end
