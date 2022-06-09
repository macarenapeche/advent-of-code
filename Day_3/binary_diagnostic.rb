class BinaryDiagnostic
  attr_reader :list

  def initialize(list)
    raise ArgumentError, "Expected an array of binary number strings" unless list.all? { |item| item.is_a?(String) && item.match(/^[01]+$/) }    
    @list = list
  end

  def gamma_epsilon_rates
    n = list[0].length
    gamma = ""
    epsilon = ""
    (0...n).each do |i|
      ones = list.select { |item| item[i] == "1" }.count 
      zeroes = list.select { |item| item[i] == "0" }.count
      gamma = ones > zeroes ? gamma + "1" : gamma + "0"
      epsilon = ones < zeroes ? epsilon + "1" : epsilon + "0"
    end
    [gamma.to_i(2), epsilon.to_i(2)] 
  end

  def o2_rate
    n = list[0].length
    o2 = list.map(&:clone)

    (0...n).each do |i|
      return o2.map { |item| item.to_i(2) } if o2.length == 1
      ones = o2.select { |item| item[i] == "1" }.count 
      zeroes = o2.select { |item| item[i] == "0" }.count
      chosen = ones >= zeroes ? "1" : "0"
      o2.select! { |item| item[i] == chosen }
    end
    o2.map { |item| item.to_i(2) }
  end

  def co2_rate
    n = list[0].length
    co2 = list.map(&:clone)

    (0...n).each do |i|
      return co2.map { |item| item.to_i(2) } if co2.length == 1
      ones = co2.select { |item| item[i] == "1" }.count 
      zeroes = co2.select { |item| item[i] == "0" }.count
      chosen = ones >= zeroes ? "0" : "1"
      co2.select! { |item| item[i] == chosen }
    end
    co2.map { |item| item.to_i(2) }
  end

  def power_consumption 
    gamma_epsilon = gamma_epsilon_rates
    gamma_epsilon[0] * gamma_epsilon[1]
  end

  def life_support
    o2_rate[0] * co2_rate[0]
  end
end


arr = File.readlines('input.txt', chomp: true) 
binary_diagnostic = BinaryDiagnostic.new(arr)
puts binary_diagnostic.power_consumption
puts binary_diagnostic.life_support
