module Enumerable
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_index
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
      i = 0
      while i < length
        return false if (yield self[i]) == false || (yield self[i]).nil?

        i += 1
      end
    elsif parameter.nil?
      i = 0
      while i < length
        return false if self[i] == false || self[i].nil?

        i += 1
      end
    elsif parameter.instance_of? Class
      i = 0
      while i < length
        return false unless self[i].is_a? parameter

        i += 1
      end
    else
      i = 0
      while i < length
        return false unless parameter.match?(self[i])

        i += 1
      end
    end
    true
  end

  def my_any?(parameter = nil)
    if block_given?
      i = 0
      while i < length
        return true if (yield self[i]) != false || (yield self[i]) != nil

        i += 1
      end
    elsif parameter.nil?
      i = 0
      while i < length
        return true if self[i] != false || !self[i].nil?

        i += 1
      end
    elsif parameter.instance_of? Class
      i = 0
      while i < length
        return true if self[i].is_a? parameter

        i += 1
      end
    else
      i = 0
      while i < length
        return true if parameter.match?(self[i])

        i += 1
      end
    end
    false
  end

  def my_none?(parameter = nil)
    if block_given?
      i = 0
      while i < length
        return false if (yield self[i]) == true

        i += 1
      end
    elsif parameter.nil?
      i = 0
      while i < length
        return false if self[i] == true

        i += 1
      end
    elsif parameter.instance_of? Class
      i = 0
      while i < length
        return false unless self[i].is_a? parameter

        i += 1
      end
    else
      i = 0
      while i < length
        return false if parameter.match?(self[i])

        i += 1
      end
    end
    true
  end

  def my_count(parameter = nil)
    if block_given?
      counter = 0
      i = 0
      while i < length
        counter += 1 if yield self[i]
        i += 1
      end
      counter
    elsif parameter.nil?
      length
    else
      counter = 0
      i = 0
      while i < length
        counter += 1 if self[i] == parameter
        i += 1
      end
      counter
    end
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?

    array = []
    if proc.nil?
      i = 0
      while i < to_a.length
        array.push(yield to_a[i])
        i += 1
      end
    else
      i = 0
      while i < to_a.length
        array.push(proc.call(to_a[i]))
        i += 1
      end
    end
    array
  end

  def my_inject(first_param = nil, second_param = nil)
    result = 0
    if block_given?
      if first_param.nil? && second_param.nil?
        to_a.my_each { |each| result = result == 0 ? each : yield(result, each) }
      elsif !first_param.nil? && second_param.nil?
        to_a.my_each { |each| first_param = first_param == 0 ? each : yield(first_param, each) }
        return first_param
      end
    elsif !first_param.nil? && !second_param.nil? && second_param.is_a?(Symbol)
      to_a.my_each { |each| first_param = first_param.send(second_param, each) }
      return first_param
    elsif !first_param.nil? && first_param.is_a?(Symbol) && second_param.nil?
      to_a.my_each { |each| result = result == 0 ? each : result.send(first_param, each) }
    end
    result
  end
end

def multiply_els(array)
  array.my_inject(:*)
end
