require '../test_helper.rb'

class SubmarineDive 
  attr_reader :list

  def initialize(list)
    raise ArgumentError, "Expected array of strings of the form `<forward/down/up> <positive integer>`" unless list.is_a?(Array) && list.all? { |item| item.match(/^(forward|down|up)\s\d+$/) }
    @list = list.map { |item| item.split(' ')}.map { |item| [item[0], item[1].to_i] }
    
  end

  def horizontal_position
    horizontal_position = 0
    @list.each { |item| horizontal_position = item[0] == 'forward' ? horizontal_position + item[1] : horizontal_position }
    horizontal_position
  end

  def depth
    depth = 0
    @list.each do |item|
      case item[0]
      when 'down' then depth += item[1]
      when 'up' then depth -= item[1]
      end
    end 
    depth
  end

  def product_position_depth
    horizontal_position * depth
  end

end


def test_initialize
  assert_error(ArgumentError) { SubmarineDive.new(2) }
  assert_error(ArgumentError) { SubmarineDive.new(['up submarine'])}

  assert_equal([['forward', 5], ['down', 5], ['forward', 8], ['up', 3], ['down', 8], ['forward', 2]]) { SubmarineDive.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).list }
end

def test_horizontal_position
  assert_equal(15) { SubmarineDive.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).horizontal_position }
end

def test_depth
  assert_equal(10) { SubmarineDive.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).depth }
end

def test_product_position_depth
  assert_equal(150) { SubmarineDive.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).product_position_depth }
end

test_initialize
test_horizontal_position
test_depth
test_product_position_depth

class SubmarineDive2
  attr_reader :list, :aim, :horizontal_position, :depth, :index
  def initialize(list)
    raise ArgumentError, "Expected array of strings of the form `<forward/down/up> <positive integer>`" unless list.is_a?(Array) && list.all? { |item| item.match(/^(forward|down|up)\s\d+$/) }
    @list = list.map { |item| item.split(' ')}.map { |item| [item[0], item[1].to_i] }
    @aim = 0
    @horizontal_position = 0
    @depth = 0
    @index = 0
  end

  def tick
    item = @list[@index]
    case item[0]
    when 'down' then @aim += item[1]
    when 'up' then @aim -= item[1]
    else
      @horizontal_position += item[1] 
      @depth += @aim * item[1]
    end
    @index += 1
    self
  end

  def final_product
    tick while index < list.length

    horizontal_position * depth
  end
end

def test_new_initialize
  assert_error(ArgumentError) { SubmarineDive2.new(2) }
  assert_error(ArgumentError) { SubmarineDive2.new(['up submarine'])}
end

def test_attributes
  assert_equal([['forward', 5], ['down', 5], ['forward', 8], ['up', 3], ['down', 8], ['forward', 2]]) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).list }
  assert_equal(0) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).aim }
  assert_equal(0) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).horizontal_position }
  assert_equal(0) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).depth }
  assert_equal(0) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).index }

end

def test_tick
  submarine = SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).tick.tick.tick

  assert_equal(3) { submarine.index }
  assert_equal(5) { submarine.aim }
  assert_equal(13) { submarine.horizontal_position }
  assert_equal(40) { submarine.depth }
end

def test_final_product
  assert_equal(900) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).final_product }

end



test_new_initialize
test_attributes
test_tick
test_final_product

arr = File.readlines('input.txt')
puts SubmarineDive.new(arr).product_position_depth
puts SubmarineDive2.new(arr).final_product


