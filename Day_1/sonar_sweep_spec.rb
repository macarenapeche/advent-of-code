require './sonar_sweep.rb'
require 'rspec/autorun'

RSpec.describe 'SonarReport' do
  let(:report) { SonarReport.new([199,200,208,210,200,207,240,269,260,263]) }

  it 'has an increase count method' do    
    result = report.increase_count

    expect(result).to be(7)
  end

  it 'has another increase count method' do
    result = report.increase_count_new

    expect(result).to be(7)
  end

  it 'should raise error' do
    expect{ SonarReport.new(4) }.to raise_error(ArgumentError)
    expect{ SonarReport.new(['f']) }.to raise_error(ArgumentError)
  end
end
