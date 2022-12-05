# https://adventofcode.com/2022/day/4
using AdventOfCodeUtil

include("utils.jl")

example = readlines("./data/day04_example.txt")
input = readlines("./data/day04.txt")

function part_1(input)
    count(map( it -> begin
        (first, second) = eval(Meta.parse("(" * replace(it,"-" => ":") * ")"))
        all(it -> it in second, first) || all(it -> it in first, second)
    end,
    input
    ))
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    count(map( it -> begin
        (first, second) = eval(Meta.parse("(" * replace(it,"-" => ":") * ")"))
        any(it -> it in second, first) || any(it -> it in first, second)
    end,
    input
    ))
end
@show part_2(example)
@show part_2(input)
