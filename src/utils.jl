#=
Utils:
- Julia version: 1.8.0
- Author: nsshurtz
- Date: 2022-11-30
=#

tail((head, tail...)::Vector) = tail

to_ints(strings::Vector{String}) = parse.(Int, strings)
