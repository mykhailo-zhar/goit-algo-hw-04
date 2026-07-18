module Sorting
  module InsertionSort
    def self.sort(array)
      result = array.dup
      return result if result.size <= 1
      (1...result.size).each do |i|
        key = result[i]
        j = i - 1
        while j >= 0 && result[j] > key
          result[j+1] = result[j]
          j -= 1
        end
        result[j+1] = key
      end
      result
    end
  end
end