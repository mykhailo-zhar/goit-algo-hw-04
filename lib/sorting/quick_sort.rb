module Sorting
  module QuickSort
    def self.sort(array)
      result = array.dup
      return result if result.size <= 1
      pivot = result[result.size / 2]
      left = result.select { |x| x < pivot }
      middle = result.select { |x| x == pivot }
      right = result.select { |x| x > pivot }
      sort(left) + middle + sort(right)
    end
  end
end