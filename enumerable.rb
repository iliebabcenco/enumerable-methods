module Enumerable
    def my_each
      
      for i in self
        yield i
      end
      self
    end
     a = [1, 3, 4, 8]
     a.my_each { |element| puts element + 7 }
     
  end

 