site_name:        nmr.jl
repo_url:         https://github.com/deyandyankov/nmr
site_description: Naive MapReduce
site_author:      deyandyankov

theme: readthedocs

extra_css:
  - assets/Documenter.css

extra_javascript:
  - https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML
  - assets/mathjaxhelper.js

markdown_extensions:
  - extra
  - tables
  - fenced_code
  - mdx_math

docs_dir: 'build'

pages:
  - Home: index.md
