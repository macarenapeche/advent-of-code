# The code should be able to:
# 1. Read a file of integers separated by commas
# 2. Convert this list to an array 

# 3. The program takes the array (initial status) and a integer (days remaining) as input
# 4. Return an integer




# Create a class for each lanternfish. We want: 
# To initialize lanterfish which are either a new one (with a status 8) or an exiting one with a given positive integer status
# To be able to check the status of a lanternfish (do we really?)
# To be able to modify the status of a lanternfish when a day pass => tick method

# To accomplish that, first I created the set of tests below and then add each piece to the class until the tests passed

class Lanternfish
  attr_reader :status

  def initialize(status = 8)
    # REVIEW: This approach is called a `Guard clause`
    raise ArgumentError, "Expected a non negative integer as argument" unless status.is_a?(Integer) && status >= 0
  
    @status = status
  end

  def tick! # REVIEW: Better call it #tick!
    @status = status > 0 ? status - 1 : 6
    # if @status > 0
    #   @status -= 1
    # else 
    #   @status = 6
    # end
    self
  end

  def ==(other)
    other.is_a?(self.class) && @status == other.status
  end

end




# Create a class for a school of lanternfish. We want: 
# To create a new school either empty (empty array) or a given one (array with integer entries)
# To be able to add new lanternships to an existing school => add method
# To tick every fish in the school => tick method
# To count the number of lanternships in the school => count method (already exists)

# To accomplish that, first I created the set of tests in 'tests_lanternfish.rb' and then add each piece to the class until the tests passed.

class LanternfishSchool

  attr_reader :list

  def initialize(list = [])
    # REVIEW: Guard clause would do better (edited, review left)
    raise ArgumentError, "Expected an array of lanternfishes as argument" unless list.is_a?(Array) && list.all? { |n| n.is_a?(Integer) }
    
    # This works, but not widely used
    # @list = list.map(&Lanternfish.method(:new))
    @list = list.map { |n| Lanternfish.new(n) }

  end

  def ==(other)
    other.is_a?(self.class) && @list == other.list
  end

  def add(fish)
    @list = @list.push(fish)
    self
  end

  def tick! # REVIEW: Better call it #tick!
    new_fishes = 0
    @list.each { |fish| new_fishes += 1 if fish.status == 0 } # REVIEW: `Array#inject` / `Array#reduce` would do here!

    # REVIEW: Take a look at it, you'll meet that from time to time in real code
    # @list.map! { |fish| fish.tick }
    @list.map!(&:tick!)

    new_fishes.times { add(Lanternfish.new) }

    self
  end

  def after_some_days!(n)
    # REVIEW: Guard clause would do (edited, review left)
    raise ArgumentError, "Expected positive integer as argument" unless n.is_a?(Integer) && n > 0
    
    n.times { tick! }
    self
  end

  def lanternfish_count(n)
    after_some_days!(n).list.count
  end

end
