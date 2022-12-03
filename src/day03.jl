# https://adventofcode.com/2022/day/3
using AdventOfCodeUtil
include("utils.jl")

example = readlines("./data/day03_example.txt")
input = readlines("./data/day03.txt")

function part_1(input)
    map(function(it)
        size = Int(length(it) / 2)
        item = intersect(first(it, size),last(it, size))[1][1]
        priority = 0
        if item in 'a':'z'
            priority = item - 'a' + 1
        elseif item in 'A':'Z'
            priority = item - 'A' + 27
        end
        priority
    end, input) |> sum
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    groups = Base.Iterators.partition(input, 3)
    map(function(it)
        item = intersect(it...)[1]
        priority = 0
        if item in 'a':'z'
            priority = item - 'a' + 1
        elseif item in 'A':'Z'
            priority = item - 'A' + 27
        end
        priority
    end, groups) |> sum
end
@show part_2(example)
@show part_2(input)
