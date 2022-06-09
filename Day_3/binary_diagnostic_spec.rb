require './binary_diagnostic.rb'

RSpec.describe BinaryDiagnostic do 
  subject(:diagnostic) { BinaryDiagnostic.new(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])}
  
  it 'has a rates method' do
    rates = diagnostic.rates 

    expect(rates).to eq(["10110", "01001"])
  end

  it 'has a power consumption method' do
    power_consumption = diagnostic.power_consumption 

    expect(power_consumption).to eq(198) 
  end

  context 'when given an invalid input' do
    it 'should raise an error' do 
      expect { BinaryDiagnostic.new([2, 3, 4]) }.to raise_error(ArgumentError) 
    end
  end
end
