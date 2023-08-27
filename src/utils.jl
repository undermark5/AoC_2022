#=
Utils:
- Julia version: 1.8.0
- Author: nsshurtz
- Date: 2022-11-30
=#

tail((head, tail...)::Vector) = tail

to_ints(strings::Vector{String}) = parse.(Int, strings)

function slicematrix(A::AbstractMatrix)
    return [A[i, :] for i in 1:size(A,1)]
end

function spread(cols::Tuple)
    return [cols...]
end

columns(M) = collect(zip(M...)) .|> spread
