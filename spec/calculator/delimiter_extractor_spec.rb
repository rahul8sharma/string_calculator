# frozen_string_literal: true

require 'calculator/delimiter_extractor'

RSpec.describe DelimiterExtractor do
  describe '#extract' do
    it 'returns nil for input without custom delimiter' do
      extractor = DelimiterExtractor.new('1,2,3')
      expect(extractor.extract).to be_nil
    end

    it 'extracts semicolon delimiter' do
      extractor = DelimiterExtractor.new("//;\n1;2;3")
      expect(extractor.extract).to eq(';')
    end

    it 'extracts pipe delimiter' do
      extractor = DelimiterExtractor.new("//|\n1|2|3")
      expect(extractor.extract).to eq('|')
    end

    it 'extracts dot delimiter' do
      extractor = DelimiterExtractor.new("//.\n1.2.3")
      expect(extractor.extract).to eq('.')
    end

    it 'extracts empty delimiter' do
      extractor = DelimiterExtractor.new("//\n1,2")
      expect(extractor.extract).to eq('')
    end

    it 'extracts long delimiter' do
      extractor = DelimiterExtractor.new("//***\n1***2***3")
      expect(extractor.extract).to eq('***')
    end
  end
end
