module Enumerable
  ARRAY_SIZE = 100
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

array =  Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) }
block = proc { |num| num < (LOWEST_VALUE + HIGHEST_VALUE) / 2 } 
words = %w[dog door rod blade]
range = Range.new(5, 50)
hash = { a: 1, b: 2, c: 3, d: 4, e: 5 } 
numbers = [1, 5, 3.14]
array_clone = array.clone
  def my_each
    return to_enum(:my_each) unless block_given?
    to_a.length.times { |i| yield to_a[i]}
    self
  end
  
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    index = 0
    to_a.my_each do |each| (yield each, index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    array = []
    to_a.my_each { |each| array.push(each) if yield each }
    array
  end

  def my_all?(parameter = nil)
    to_a.my_each do |each|
      if block_given?
        return false unless yield each
      elsif parameter.instance_of? Class
        return false unless each.is_a? parameter
      else 
        return false unless each
        return false if none_nil?(parameter, each)
      end
    end
    true
  end

  def my_any?(parameter = nil)
    to_a.my_each do |each|
      if block_given?
        return true if yield each
      elsif parameter.instance_of? Class
        return true if each.is_a? parameter
      else
        return true if result = parameter.nil? ? (!!each) : none_nil?(parameter, each)
      end
    end
    false
  end
  

  def my_none?(parameter = nil)
    to_a.my_each do |each|
      if block_given?
        return false if yield each
      elsif parameter.instance_of? Class
        return false unless each.is_a? parameter
      else
        return false if each == true
        return false if none_nil?(parameter, each)
      end
    end
    true
  end

  def none_nil?(parameter = nil, each = nil)
    
    return true if !parameter.nil? && parameter === each

    false
  end

  def my_count(parameter = nil, &block)
    if block_given?
      counter = to_a.my_select(&block)
      counter.length
    elsif parameter.nil?
      to_a.length
    else
      counter = to_a.my_select { |each| each == parameter }
      counter.length
    end
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?

    array = []
    if proc.nil?
      to_a.my_each { |each| array.push(yield each) }
    else
      to_a.my_each { |_each| array.push(proc.call(to_a[i])) }
    end
    array
  end

  def my_inject(first_param = nil, second_param = nil)
    result = nil
    if block_given?
      if first_param.nil?
        to_a.my_each { |each| result = result.nil? ? each : yield(result, each) }
      else
        to_a.my_each { |each| first_param = yield(first_param, each) }
        return first_param
      end
    elsif symbol?(first_param)
      to_a.my_each { |each| result = result.nil? ? each : result.send(first_param, each) }
    else
      to_a.my_each { |each| first_param = first_param.send(second_param, each) }
      return first_param
    end
    result
  end

  def symbol?(param1 = nil)
    !param1.nil? && (param1.is_a? Symbol)
  end
end

def multiply_els(array)
  array.my_inject(:*)
end
