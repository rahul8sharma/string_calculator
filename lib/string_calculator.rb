class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    # Check if custom delimiter is used
    if numbers.start_with?("//")
      # Extract the delimiters
      delimiter_part = numbers[2..numbers.index("\n") - 1]
      numbers = numbers[numbers.index("\n") + 1..-1]

      # Handle empty delimiter
      raise "Delimiter cannot be empty" if delimiter_part.empty?

      # If there are multiple delimiters (enclosed in square brackets), extract them
      delimiters = if delimiter_part.include?('][')
                    delimiter_part.scan(/\[([^\]]+)\]/).flatten
                  else
                    [delimiter_part]
                  end
    else
      delimiters = [","]  # Default delimiter (comma)
    end

    # Replace each delimiter with commas
    delimiters.each do |delim|
      numbers = numbers.gsub(delim, ",")
    end

    # Replace newlines with commas as well
    numbers = numbers.gsub("\n", ",")

    # Check for negative numbers and raise an exception
    negatives = numbers.split(",").select { |n| n.to_i < 0 }.map(&:to_i)
    if negatives.any?
      raise "Negative numbers not allowed: #{negatives.join(', ')}"
    end

    # Sum the numbers
    numbers.split(",").map(&:to_i).sum
  end
end
