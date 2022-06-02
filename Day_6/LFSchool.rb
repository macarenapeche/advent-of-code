class LFSchool
  attr_reader :stages 

  def initialize(array)
    raise ArgumentError, "Expected array as argument" if !array.is_a?(Array) || array.any? { |item| !item.between?(0,8) }
    
    @stages = Hash.new(0)
    array.each { |i| @stages[i] += 1 }
  end

  def lanternfish_count(n)
    n.times { one_more_day! }
    hash_value_sum
  end

  def hash_value_sum
    @stages.values.sum
  end

  def one_more_day!
    # @stages = @stages.inject({}) do |hash,(key,value)| 
    #   if key > 0
    #     hash[key - 1] += value 
    #   else 
    #     hash[8] = value 
    #     hash[6] += value
    #   end
    #   hash
    # end
    new_stages = Hash.new(0)
    @stages.each do |k, v|
      if k > 0
        new_stages[k - 1] += v 
      else 
        new_stages[8] = v 
        new_stages[6] += v
      end
    end

    @stages = new_stages
  end
end

