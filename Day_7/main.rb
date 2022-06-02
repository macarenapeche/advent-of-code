require './crabswarm.rb'

input = File.read('input.txt', chomp: true).split(",").map { |item| item.to_i }

puts CrabSwarm.new(input).minimum_fuel
puts CrabSwarm.new(input).new_minimum_fuel
