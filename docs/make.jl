using ComputerVisionMetrics
using Documenter

DocMeta.setdocmeta!(ComputerVisionMetrics, :DocTestSetup, :(using ComputerVisionMetrics); recursive=true)

makedocs(;
    modules=[ComputerVisionMetrics],
    authors="Dale <djblack@uci.edu> and contributors",
    repo="https://github.com/Dale-Black/ComputerVisionMetrics.jl/blob/{commit}{path}#{line}",
    sitename="ComputerVisionMetrics.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Dale-Black.github.io/ComputerVisionMetrics.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Dale-Black/ComputerVisionMetrics.jl",
)
