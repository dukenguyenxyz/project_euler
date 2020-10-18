module Multiples
  extend self

  def list(array : Array(Int64), limit : Int64)
    multiples = [] of Int64

    array.each { |num|
      factor = 1i64
      new_num = 1i64

      while new_num < limit
        new_num = factor * num
        multiples.push(new_num) if new_num < limit
        factor += 1i64
      end
    }

    multiples.sort.uniq
  end

  def sum(array : Array(Int64), limit : Int64)
    list(array, limit).sum
  end

  def divisible_by_a?(num : Int64, nums : Array(Int64))
    nums.all? { |n| num.divisible_by?(n) }
  end

  def divisible_by_combo?(num : Int64, arr : Array(Int64))
    combos_list = [] of Array(Int64)
    list = arr
    list.select { |n| num.divisible_by?(n) }
    list.size.times { |n| combos_list.concat(list.combinations(n)) }
    combos_list.reject! &.empty?
    combos = combos_list.map { |c| c.size > 1i64 ? c.product : c[0] }
    combos.includes?(num)
  end

  def factors(num : Int64) : Array(Int64)
    return [1i64] if num == 1i64
    cur_num = num
    list = [] of Int64
    i = 2i64

    while !Prime.is?(cur_num)
      if cur_num.divisible_by?(i)
        cur_num = (cur_num / i).floor.to_i64
        list.push(i)
        i = 2i64
      else
        i += 1i64
      end
    end
    list.push(cur_num)

    list
  end

  def biggest_exponentials(array : Array(Array(Int64))) : Array(Array(Int64))
    # hash = {} of Int64 => Int32

    # new_a = array.map { |a| a.delete(1) }.reject([] of Int64)

    # new_a.each { |a| }
  end

  def smallest(array : Array(Int64))
    # Get all the primes
    copy = array
    primes = Prime.below(array.max.to_i64)
    extra = copy.select { |n| !primes.includes?(n) }

    pp! extra

    extra2 = extra.map { |n| factors(n) }

    pp! extra2
    # extra.reject! { |n| self.divisible_by_combo?(n, primes) }
    # extra.each { |e| primes.each { |p| primes.delete(p) if e.divisible_by?(p) } }
    # (primes + extra).product

    # extra23 = biggest_exponentials(extra2)

    # extra3 = (extra23.flatten).sort
    # pp! primes
    # primes.reject! { |n| extra3.includes?(n) }

    # val = (extra3 + primes)
    # val.product
    # # pp! extra2

    # # pp! extra3
    # pp! primes
  end
end

# [2, 3, 4, 5, 6, 7, 8, 9, 10]
# [2, 3, 5, 7]
# [4, 6, 2, 2, 2, 9, 10]
# [2, 3, 5, 7, 3, 4]

describe Multiples do
  it "should list all numbers below 10 that are multiples of 3 or 5" do
    Multiples.list([3i64, 5i64], 10i64).should eq([3, 5, 6, 9])
  end

  it "should sum all numbers below 10 that are multiples of 3 or 5" do
    Multiples.sum([3i64, 5i64], 10i64).should eq(23)
  end

  it "should find the sum of all the multiples of 3 or 5 below 1000" do
    Multiples.sum([3i64, 5i64], 1000i64).should eq(233168)
  end

  it "should find if a number can divide all nums in an array" do
    Multiples.divisible_by_a?(2520i64, (1i64..10i64).to_a).should eq(true)
  end

  it "should find if a number can be the product of combinations in an array" do
    Multiples.divisible_by_combo?(10i64, [2i64, 3i64, 5i64, 7i64]).should eq(true)
    Multiples.divisible_by_combo?(4i64, [2i64, 3i64, 5i64, 7i64]).should eq(false)
  end

  it "should show factors of a number" do
    Multiples.factors(10i64).should eq([2, 5])
    # Multiples.biggest_exponentials([[1i64], [2i64, 2i64], [2i64, 3i64], [2i64, 2i64, 2i64], [3i64, 3i64], [2i64, 5i64]]).should eq([[2, 2, 2], [3, 3], [5]])
  end

  it "should find the smallest positive number that is evenly divisible by all of the numbers from 1 to 20" do
    # Multiples.smallest((1i64..10i64).to_a).should eq(2520)
    Multiples.smallest((1i64..10i64).to_a)
    # pp! [2, 2, 2,(8) 3, 3, 5, 7].product
    # pp! Multiples.smallest((1i64..20i64).to_a.select &.even?)
  end
end
