squares_of_sum = (1..100).to_a.sum**2
sum_of_squares = ((1..100).to_a.map { |x| x**2 }).sum
sum_of_squares - squares_of_sum
# 25164150
