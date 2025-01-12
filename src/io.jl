const HAD_ERROR = Ref{Bool}(false)

function runfile(path)
    source = read(path, String)
    run(source)
    HAD_ERROR[] && exit(65)
    return nothing
end

function runprompt()
    while true
        print("> ")
        line = readline()
        isempty(line) && break
        run(line)
        HAD_ERROR[] = false
    end
    return nothing
end

function run(source)
    s = Scanner(source)
    scan_tokens!(s)
    @show s.tokens
    return nothing
end

error(line, msg) = report(line, "", msg)
function report(line, _where, msg)
    @error "[line $(line)] Error $(_where) : $(msg)"
    HAD_ERROR[] = true
    return nothing
end
