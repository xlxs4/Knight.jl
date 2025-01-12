mutable struct Scanner
    source::String
    tokens::Vector{Token}
    start::Int
    curr::Int
    line::Int
end
Scanner(source) = Scanner(source, Token[], 0, 0, 1)

function scan_tokens!(s::Scanner)
    while (!is_at_end(s))
        s.start = s.curr
        scan_token!(s)
    end
    push!(s.tokens, Token(EOF, "", NoOpLiteral(), s.line))
    return s.tokens
end

is_at_end(s::Scanner) = s.curr >= length(s.source)

function scan_token!(s::Scanner)
    c = advance!(s)
    if c == '('
        add_token!(s, LEFT_PAREN)
    elseif c == ')'
        add_token!(s, RIGHT_PAREN)
    elseif c == '{'
        add_token!(s, LEFT_BRACE)
    elseif c == '}'
        add_token!(s, RIGHT_BRACE)
    elseif c == ','
        add_token!(s, COMMA)
    elseif c == '.'
        add_token!(s, DOT)
    elseif c == '-'
        add_token!(s, MINUS)
    elseif c == '+'
        add_token!(s, PLUS)
    elseif c == ';'
        add_token!(s, SEMICOLON)
    elseif c == '*'
        add_token!(s, STAR)
    elseif c == '!'
        add_token!(s, _match(s, '=') ? BANG_EQUAL : BANG)
    elseif c == '='
        add_token!(s, _match(s, '=') ? EQUAL_EQUAL : EQUAL)
    elseif c == '<'
        add_token!(s, _match(s, '=') ? LESS_EQUAL : LESS)
    elseif c == '>'
        add_token!(s, _match(s, '=') ? GREATER_EQUAL : GREATER)
    elseif c == '/'
        if _match(s, '/')
            while (peek(s) != '\n' && !is_at_end(s))
                advance!(s)
            end
        else
            add_token!(s, SLASH)
        end
    elseif c == ' '
    elseif c == '\r'
    elseif c == '\t'
    elseif c == '\n'
        s.line += 1
    elseif c == '"'
        _string(s)
    else
        if isdigit(c)
            number(s)
        else
            error(s.line, "Unexpected character $(c).")
        end
    end
    return nothing
end

function _string(s::Scanner)
    while (peek(s) != '"' && !is_at_end(s))
        if (peek(s) == '\n')
            s.line += 1
        end
        advance!(s)
    end
    if is_at_end(s)
        error(s.line, "Unterminated string.")
        return nothing
    end
    advance!(s)
    val = s.source[(s.start + 2):(s.curr - 1)]
    add_token!(s, STRING, StringLiteral(val))
    return nothing
end

function number(s::Scanner)
    while isdigit(peek(s))
        advance!(s)
    end
    if (peek(s) == '.' && isdigit(peeknext(s)))
        advance!(s)
        while isdigit(peek(s))
            advance!(s)
        end
    end
    val = s.source[(s.start + 1):s.curr]
    add_token!(s, NUMBER, FloatLiteral(parse(Float64, val)))
    return nothing
end

function peek(s::Scanner)
    is_at_end(s) && return '\0'
    return s.source[s.curr + 1]
end

function peeknext(s::Scanner)
    (s.curr + 1 >= length(s.source)) && return '\0'
    return s.source[s.curr + 2]
end

function _match(s::Scanner, expected)
    is_at_end(s) && return false
    (s.source[s.curr + 1] != expected) && return false
    s.curr += 1
    return true
end

function advance!(s::Scanner)
    s.curr += 1
    return s.source[s.curr]
end

function add_token!(s::Scanner, tokentype)
    add_token!(s, tokentype, NoOpLiteral())
    return nothing
end

function add_token!(s::Scanner, tokentype, literal)
    text = s.source[(s.start + 1):s.curr]
    push!(s.tokens, Token(tokentype, text, literal, s.line))
    return nothing
end
