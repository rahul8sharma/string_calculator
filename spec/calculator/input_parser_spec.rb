# frozen_string_literal: true

require 'calculator/input_parser'

RSpec.describe InputParser do
  describe '#parse' do
    it 'returns empty array for empty string' do
      parser = InputParser.new('')
      expect(parser.parse).to eq([])
    end

    it 'parses comma-separated numbers' do
      parser = InputParser.new('1,2,3')
      expect(parser.parse).to eq([1, 2, 3])
    end

    it 'parses newline-separated numbers' do
      parser = InputParser.new("1\n2\n3")
      expect(parser.parse).to eq([1, 2, 3])
    end

    it 'parses mixed delimiters' do
      parser = InputParser.new("1\n2,3")
      expect(parser.parse).to eq([1, 2, 3])
    end

    it 'parses custom delimiter' do
      parser = InputParser.new("//;\n1;2;3")
      expect(parser.parse).to eq([1, 2, 3])
    end

    it 'parses multiplication delimiter' do
      parser = InputParser.new("//*\n2*3*4")
      expect(parser.parse).to eq([2, 3, 4])
    end
  end
end
