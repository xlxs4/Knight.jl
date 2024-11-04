using Knight

function main(ARGS)
    nargs = length(ARGS)
    if nargs > 1
        @error "Usage: knight.jl [script]"
        exit(64)
    elseif nargs == 1
        Knight.runfile(ARGS[1])
    else
        Knight.runprompt()
    end
    exit(0)
end
@main
