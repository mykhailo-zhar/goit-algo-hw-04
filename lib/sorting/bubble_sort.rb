module Sorting
  module BubbleSort
    def self.sort(array)
      result = array.dup
      n = result.size
      (n - 1).times do |i|
        (n - i - 1).times do |j|
          result[j], result[j + 1] = result[j + 1], result[j] if result[j] > result[j + 1]
        end
      end

      result
    end
  end
end
