# TODO Use scoped values instead of passing `Lexer`s around
# TODO Benchmark with Accessors.jl and immutable struct
mutable struct Lexer
    source::String
    next::Union{Nothing,Tuple{Char,Int}}
end
Lexer(source::String) = Lexer(source, iterate(source))

function read_char(l::Lexer)
    isnothing(l.next) && return nothing
    ch, _ = l.next
    return ch
end

function read_char!(l::Lexer)
    isnothing(l.next) && return nothing
    ch, state = l.next
    l.next = iterate(l.source, state)
    return ch
end

function peek_char(l::Lexer)
    isnothing(l.next) && return nothing
    _, state = l.next
    t = iterate(l.source, state)
    isnothing(t) && return nothing
    ch, _ = t
    return ch
end

function next_token!(l::Lexer)
    skip_whitespace!(l)
    ch = read_char(l)
    if ch == '('
        token = Token(LEFT_PAREN, "(")
    elseif ch == ')'
        token = Token(RIGHT_PAREN, ")")
    elseif ch == '{'
        token = Token(LEFT_BRACE, "{")
    elseif ch == '}'
        token = Token(RIGHT_BRACE, "}")
    elseif ch == ','
        token = Token(COMMA, ",")
    elseif ch == '.'
        token = Token(DOT, ".")
    elseif ch == '-'
        token = Token(MINUS, "-")
    elseif ch == '+'
        token = Token(PLUS, "+")
    elseif ch == ';'
        token = Token(SEMICOLON, ";")
    elseif ch == '*'
        token = Token(STAR, "*")
    elseif ch == '/'
        # TODO: No comment/line tracking support for now
        token = Token(SLASH, "/")
    elseif ch == '!'
        if peek_char(l) == '='
            read_char!(l)
            token = Token(BANG_EQUAL, "!=")
        else
            token = Token(BANG, "!")
        end
    elseif ch == '='
        if peek_char(l) == '='
            read_char!(l)
            token = Token(EQUAL_EQUAL, "==")
        else
            token = Token(EQUAL, "=")
        end
    elseif ch == '<'
        if peek_char(l) == '='
            read_char!(l)
            token = Token(LESS_EQUAL, "<=")
        else
            token = Token(LESS, "<")
        end
    elseif ch == '>'
        if peek_char(l) == '='
            read_char!(l)
            token = Token(GREATER_EQUAL, ">=")
        else
            token = Token(GREATER, ">")
        end
    elseif isnothing(ch)
        token = Token(EOF, "")
    else
        # TODO What will we do with errors?
        token = Token(ILLEGAL, string(ch))
    end
    read_char!(l)
    return token
end

function skip_whitespace!(l::Lexer)
    # TODO What will we do with line tracking?
    is_valid_space(ch) = !isnothing(ch) && isspace(ch)
    while is_valid_space(read_char(l))
        read_char!(l)
    end
    return nothing
end
