require 'sorting/bubble_sort'
require 'sorting/insertion_sort'
require 'sorting/merge_sort'
require 'sorting/quick_sort'

shared_examples 'a sort algorithm' do
  let(:array) { 10.times.map { rand(100) } }
  it 'sorts the array' do
    expect(subject.sort(array)).to eq(array.sort)
  end
end

describe 'Bubble sort' do
  subject { Sorting::BubbleSort }
  it_behaves_like 'a sort algorithm'
end

describe 'Insertion sort' do
  subject { Sorting::InsertionSort }
  it_behaves_like 'a sort algorithm'
end

describe 'Merge sort' do
  subject { Sorting::MergeSort }
  it_behaves_like 'a sort algorithm'
end

describe 'Quick sort' do
  subject { Sorting::QuickSort }
  it_behaves_like 'a sort algorithm'
end