#
# Author: Jag Nandigam
#
# Your first class in Ruby
#
class Customer
  
  def name
    @name
  end
  
  def name=(value)
    @name = value
  end
  
  def age
    @age
  end
  
  def age=(value)
    @age = value
  end
  
  def id
    @id
  end
  
  def id=(value)
    @id = value
  end
  
  def initialize(name, age=0, id="TBD")
    @name = name
    @age = age
    @id = id
  end
  
  def to_s
    "#{name} #{age} #{id}"
  end
  
end

def main
	c1 = Customer.new("John",35,"1234")
	puts c1

	c2 = Customer.new("Kevin")
	puts c2

  c3 = Customer.new("James",20)
  puts c2
   
	c1.name = "Alex"
	c1.age = 20
	c1.id = "C456"
	puts(c1.name)
	puts(c1.age)
	puts(c1.id)
end

# invoke main function
main()

