require "./helper"

module Prime
  extend self

  def below(limit : Int64)
    cur_num = 2.to_i64
    primes = [2.to_i64]

    while cur_num < limit
      cur_num += 1.to_i64
      primes.push(cur_num) if primes.all? { |p| !cur_num.divisible_by?(p) }
    end

    primes
  end

  def list(position : Int64)
    self.calculate(->(array : Array(Int64)) { !(array.size == position) })
  end

  def at(position : Int64)
    self.list(position)[-1]
  end

  private def self.calculate(condition : Proc(Array(Int64), Bool))
    cur_num = 2.to_i64
    primes = [2.to_i64]

    while condition.call(primes)
      cur_num += 1.to_i64
      primes.push(cur_num) if primes.all? { |p| !cur_num.divisible_by?(p) }
    end

    primes
  end

  def is?(num : Int64)
    Prime.below(num + 1).includes?(num)
  end

  def is_not?(num : Int64)
    !self.is?(num)
  end

  def factors(num : Int64)
    primes_list = self.below(num + 1.to_i64)
    list = [] of Int64
    primes_list.each { |x| list.push(x) if num.divisible_by?(x) }
    list
  end

  def max_factor(num : Int64)
    cur_num = num
    divide_num = 2
    max = 2

    while max < cur_num || divide_num != cur_num
      if cur_num.divisible_by?(divide_num)
        cur_num = (cur_num / divide_num).floor.to_i64
        max = divide_num
        divide_num = 2
      else
        divide_num += 1
      end
    end

    max
  end
end

describe Prime do
  primes_100 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]

  it "should return the first 25 prime numbers" do
    Prime.list(25.to_i64).should eq(primes_100)
  end

  it "should return the prime number at position 1001st" do
    Prime.at(10001.to_i64).should eq(104743)
  end

  it "should return all primes below 100" do
    Prime.below(100.to_i64).should eq(primes_100)
    # Prime.below(2000000).sum.should eq(142913828922)
    # pp! Prime.below(600851475143)[-1]
  end

  it "should check whether a number is a prime" do
    Prime.is?(13.to_i64).should eq(true)
  end

  it "should return all prime factors of 13195" do
    Prime.factors(13195.to_i64).should eq([5, 7, 13, 29])
    Prime.factors(13195.to_i64).max.should eq(29)
  end

  # # Problem 3: Unsolved
  # it "should return the largest prime factor" do
  #   # Prime.max_factor(13195.to_i64).should eq(29)
  #   # pp! Prime.factors(600851475143.to_i64).max
  # end
end
