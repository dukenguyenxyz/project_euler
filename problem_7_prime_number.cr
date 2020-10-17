require "spec"

module PrimeNumber
  extend self

  def below(limit : Int32)
    cur_num = 2
    primes = [2]

    while cur_num < limit
      cur_num += 1
      primes.push(cur_num) if primes.all? { |p| !cur_num.divisible_by?(p) }
    end

    primes
  end

  def list(position : Int32)
    condition = ->(array : Array(Int32)) { !(array.size == position) }

    self.calculate(condition)
  end

  def at(position : Int32)
    condition = ->(array : Array(Int32)) { !(array.size == position) }

    self.calculate(condition)[-1]
  end

  private def self.calculate(condition : Proc(Array(Int32), Bool))
    cur_num = 2
    primes = [2]

    while condition.call(primes)
      cur_num += 1
      primes.push(cur_num) if primes.all? { |p| !cur_num.divisible_by?(p) }
    end

    primes
  end
end

describe PrimeNumber do
  primes_100 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]

  it "should return the first 25 prime numbers" do
    PrimeNumber.list(25).should eq(primes_100)
  end

  it "should return the prime number at position 1001st" do
    PrimeNumber.at(10001).should eq(104743)
  end

  it "should return all primes below 100" do
    PrimeNumber.below(100).should eq(primes_100)
  end
end
