module Enumerable
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    counter = 0
    while counter < length
      yield self[counter], counter
      counter += 1
    end
    self
  end

  def my_select
    array = []
    i = 0
    while i < length
      array.push(self[i]) if yield self[i]
      i += 1
    end
    array
  end

  def my_all?(parameter = nil)
    if block_given?
      to_a.my_each { |each| return false if (yield each) == false || (yield each).nil? }
    elsif parameter.nil?
      to_a.my_each { |each| return false if each == false || each.nil? }
    elsif parameter.instance_of? Class
      to_a.my_each { |each| return false unless each.is_a? parameter }
    else
      to_a.my_each { |each| return false unless parameter.match?(each) }
    end
    true
  end

  def my_any?(parameter = nil)
    if block_given?
      to_a.my_each { |each| return true if (yield each) != false || (yield each) != nil }
    elsif parameter.nil?
      to_a.my_each { |each| return true if each != false || !each.nil? }
    elsif parameter.instance_of? Class
      to_a.my_each { |each| return true if each.is_a? parameter }
    else
      to_a.my_each { |each| return true if parameter.match?(each) }
    end
    false
  end

  def my_none?(parameter = nil)
    if block_given?
      to_a.my_each { |each| return false if (yield each) == true }
    elsif parameter.nil?
      to_a.my_each { |each| return false if each == true }
    elsif parameter.instance_of? Class
      to_a.my_each { |each| return false unless each.is_a? parameter }
    else
      to_a.my_each { |each| return false if parameter.match?(each) }
    end
    true
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
    result = 0
    if block_given?
      if first_param.nil? && second_param.nil?
        to_a.my_each { |each| result = result.zero? ? each : yield(result, each) }
      elsif !first_param.nil? && second_param.nil?
        to_a.my_each { |each| first_param = first_param.zero? ? each : yield(first_param, each) }
        return first_param
      end
    elsif !first_param.nil? && !second_param.nil? && second_param.is_a?(Symbol)
      to_a.my_each { |each| first_param = first_param.send(second_param, each) }
      return first_param
    elsif !first_param.nil? && first_param.is_a?(Symbol) && second_param.nil?
      to_a.my_each { |each| result = result.zero? ? each : result.send(first_param, each) }
    end
    result
  end
end

def multiply_els(array)
  array.my_inject(:*)
end
