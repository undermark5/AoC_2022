# https://adventofcode.com/2022/day/1
using AdventOfCodeUtil

include("utils.jl")

input = readlines("./data/day01.txt")
example = readlines("./data/day01_example.txt")

function part_1(input)
    maximum(map(it -> sum(parse.(Int, split(it))), split(join(input, "\n"), "\n\n")))
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    sum(first(sort(map(it -> sum(parse.(Int, split(it))), split(join(input, "\n"), "\n\n")), rev = true), 3))
end
@show part_2(example)
@show part_2(input)
