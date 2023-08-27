# https://adventofcode.com/2022/day/8
using AdventOfCodeUtil
include("utils.jl")

example = readlines("./data/day08_example.txt")
input = readlines("./data/day08.txt")

function convert_char(c::Char)
    eval(Meta.parse("[$c, false]"))
end

function convert_line(line::String)
    return [line...] .|> convert_char
end

function mark_visible(forest, forest_prime, i, j)
    if (forest[i][j][2] == 0)
        height = forest[i][j][1]
        row_part_1 = forest[i][begin:j]
        row_part_2 = forest[i][j:end]
        col_part_1 = forest_prime[j][begin:i]
        col_part_2 = forest_prime[j][i:end]
        forest[i][j][2] = length(filter(it -> it[1] >= height, row_part_1)) == 1 || length(filter(it -> it[1] >= height, row_part_2)) == 1 || length(filter(it -> it[1] >= height, col_part_1)) == 1 || length(filter(it -> it[1] >= height, col_part_2)) == 1
    end
end

function part_1(input)
    forest = input .|> convert_line
    forest_prime = columns(forest)
    for i in 1:length(forest)
        for j in 1:length(forest[1])
            mark_visible(forest, forest_prime, i, j)
        end
    end
    visible = forest .|> (it -> it .|> (it -> it[2])) |> Iterators.flatten
    
    count(it -> it == 1, visible)
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    nothing
end
@show part_2(example)
@show part_2(input)
