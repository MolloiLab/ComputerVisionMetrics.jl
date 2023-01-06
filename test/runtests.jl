using Test

@testset "dice" begin
    include("../src/dice.jl")
end

@testset "hausdorff" begin
    include("../src/hausdorff.jl")
end

@testset "utils" begin
    include("../src/utils.jl")
end