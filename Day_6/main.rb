require './lanternfish_school.rb'
require './LFSchool.rb'

input = File.read('input.txt', chomp: true).split(',').map { |item| item.to_i }

school = LanternfishSchool.new(input)
school2 = LFSchool.new(input)
puts school.lanternfish_count(80)

puts school2.lanternfish_count(256)
