class BinaryDiagnostic
  attr_reader :list

  def initialize(list)
    raise ArgumentError, "Expected an array of binary number strings" unless list.all? { |item| item.is_a?(String) && item.match(/^[01]+$/) }    
    @list = list
  end

  def rates
    n = list[0].length
    gamma = ""
    epsilon = ""
    (0...n).each do |i|
      ones = list.select { |item| item[i] == "1" }.count 
      zeroes = list.select { |item| item[i] == "0" }.count
      gamma = ones > zeroes ? gamma + "1" : gamma + "0"
      epsilon = ones < zeroes ? epsilon + "1" : epsilon + "0"
    end
    [gamma, epsilon] 
  end

  def power_consumption 
    gamma_epsilon = rates
    gamma_epsilon[0].to_i(2) * gamma_epsilon[1].to_i(2)
  end
end
