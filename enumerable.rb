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

  end

 