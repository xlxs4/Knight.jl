using Knight
using Test
using Aqua
using JET

@testset "Knight.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(Knight)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(Knight; target_defined_modules = true)
    end
    @testset "runfile" begin
        return Knight.runfile("../code.kn")
    end
end
