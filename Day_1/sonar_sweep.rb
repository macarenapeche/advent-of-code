require '../test_helper.rb'

class SonarReport
  def initialize(list)
    raise ArgumentError, "Expected array of integers as argument" if !list.is_a?(Array) || list.any? { |item| !item.is_a?(Integer) }
    @list = list
  end

  def increase_count
    sum = 0
    @list.each_with_index { |v, i| sum += 1 if @list[i + 1] && @list[i + 1] > v }
    sum
  end

  def increase_count_new
    count = 0
    i = 0
    while @list[i + 3] do
      count += 1 if @list[i] < @list[i + 3]
      i += 1
    end
    count
  end

end


def test_sonar_report_initialize
  assert_error(ArgumentError) { SonarReport.new(4) }
  assert_error(ArgumentError) { SonarReport.new(['f']) }
end

def test_sonar_report_increase 
  assert_equal(1) { SonarReport.new([190, 200]).increase_count }
  assert_equal(7) { SonarReport.new([199,200,208,210,200,207,240,269,260,263]).increase_count }
end

def test_sonar_report_increase_new
  assert_equal(5) { SonarReport.new([199,200,208,210,200,207,240,269,260,263]).increase_count_new }
end

test_sonar_report_initialize
test_sonar_report_increase
test_sonar_report_increase_new


arr = File.readlines('input.txt', chomp: true).map { |item| item.to_i }
puts SonarReport.new(arr).increase_count
puts SonarReport.new(arr).increase_count_new
