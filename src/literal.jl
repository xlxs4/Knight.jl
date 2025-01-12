abstract type AbstractLiteral end

struct NoOpLiteral <: AbstractLiteral end
struct StringLiteral <: AbstractLiteral
    val::String
end

struct FloatLiteral <: AbstractLiteral
    val::Float64
end
