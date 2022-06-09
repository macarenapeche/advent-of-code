require './dive.rb'

RSpec.describe SubmarineDive do
  subject(:dive) { SubmarineDive.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2'])}
  
  describe 'attributes' do
    it { is_expected.to have_attributes(list: [['forward', 5], ['down', 5], ['forward', 8], ['up', 3], ['down', 8], ['forward', 2]]) }
  
    context 'when given a bad input' do
      it 'raises an error' do
        expect { SubmarineDive.new(['cat']) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'methods' do
    it 'calculates final horizontal position' do
      result = dive.horizontal_position

      expect(result).to eq(15)
    end

    it 'calculates final depth' do
      result = dive.depth

      expect(result).to eq(10)
    end

    it 'calculates the product of position and depth' do
      result = dive.product_position_depth

      expect(result).to eq(150)
    end
  end
end


RSpec.describe SubmarineDive2 do
  subject(:dive) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']) }

  describe 'attributes' do
    it { is_expected.to have_attributes(index:0, aim: 0, horizontal_position: 0, depth: 0, list: [['forward', 5], ['down', 5], ['forward', 8], ['up', 3], ['down', 8], ['forward', 2]])}
  
    context 'when given a bad input' do
      it 'raises an error' do
        expect { SubmarineDive2.new(['cat']) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'methods' do
    describe 'tick' do
      let(:another_dive) { SubmarineDive2.new(['down 5', 'forward 8']) }

      it 'changes the index' do
        expect { another_dive.tick }.to change { another_dive.index }.by(1) 
      end

      context 'when moving up or down' do
        it 'changes the aim' do
          expect { another_dive.tick }.to change { another_dive.aim }.by(5) 
        end
      end

      context 'when moving forward' do
        let(:one_tick_dive ) { another_dive.tick }
        
        it 'changes the horizontal_position' do
          expect { one_tick_dive.tick }.to change { one_tick_dive.horizontal_position }.by(8)
        end

        it 'changes the depth' do
          expect { one_tick_dive.tick }.to change { one_tick_dive.depth }.by(40)
        end
      end
    end

    describe 'final_product' do
      let(:product) { SubmarineDive2.new(['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']).final_product }

      specify { expect(product).to eq(900) }
    end
  end
end
