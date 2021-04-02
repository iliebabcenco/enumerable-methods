require './enumerable'

describe 'Enumerable' do
    let(:ex) {[2, 4, 5, 8, 1]}
    let(:ex_hash) {{ 0 => 2, 1 => 4, 2 => 5, 3 => 8, 4 => 1 }}
    describe '#my_each' do
      it 'return an Enumerator if no block' do
        expect(ex.my_each).to be_a(Enumerator)
      end
      it 'repeat the code from block with each element' do
        arr = []
        ex.my_each { |x| arr << x }
        expect(arr).to eql(ex)
      end
    end

end