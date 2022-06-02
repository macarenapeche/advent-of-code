require '../test_helper.rb'
require './LFSchool.rb'

def test_lanternfish_initialize
  assert_error(ArgumentError) { LFSchool.new(6) }
  assert_error(ArgumentError) { LFSchool.new(['a'])}
end

def test_lanternfish_stages
  assert_equal({ 1 => 1 })  { LFSchool.new([1]).stages }
end


def test_hash_value_sum
  assert_equal(3) { LFSchool.new([1,2,1]).hash_value_sum }
  assert_equal(2) { LFSchool.new([1,2]).hash_value_sum }
end


def test_lanternfish_count
  initial = File.read('inputDay6.txt', chomp: true).split(",").map { |item| item.to_i }
  assert_equal(initial.count) { LFSchool.new(initial).lanternfish_count(0) }
  assert_equal(386536) { LFSchool.new(initial).lanternfish_count(80) }
end


test_lanternfish_initialize
test_lanternfish_stages
test_hash_value_sum
test_lanternfish_count
