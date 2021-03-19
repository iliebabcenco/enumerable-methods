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

  # def my_none?(parameter = nil)
  #   unless block_given? #we go if we dont have block {}
  #     if parameter == nil #we dont have parameter
  #       for i in self
  #         if i == false || i == nil 
  #           return true
  #         end
  #       end
  #     elsif parameter.instance_of? Class #we have a Class like a parameter
  #       for i in self
  #         unless i.is_a? parameter
  #           return true
  #         end
  #       end
  #     else
  #       for i in self
  #         unless parameter.match?(i)
  #           return true
  #         end
  #       end
  #     end
  #   else #we go if we have block {}
  #     for i in self
  #       if (yield i) == false || (yield i) == nil 
  #         return true
  #       end
  #     end
  #   end
  #   return false
  # end

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


   

p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w{ant bear cat}.my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false
end

 