function runfile(path)
    source = read(path, String)
    run(source)
    return nothing
end

function runprompt()
    while true
        print("> ")
        line = readline()
        isempty(line) && break
        run(line)
    end
    return nothing
end

function run(source)
    println(source)
    return nothing
end
