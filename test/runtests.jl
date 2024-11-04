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
    @testset "Lexemes" begin
        for (lexeme, tokentype) in (
            ("(", Knight.LEFT_PAREN),
            (")", Knight.RIGHT_PAREN),
            ("{", Knight.LEFT_BRACE),
            ("}", Knight.RIGHT_BRACE),
            (",", Knight.COMMA),
            (".", Knight.DOT),
            ("-", Knight.MINUS),
            ("+", Knight.PLUS),
            (";", Knight.SEMICOLON),
            ("*", Knight.STAR),
            ("/", Knight.SLASH),
            ("!", Knight.BANG),
            ("!=", Knight.BANG_EQUAL),
            ("=", Knight.EQUAL),
            ("==", Knight.EQUAL_EQUAL),
            ("<", Knight.LESS),
            ("<=", Knight.LESS_EQUAL),
            (">", Knight.GREATER),
            (">=", Knight.GREATER_EQUAL),
        )
            l = Knight.Lexer(lexeme)
            @test Knight.next_token!(l).type == tokentype
        end
    end
end
