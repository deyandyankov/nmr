using Documenter
using nmr

makedocs(
    modules = [nmr],
    doctest = false
)

deploydocs(
    deps = Deps.pip("pygments", "mkdocs", "mkdocs-material", "python-markdown-math"),
    repo = "github.com/deyandyankov/nmr.git",
    julia = "release"
)
