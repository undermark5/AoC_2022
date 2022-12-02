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

struct rps_choice{T} end

function rps_to_string(::rps_choice{:A})
    "rock"
end

function rps_to_string(rps::rps_choice{:B})
    "paper"
end

function rps_to_string(rps::rps_choice{:C})
    "paper"
end

function score(rps::rps_choice{:A})
    1
end

function score(rps::rps_choice{:B})
    2
end

function score(rps::rps_choice{:C})
    3
end

function score(match::Tuple)
    shape_score = score(match[2])
    indexes = score.(match)
    win_table[indexes[1]][2] + shape_score
end

function score2(match::Tuple)
    goal = score(match[2])
    indexes = score.(match)
    shape_table[goal][indexes[1]] + win_table2[goal]
end

function printrps(match)
    println("$(rps_to_string(match[1])) vs $(rps_to_string(match[2])): $(score(match))")
    match
end

function parse_to_symbol(code)
    eval(Meta.parse(code))
end

function symbol_to_rps(symbol)
    rps_choice{symbol}()
end

function prepender(value)
    ":" * value
end

function part_1(input)
    map(it -> split(it) |> it -> (it[1], "$(first(it[2]) - 23)") .|> prepender .|> parse_to_symbol .|> symbol_to_rps |> score, input) |> sum
    #     map(it -> split(it) .|> first |> it -> (it[1] - 'A' + 1, it[2] - 'X' + 1) |> it -> (score = win_table[it[2]][it[1]] + it[2]), input) |> sum
end
@show part_1(example)
@show part_1(input)

function part_2(input)
    map(it -> split(it) |> it -> (it[1], "$(first(it[2]) - 23)") .|> prepender .|> parse_to_symbol .|> symbol_to_rps |> score2, input) |> sum
#     map(it -> split(it) .|> first |> it -> (it[1] - 'A' + 1, it[2] - 'X' + 1) |> it -> (score = shape_table[it[2]][it[1]] + win_table2[it[2]]), input) |> sum
end
@show part_2(example)
@show part_2(input)
