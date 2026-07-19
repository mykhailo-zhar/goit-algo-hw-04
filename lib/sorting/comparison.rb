require 'benchmark'

require_relative 'bubble_sort'
require_relative 'insertion_sort'
require_relative 'merge_sort'
require_relative 'quick_sort'

module Sorting
  # This module is used to compare the sorting algorithms
  module Comparison
    def self.generate_random_array(size = 100, max = 100)
      Array.new(size) { rand(max) }
    end

    def self.generate_reverse_sorted_array(size = 100)
      Array.new(size) { |i| size - i }
    end

    def self.generate_sorted_array(size = 100)
      Array.new(size) { |i| i }
    end

    def self.generate_almost_sorted_array(size = 100, chance_of_swap = 0.5, max_swap_distance = 5)
      array = Array.new(size) { |i| i }
      (0...size).each do |i|
        next unless rand < chance_of_swap

        min_swap_distance = [i - max_swap_distance, 0].max
        max_swap_distance = [size - 1, i + max_swap_distance].min

        j = rand(min_swap_distance...max_swap_distance)
        array[i], array[j] = array[j], array[i]
      end

      array
    end

    def self.compare(array)
      Benchmark.bm do |x|
        x.report('Bubble sort') { Sorting::BubbleSort.sort(array) }
        x.report('Insertion sort') { Sorting::InsertionSort.sort(array) }
        x.report('Merge sort') { Sorting::MergeSort.sort(array) }
        x.report('Quick sort') { Sorting::QuickSort.sort(array) }
      end
    end
  end
end

return if __FILE__ != $0

SEPARATOR = "--------------------------------\n\n"
SECTION_SEPARATOR = "\n" * 4

(1..4).each do |i|
  puts "Comparing random array size: #{10**i} elements"
  array = Sorting::Comparison.generate_random_array(10**i)
  Sorting::Comparison.compare(array)
  puts SEPARATOR
end

puts SECTION_SEPARATOR

(1..4).each do |i|
  puts "Comparing reverse sorted array size: #{10**i} elements"
  array = Sorting::Comparison.generate_reverse_sorted_array(10**i)
  Sorting::Comparison.compare(array)
  puts SEPARATOR
end

puts SECTION_SEPARATOR

(1..4).each do |i|
  puts "Comparing almost sorted array size: #{10**i} elements"
  array = Sorting::Comparison.generate_almost_sorted_array(10**i)
  Sorting::Comparison.compare(array)
  puts SEPARATOR
end

puts SECTION_SEPARATOR

(1..4).each do |i|
  puts "Comparing sorted array size: #{10**i} elements"
  array = Sorting::Comparison.generate_sorted_array(10**i)
  Sorting::Comparison.compare(array)
  puts SEPARATOR
end
