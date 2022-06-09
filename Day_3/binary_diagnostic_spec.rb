require './binary_diagnostic.rb'

RSpec.describe BinaryDiagnostic do 
  subject(:diagnostic) { BinaryDiagnostic.new(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])}
  
  it 'has a gamma_epsilon_rates method' do
    rates = diagnostic.gamma_epsilon_rates 

    expect(rates).to eq([22, 9])
  end

  it 'has a o2_rate method' do
    rate = diagnostic.o2_rate

    expect(rate).to eq([23])
  end

  it 'has a co2_rate method' do
    rate = diagnostic.co2_rate

    expect(rate).to eq([10])
  end

  it 'has a power consumption method' do
    power_consumption = diagnostic.power_consumption 

    expect(power_consumption).to eq(198) 
  end

  it 'has a life_support_rating' do
    life_support = diagnostic.life_support

    expect(life_support).to eq(230)
  end

  context 'when given an invalid input' do
    it 'should raise an error' do 
      expect { BinaryDiagnostic.new([2, 3, 4]) }.to raise_error(ArgumentError) 
    end
  end
end
