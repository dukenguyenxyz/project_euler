require "spec"

module PrimeNumber
  extend self

  def list(size : Int32)
    self.calculate(size)
  end

  def at(position : Int32)
    self.calculate(position)[-1]
  end

  private def self.calculate(position : Int32)
    cur_num = 2
    primes = [2]

    until primes.size == position
      cur_num += 1
      primes.push(cur_num) if primes.all? { |p| !cur_num.divisible_by?(p) }
    end

    primes
  end
end

it "should return the first 25 prime numbers" do
  PrimeNumber.list(25).should eq([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97])
end

it "should return the prime number at position 1001st" do
  PrimeNumber.at(10001).should eq(104743)
end
