#=
Day01:
- Julia version: 
- Author: nsshurtz
- Date: 2022-11-30
=#
using AdventOfCodeUtil: setup_files

ENV["AOC_SESSION"] = readline(pwd() * "/secrets/session.id")
new_file = setup_files(2022,6)
run(`git add $new_file`)
try
    run(`git commit -m "start $(split(splitdir(new_file)[2], ".")[1])"`)
catch
    @warn "file failed to commit"
end