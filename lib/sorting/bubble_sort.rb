module Sorting
  module BubbleSort
    def self.sort(array)
      result = array.dup
      n = result.size
      (n-1).times do |i|
        (n-i-1).times do |j|
          if result[j] > result[j+1]
            result[j], result[j+1] = result[j+1], result[j]
          end
        end
      end
      
      result
    end
  end
end