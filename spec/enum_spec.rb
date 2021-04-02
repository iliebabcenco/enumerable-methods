require './enumerable'

describe 'Enumerable' do
  let(:ex) { [2, 4, 5, 8, 1] }
  let(:ex_hash) { { 0 => 2, 1 => 4, 2 => 5, 3 => 8, 4 => 1 } }
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

  describe '#my_each_with_index' do
    it 'return an Enumerator if no block' do
      expect(ex.my_each).to be_a(Enumerator)
    end
    it 'repeat the code from block with each element and its index' do
      hash = {}
      ex.my_each_with_index { |x, i| hash[i] = x }
      expect(hash).to eql(ex_hash)
    end
  end

  describe '#my_select' do
    it 'return an Enumerator if no block' do
      expect(ex.my_select).to be_a(Enumerator)
    end
    it 'repeat the code from block with each element' do
      arr = []
      ex.my_select { |x| arr << x }
      expect(arr).to eql(ex)
    end
    it 'select elements (numbers) which pass the condition from block' do
      expect((1..10).my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end
    it 'select elements which pass the condition which is given as a parameter' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eql([2, 4])
    end
    it 'select elements (symbols) which pass the condition from block' do
      expect(%i[foo bar].my_select { |x| x == :foo }).to eql([:foo])
    end
  end
end
