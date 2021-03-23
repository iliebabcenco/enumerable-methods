module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    to_a.length.times { |i| yield to_a[i] }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    to_a.my_each do |each|
      (yield each, index)
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
        return false unless parameter.nil? ? !each.nil? : none_nil?(parameter, each)
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
      elsif parameter.nil? ? each : none_nil?(parameter, each)
        return true
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
      elsif parameter.nil? ? each == true : none_nil?(parameter, each)
        return false
      end
    end
    true
  end

  def none_nil?(parameter = nil, each = nil)
    return true if !parameter.nil? && parameter === each
  end

  def my_count(parameter = nil, &block)
    if block_given?
      counter = to_a.my_select(&block)
    elsif parameter.nil?
      return to_a.length
    else
      counter = to_a.my_select { |each| each == parameter }
    end
    counter.length
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?

    array = []
    if proc.nil?
      to_a.my_each { |each| array.push(yield each) }
    else
      to_a.my_each { |each| array.push(proc.call(each)) }
    end
    array
  end

  def my_inject(first_param = nil, second_param = nil)
    result = nil
    if block_given?
      unless first_param.nil?
        to_a.my_each { |each| first_param = yield(first_param, each) }
        return first_param
      end
      to_a.my_each { |each| result = result.nil? ? each : yield(result, each) }
    elsif symbol?(first_param)
      to_a.my_each { |each| result = result.nil? ? each : result.send(first_param, each) }
    elsif symbol?(second_param)
      to_a.my_each { |each| first_param = first_param.send(second_param, each) }
      return first_param
    else
      raise LocalJumpError, 'no block or arguments given'
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
