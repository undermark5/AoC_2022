# https://adventofcode.com/2022/day/2
using AdventOfCodeUtil
include("utils.jl")

example = readlines("./data/day02_example.txt")
input = readlines("./data/day02.txt")

win_table = [
    [3, 0, 6],
    [6, 3, 0],
    [0, 6, 3]
]

win_table2 = [0, 3, 6]
shape_table = [
    [3, 1, 2],
    [1, 2, 3],
    [2, 3, 1]
]


function part_1(input)
    map(it -> split(it) .|> first |> it -> (it[1] - 'A' + 1, it[2] - 'X' + 1) |> it -> (score = win_table[it[2]][it[1]] + it[2]), input) |> sum
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    map(it -> split(it) .|> first |> it -> (it[1] - 'A' + 1, it[2] - 'X' + 1) |> it -> (score = shape_table[it[2]][it[1]] + win_table2[it[2]]), input) |> sum
end
@show part_2(example)
@show part_2(input)
