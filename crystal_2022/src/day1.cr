input = File.read("input/day1.txt")

most_calories =
  input
    .split("\n\n")
    .map do |calorie_group|
      calorie_group
        .split("\n")
        .map(&.to_i)
    end
    .map(&.sum)
    .max

puts most_calories

# part 2

sum_of_top_3 =
  input
    .split("\n\n")
    .map do |calorie_group|
      calorie_group
        .split("\n")
        .map(&.to_i)
    end
    .map(&.sum)
    .sort
    .last(3)
    .sum

puts sum_of_top_3
