module Sorting
  module MergeSort
    def self.sort(array)
      result = array.dup

      return result if result.size <= 1

      n = result.size
      middle = result.size / 2

      left = result[0...middle]
      right = result[middle...n]

      merge(sort(left), sort(right))
    end

    def self.merge(left, right)
      result = []
      while left.any? && right.any?
        if left.first < right.first
          result << left.shift
        else
          result << right.shift
        end
      end
      result + left + right
    end
  end
end