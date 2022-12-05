# https://adventofcode.com/2022/day/5
using AdventOfCodeUtil

input = readlines("./data/day05.txt")

function part_1(input)
    (stacks, steps) = split(join(input, "\n"), "\n\n") .|> it -> split(it, "\n")
    labels = last(stacks)
    stacks = first(stacks, length(stacks) - 1)
    text_size = (parse(Int, last(labels)) * 4) - 1
    stacks = "[" * join(map(it -> begin
        line = it
        if length(line) != text_size
            line *= (" " ^ (text_size - length(it)))
        end
        "[" * replace(line, "   " => "[ ]", " " => ",", "[" => "\"", "]" => "\"") * "]"
    end, stacks), ",") * "]"
    println(stacks)
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)
