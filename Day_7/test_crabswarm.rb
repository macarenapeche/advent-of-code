require '../test_helper.rb'
require './crabswarm.rb'

def test_crabswarm_initialize
  assert_error(ArgumentError) { CrabSwarm.new(['a']) }
  assert_error(ArgumentError) { CrabSwarm.new(2) }
end

def test_crabswarm_positions_hash
  assert_equal({1 => 0}) { CrabSwarm.new([1]).positions_hash }
  assert_equal({1 => 7, 2 => 6, 3 => 5, 4 => 4, 5 => 5}) { CrabSwarm.new([1, 4, 5]).positions_hash }
end


def test_crabswarm_minimum_fuel
  assert_equal(0) { CrabSwarm.new([1]).minimum_fuel }
  assert_equal(37) { CrabSwarm.new([16,1,2,0,4,2,7,1,2,14]).minimum_fuel }
end


def test_crabswarm_new_positions_hash
  assert_equal({1 => 16, 2 => 10, 3 => 7, 4 => 7, 5 => 11}) { CrabSwarm.new([1, 4, 5]).new_positions_hash }
end

def test_crabswarm_new_minimum_fuel 
  assert_equal(168) { CrabSwarm.new([16,1,2,0,4,2,7,1,2,14]).new_minimum_fuel }
end 

test_crabswarm_initialize
test_crabswarm_positions_hash
test_crabswarm_minimum_fuel 

test_crabswarm_new_positions_hash
test_crabswarm_new_minimum_fuel
