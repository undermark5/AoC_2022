# https://adventofcode.com/2022/day/6
using AdventOfCodeUtil
using IterTools
include("utils.jl")

example = readlines("./data/day06_example.txt")
input = readlines("./data/day06.txt")

function part_1(input)
    findfirst(map(it -> length(unique(it)) == 4, IterTools.partition(input[1], 4, 1))) + 3
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    findfirst(map(it -> length(unique(it)) == 14, IterTools.partition(input[1], 14, 1))) + 13
end
@show part_2(example)
@show part_2(input)
