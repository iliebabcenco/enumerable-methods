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

  describe '#my_all?' do
    it 'return true if each element from an enum passes the condition from block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be true
    end
    it 'return false if at least one element from an enum does not pass the condition from block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to be false
    end
    it 'return false if at least one element from an enum does not pass the condition from parameter' do
      expect(%w[ant bear cat].my_all?(/t/)).to be false
    end
    it 'return true if each element from an enum passes the condition from parameter' do
      expect(%w[ant pet cat].my_all?(/t/)).to be true
    end
    it 'return false if at least one element from an enum does not pass the condition from parameter' do
      expect([1, '2i', 3.14].my_all?(Numeric)).to be false
    end
    it 'return true if each element from an enum passes the condition from parameter' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be true
    end
    it 'return false if at least one element from an enum is nil or false' do
      expect([nil, true, 99].my_all?).to be false
    end
    it 'return true if all elements from an enums are different to nil and false' do
      expect(['nil', true, 99].my_all?).to be true
    end
    it 'return true if no an enum is empty' do
      expect([].my_all?(Numeric)).to be true
    end
  end

  describe '#my_any?' do
    it 'return true if at least one element form an enum passes the condition from block' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be true
    end
    it 'return false if no one element form an enum passes the condition from block' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to be false
    end
    it 'return true if at least one element form an enum passes the condition from parameter' do
      expect(%w[ant bird cat].my_any?(/d/)).to be true
    end
    it 'return true if no one element from an enum passes the condition from parameter' do
      expect(%w[ant bear cat].my_any?(/d/)).to be false
    end
    it 'return true if at least one element from an enum passes the condition from parameter' do
      expect([nil, true, 99].my_any?(Integer)).to be true
    end
    it 'return true if no one element from an enum passes the condition from parameter' do
      expect([nil, 'false', nil].my_any?(Integer)).to be false
    end
    it 'return true if at least one element from an enum is different to nil or false' do
      expect([nil, true, 99].my_any?).to be true
    end
    it 'return false if all elements from an enum are nil or false' do
      expect([nil, false, nil].my_any?).to be false
    end
    it 'repeat false if enum is empty' do
      expect([].my_any?).to be false
    end
  end

  describe '#my_none?' do
    it 'return true if none element from an enum passes the condition from block' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to be true
    end
    it 'return false if at least one element from an enum passes the condition from block' do
      expect(%w[ant bearr cat].my_none? { |word| word.length == 5 }).to be false
    end
    it 'return true if none element from an enum passes the condition from parameter' do
      expect(%w[ant bear cat].my_none?(/d/)).to be true
    end
    it 'return false if at least one element from an enum passes the condition from parameter' do
      expect(%w[ant bird cat].my_none?(/d/)).to be false
    end
    it 'return true if none element from an enum passes the condition from parameter' do
      expect([1, 3, 42].my_none?(String)).to be true
    end
    it 'return false if at least one element from an enum passes the condition from parameter' do
      expect([1, 3.14, 42].my_none?(Float)).to be false
    end
    it 'return true if enum is empty' do
      expect([].my_none?).to be true
    end
    it 'return true if all elements from an enum are nil or false' do
      expect([nil].my_none?).to be true
    end
    it 'return false if at least one element from an enum is true' do
      expect([nil, false, true].my_none?).to be false
    end
  end

  describe '#my_count' do
    ary = [1, 2, 4, 2]
    it 'return the length of enum if no parameters or blocks' do
      expect(ary.my_count).to eql(4)
    end
    it 'return a counter of elements which match with parameter' do
      expect(ary.my_count(2)).to eql(2)
    end
    it 'return a counter of elements which match with parameter' do
      expect(ary.my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_map' do
    it 'return an Enumerator if no block or parameter' do
      expect(ex.my_map).to be_a(Enumerator)
    end
    it 'return an Enumerator if parameter is nil' do
      expect(ex.my_map(nil)).to be_a(Enumerator)
    end
    it 'return an array with the results of code from block' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
    it 'return an array with the results of code from block' do
      expect((1..4).my_map { 'cat' }).to eql(%w[cat cat cat cat])
    end
  end

  describe '#my_inject' do
    it 'return true if conditios is true far each element' do
      expect((5..10).my_inject(:+)).to be 45
    end
    it 'return true if conditios is true far each element' do
      expect((5..10).my_inject(:*)).to be 151_200
    end
    it 'return true if at least on of conditios is false' do
      expect((5..10).my_inject { |sum, n| sum + n }).to be 45
    end
    it 'return true if at least on of conditios is false' do
      expect((5..10).my_inject { |sum, n| sum * n }).to be 151_200
    end
    it 'repeat the code from block with each element' do
      expect((5..10).my_inject(1, :*)).to be 151_200
    end
    it 'repeat the code from block with each element' do
      expect((5..10).my_inject(1, :+)).to be 46
    end
    it 'repeat the code from block with each element' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to be 151_200
    end
    it 'repeat the code from block with each element' do
      expect(%w[cat sheep bear].my_inject do |memo, word|
               memo.length > word.length ? memo : word
             end).to eql('sheep')
    end
    it 'no block or arguments given' do
      expect { (5..10).my_inject }.to raise_error LocalJumpError
    end
  end
end

describe '#multiply_els' do
  it 'return true if conditios is true far each element' do
    expect(multiply_els([5, 6, 7, 8, 9, 10])).to be 151_200
  end
end
