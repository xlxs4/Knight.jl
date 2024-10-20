using Knight
using Documenter

DocMeta.setdocmeta!(Knight, :DocTestSetup, :(using Knight); recursive=true)

makedocs(;
    modules=[Knight],
    authors="Orestis Ousoultzoglou <orousoultzoglou@gmail.com>",
    sitename="Knight.jl",
    format=Documenter.HTML(;
        canonical="https://xlxs4.github.io/Knight.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/xlxs4/Knight.jl",
    devbranch="master",
)
