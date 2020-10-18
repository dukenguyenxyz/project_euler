require "./helper"

module Fibonacci
  extend self

  def below(limit : Int32)
    fibonacci = [1, 2]
    cur_num = fibonacci[-1]

    while cur_num < limit
      cur_num = fibonacci[-1] + fibonacci[-2]
      fibonacci.push(cur_num) if cur_num < limit
    end

    fibonacci
  end

  def list(position : Int32)
    self.calculate(->(array : Array(Int32)) { !(array.size == position) })
  end

  def at(position : Int32)
    self.list(position)[-1]
  end

  def digits(size)
    num1 = 1.to_big_i
    num2 = 1.to_big_i
    index = 2

    cur_num = num2

    while cur_num.to_s.split("").size < size
      cur_num = num1.to_big_i + num2.to_big_i
      num1 = num2
      num2 = cur_num
      index += 1
    end

    index
  end

  private def self.calculate(condition : Proc(Array(Int32), Bool))
    fibonacci = [1, 2]

    while condition.call(fibonacci)
      cur_num = fibonacci[-1] + fibonacci[-2]
      fibonacci.push(cur_num)
    end

    fibonacci
  end
end

describe Fibonacci do
  fibonacci_10 = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

  it "should return the first 10 prime numbers" do
    Fibonacci.list(10).should eq(fibonacci_10)
  end

  it "should return the prime number at position 9" do
    Fibonacci.at(9).should eq(fibonacci_10[8])
  end

  it "should return all fibonacci below 90" do
    Fibonacci.below(90).should eq(fibonacci_10)
  end

  it "should return all even-numbered fibonacci below 4,000,000" do
    (Fibonacci.below(4000000).select &.even?).sum.should eq(4613732)
  end

  it "should return the index of the first term in the Fibonacci sequence to contain 1000 digits" do
    Fibonacci.digits(1000).should eq(4782)
  end
end
