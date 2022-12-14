# https://adventofcode.com/2022/day/13
using AdventOfCodeUtil
include("utils.jl")

example = readlines("./data/day13_example.txt")
input = readlines("./data/day13.txt")

const EQUAL = :e
const LESS_THAN = :l
const GREATER_THAN = :g

function compare(left::Vector, right::Vector)
    if length(left) == 0 && length(right) > 0
        return LESS_THAN
    elseif length(left) == 0 && length(right) == 0
        return EQUAL
    elseif length(left) > 0 && length(right) == 0
        return GREATER_THAN
    else
        status = compare(first(left),first(right))
        if status == EQUAL
            return compare(tail(left), tail(right))
        else
            return status
        end
    end
end

function compare(left::Int, right::Int)
    if (left == right)
        return EQUAL
    elseif (left < right)
        return LESS_THAN
    else
        return GREATER_THAN
    end
end

function compare(left::Int, right::Vector)
    compare([left], right)
end

function compare(left::Vector, right::Int)
    compare(left, [right])
end

function part_1(input)
    pairs = split(join(input, "\n"),"\n\n")
    findall(it -> it, map(pair -> begin
        (left, right) = split(pair, "\n")
        left = eval(Meta.parse(left))
        right = eval(Meta.parse(right))
        compare(left,right) == LESS_THAN
    end, pairs)) |> sum
end
@show part_1(example)
@show part_1(input)

function packetisless(left, right)
    compare(left, right) == LESS_THAN
end

function part_2(input)
    input = filter(it -> !isempty(filter(it -> !isspace(it), it)), input)
    packets = map(it -> begin
        eval(Meta.parse(it))
    end, input)
    divider1 = [[2]]
    divider2 = [[6]]
    append!(packets, [divider1, divider2])
    sorted = sort(packets, lt=packetisless)
    findfirst(it -> it == divider1, sorted) * findfirst(it -> it == divider2, sorted)
end
@show part_2(example)
@show part_2(input)
