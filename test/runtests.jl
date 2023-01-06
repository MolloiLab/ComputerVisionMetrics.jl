using Test

@testset "dice" begin
    include("dice.jl")
end

@testset "hausdorff" begin
    include("hausdorff.jl")
end

@testset "utils" begin
    include("utils.jl")
end