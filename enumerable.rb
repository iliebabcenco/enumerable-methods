module Enumerable
    def my_each
      for i in self
        yield i
      end
      self
    end
    a = [1, 3, 4, 8]
    a.my_each { |element| puts element + 7 }

    def my_each_index
      counter = 0
      for i in self
        yield i, counter
        counter += 1
      end
      self
    end

    a1 = ["ilie", "henry", "dasdas0", "dasdsa"]
    a1.my_each_index { |element, index| p "This is our #{element} and its index = #{index}" }

    def my_select
      array = []
      for i in self
        if yield i 
          array.push(i)
        end
      end
        array
    end
      puts a1.my_select {|each| each != "ilie"}


    def my_all?
      unless block_given?
        for i in self
          if i == false || i == nil 
            return false
          end
        end
      else
        for i in self
          if (yield i) == false || (yield i) == nil 
            return false
          end
        end
      end
      return true
    end

      a1 = ["pp", "henry", "dasdas0", "ilie"]
      p a1.my_all? { |each| each != "ilie" }
      p %w[ant bear cat].all? { |word| word.length >= 3 }
      p %w[ant bear cat].all? { |word| word.length >= 4 }
      p [nil, true, 99].all?                              #=> false
      p [].all?                                           #=> true

      p "\n ilie \t"
  end

 