@enum TokenType begin
    # Single-character tokens
    LEFT_PAREN
    RIGHT_PAREN
    LEFT_BRACE
    RIGHT_BRACE

    COMMA
    DOT
    MINUS
    PLUS
    SEMICOLON
    SLASH
    STAR

    # One or two character tokens
    BANG
    BANG_EQUAL
    EQUAL
    EQUAL_EQUAL
    GREATER
    GREATER_EQUAL
    LESS
    LESS_EQUAL

    # Literals
    IDENTIFIER
    STRING
    NUMBER

    # Keywords
    AND
    CLASS
    ELSE
    FALSE
    FUN
    FOR
    IF
    NIL
    OR
    PRINT
    RETURN
    SUPER
    THIS
    TRUE
    VAR
    WHILE

    EOF
    ILLEGAL
end

struct Token{L <: AbstractLiteral}
    type::TokenType
    lexeme::String
    literal::L
    line::Int
end

function Base.show(io::IO, t::Token)
    println(io, "$(t.type): `$(t.lexeme)` $(t.literal)")
    return nothing
end
