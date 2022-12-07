# https://adventofcode.com/2022/day/7
using AdventOfCodeUtil
include("utils.jl")

example = readlines("./data/day07_example.txt")
input = readlines("./data/day07.txt")

abstract type CmdLine{T} end
abstract type Cmd{T} <: CmdLine{T} end
struct Cd <: Cmd{:cd}
    arg::String
end
struct Ls <: Cmd{:ls}
end
abstract type Listing <: CmdLine{:listing}
end
struct File <: Listing
    name::String
    size::Int
end
struct Dir <: Listing
    name::String
    parent::Union{Listing, Nothing}
    contents::Vector{Listing}
end

function computesize(file::File)
    file.size
end

function computesize(dir::Dir)
    map(computesize, dir.contents) |> sum
end

function flatten(dir::Dir)
    base = [dir]
    flat = flatten.(filter(it -> isa(it, Dir), dir.contents))
    push!(base, (flat...)...)
end

function part_1(input)
    root = Dir("/", nothing, [])
    current = root
    foreach(it -> begin
        if startswith(it, "\$")
            (_, cmd, args...) = split(it)
            if cmd == "cd"
                if args[1] == "/"
                    current = root
                elseif args[1] == ".."
                    current = current.parent
                else
                    idx = findfirst(it -> begin
                        isa(it, Dir) && it.name == args[1]
                    end, current.contents)
                    current = current.contents[idx]
                end
            end
        elseif startswith(it, "dir")
            (_, name) = split(it)
            push!(current.contents, Dir(name, current, []))
        else
            (sizestr, name) = split(it)
            push!(current.contents, File(name, parse(Int, sizestr)))
        end
    end, input)
    dirs = flatten(root)
    filter(it-> it <= 100000, map(it -> computesize(it), dirs)) |> sum
end
@time @show part_1(example)
@time @show part_1(input)

function part_2(input)
    root = Dir("/", nothing, [])
    current = root
    foreach(it -> begin
        if startswith(it, "\$")
            (_, cmd, args...) = split(it)
            if cmd == "cd"
                if args[1] == "/"
                    current = root
                elseif args[1] == ".."
                    current = current.parent
                else
                    idx = findfirst(it -> begin
                        isa(it, Dir) && it.name == args[1]
                    end, current.contents)
                    current = current.contents[idx]
                end
            end
        elseif startswith(it, "dir")
            (_, name) = split(it)
            push!(current.contents, Dir(name, current, []))
        else
            (sizestr, name) = split(it)
            push!(current.contents, File(name, parse(Int, sizestr)))
        end
    end, input)
    dirs = flatten(root)
    usedspace = computesize(root)
    freespace = 70000000 - usedspace
    neededspace = 30000000 - freespace
    filter(it-> it >= neededspace, map(it -> computesize(it), dirs)) |> minimum
end
@time @show part_2(example)
@time @show part_2(input)
