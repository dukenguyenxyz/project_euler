require "./helper"

module Palindrome
  extend self

  def list(position : Int64)
    list = [] of Int64
    current = 0i64

    while list.size != position
      list.push(current) if self.is?(current)
      current += 1i64
    end

    list
  end

  def below(num : Int64)
  end

  def is?(num : Int64)
    arr = num.to_s.split("")
    arr.each_with_index { |v, i| return false if v != arr[-i + -1] } if arr.size != 1
    true
  end

  def largest(num : Int32, digits : Int32)
    (999..100)
  end
end

describe Palindrome do
  it "can detect a palindrome" do
    Palindrome.is?(1).should eq(true)
    Palindrome.is?(9009).should eq(true)
    Palindrome.is?(8181).should eq(false)
  end

  it "can list palindrome" do
    palindrome_30 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88, 99, 101, 111, 121, 131, 141, 151, 161, 171, 181, 191, 202]
    Palindrome.list(30).should eq(palindrome_30)
  end

  # it "finds the largest palindrome made from the product of two 3-digit numbers" do
  #   pp! Palindrome.largest(2, 3)
  # end
end
