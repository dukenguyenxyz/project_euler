require "spec"
require "big"

def factorial_digit_sum(num : Int64) : Int32
  (num.to_big_i.factorial.to_s.split("").map &.to_i).sum
end

factorial_digit_sum(10i64).should eq(27)
pp! factorial_digit_sum(100i64)
