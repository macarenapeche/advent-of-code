
class CrabSwarm 
  def initialize(list)
    raise ArgumentError, "Expected array of integers as argument" if !list.is_a?(Array) || list.any? { |item| !item.is_a?(Integer) }
    @list = list 
  end

  def positions_hash
    hash = Hash.new(0)
    (@list.min..@list.max).each do |i| 
      hash[i] = @list.inject(0) { |sum, value| sum + (i - value).abs }
    end
    hash
  end

  def minimum_fuel
    positions_hash.values.min
  end

  def new_positions_hash
    hash = Hash.new(0)
    (@list.min..@list.max).each do |i| 
      hash[i] = @list.inject(0) { |sum, value| sum + (((i - value).abs) * ((i - value).abs + 1) / 2) }
    end
    hash
  end

  def new_minimum_fuel
    new_positions_hash.values.min
  end
end
