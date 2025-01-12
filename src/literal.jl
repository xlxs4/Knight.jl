abstract type AbstractLiteral end

struct NoOpLiteral <: AbstractLiteral end
struct StringLiteral <: AbstractLiteral
    val::String
end
