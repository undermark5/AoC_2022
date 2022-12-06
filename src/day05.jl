# https://adventofcode.com/2022/day/5
using AdventOfCodeUtil
include("utils.jl")

example = readlines("./data/day05_example.txt")
input = readlines("./data/day05.txt")
steps_regex = r"\w+ (\d+) \w+ (\d+) \w+ (\d+)"

function part_1(input)
    (stacks, steps) = split(join(input, "\n"), "\n\n") .|> it -> split(it, "\n")
    labels = filter(it -> !all(isspace, it) && it != "", split(last(stacks)))
    stacks = first(stacks, length(stacks) - 1)
    text_size = (parse(Int, last(labels)) * 4) - 1
    stacks = "[" * join(map(it -> begin
        line = it
        if length(line) != text_size
            line *= (" " ^ (text_size - length(it)))
        end
        "[" * replace(line, "] " => "\" ", "    " => "\"\" ", "   " => "\"\"", "[" => "\"", "]" => "\"") * "]"
    end, stacks), ";") * "]"
    stacks = eval(Meta.parse(stacks))
    stacks = slicematrix(permutedims(stacks))
    stacks = stacks .|> it -> filter(it -> it != "", it)
    foreach(it -> begin
        (count, from, to) = parse.(Int, match(steps_regex, it).captures)
        to_move = reverse(collect(Iterators.take(stacks[from], count)))
        push!(to_move, stacks[to]...)
        stacks[to] = to_move
        stacks[from] = last(stacks[from], length(stacks[from]) - count)
    end, steps)
    join(map(first, stacks))
end
@time @show part_1(example)
@time @show part_1(input)

function part_2(input)
    (stacks, steps) = split(join(input, "\n"), "\n\n") .|> it -> split(it, "\n")
    labels = filter(it -> !all(isspace, it) && it != "", split(last(stacks)))
    stacks = first(stacks, length(stacks) - 1)
    text_size = (parse(Int, last(labels)) * 4) - 1
    stacks = "[" * join(map(it -> begin
        line = it
        if length(line) != text_size
            line *= (" " ^ (text_size - length(it)))
        end
        "[" * replace(line, "] " => "\" ", "    " => "\"\" ", "   " => "\"\"", "[" => "\"", "]" => "\"") * "]"
    end, stacks), ";") * "]"
    stacks = eval(Meta.parse(stacks))
    stacks = slicematrix(permutedims(stacks))
    stacks = stacks .|> it -> filter(it -> it != "", it)
    foreach(it -> begin
        (count, from, to) = parse.(Int, match(steps_regex, it).captures)
        to_move = collect(Iterators.take(stacks[from], count))
        push!(to_move, stacks[to]...)
        stacks[to] = to_move
        stacks[from] = last(stacks[from], length(stacks[from]) - count)
    end, steps)
    join(map(first, stacks))
end
@time @show part_2(example)
@time @show part_2(input)
