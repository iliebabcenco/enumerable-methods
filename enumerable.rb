module Enumerable
  def my_each
    for i in self
      yield i
    end
    self
  end
  a = [1, 3, 4, 8]
  # a.my_each { |element| puts element + 7 }

  def my_each_index
    counter = 0
    for i in self
      yield i, counter
      counter += 1
    end
    self
  end

  a1 = ["ilie", "henry", "dasdas0", "dasdsa"]
  # a1.my_each_index { |element, index| p "This is our #{element} and its index = #{index}" }

  def my_select
    array = []
    for i in self
      if yield i 
        array.push(i)
      end
    end
      array
  end
    # puts a1.my_select {|each| each != "ilie"}


  def my_all?(parameter = nil)
    unless block_given? #we go if we dont have block {}
      if parameter == nil #we dont have parameter
        for i in self
          if i == false || i == nil 
            return false
          end
        end
      elsif parameter.instance_of? Class #we have a Class like a parameter
        for i in self
          unless i.is_a? parameter
            return false
          end
        end
      else
        for i in self
          unless parameter.match?(i)
            return false
          end
        end
      end
    else #we go if we have block {}
      for i in self
        if (yield i) == false || (yield i) == nil 
          return false
        end
      end
    end
    return true
  end

  def my_any?(parameter = nil)
    unless block_given? #we go if we dont have block {}
      if parameter == nil #we dont have parameter
        for i in self
         if i != false || i != nil 
           return true
          end
        end
      elsif parameter.instance_of? Class #we have a Class like a parameter
        for i in self
          if i.is_a? parameter
            return true
          end
        end
      else
        for i in self
          if parameter.match?(i)
            return true
          end
        end
      end
    else #we go if we have block {}
      for i in self
        if (yield i) != false || (yield i) != nil 
          return true
        end
      end
    end
    return false
  end

  def my_none?(parameter = nil)
    unless block_given? #we go if we dont have block {}
      if parameter == nil #we dont have parameter
        for i in self
         if i == true 
           return false
          end
        end
      elsif parameter.instance_of? Class #we have a Class like a parameter
        for i in self
          if i.is_a? parameter
            return false
          end
        end
      else
        for i in self
          if parameter.match?(i)
            return false
          end
        end
      end
    else #we go if we have block {}
      for i in self
        if (yield i) == true  
          return false
        end
      end
    end
    return true
  end

# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false

  def my_count(parameter = nil)
    unless block_given?
      if parameter == nil
        return self.length
      else
        counter = 0
        for i in self
          if i == parameter
            counter+=1
          end
        end
        return counter
      end
    else
      counter = 0
      for i in self
        if yield i
          counter+=1
        end
      end
      return counter
    end
  end

  # p ary = ["ant", "cat", "gagaga", "eeee", "cat"]
  # p ary.my_count               #=> 5
  # p ary.my_count("cat")            #=> 2
  # p ary.my_count{ |x| x=="eeee" } #=> 1

  def my_map
    return to_enum unless block_given?
    array = []
    for i in self
      if yield i
        array.push(i) 
      end
    end
    array
  end
  ary = ["ant", "cat", "gagaga", "eeee", "cat"]
  # p ary.my_map
  # p ary.my_map {|x| x == "cat"}


  def my_inject(first_param = nil, second_param = nil)
    result = 0
    unless block_given?
      if first_param != nil && second_param != nil && second_param.is_a?(Symbol)
        self.to_a.my_each {|each| first_param = first_param.send(second_param, each)}
        return first_param
      elsif first_param != nil && first_param.is_a?(Symbol) && second_param == nil
        self.to_a.my_each {|each| result = result.send(first_param, each)}
      end
    else
      if first_param == nil && second_param == nil
        for i in self
          result = yield i, result
        end
      elsif first_param != nil && second_param == nil
        for i in self
          first_param = yield first_param, i 
        end
        return first_param
      end
    end
    return result
  end

#rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# Same using a block
p (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# Same using a block and inject
p (5..10).my_inject { |sum, n| sum + n }            #=> 45
  # Sum some numbers
p (5..10).my_inject(:*)                             #=> 45
# Multiply some numbers
p (5..10).my_inject(1, :+)                          #=> 151200 value.is_a?(Symbol)


end

 