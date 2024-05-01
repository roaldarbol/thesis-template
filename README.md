# MyST/Typst Thesis Template
A typst template for creating a thesis using MyST Markdown.

## Development
I use [pixi](https://pixi.sh) for managing the environment, so if you don't have pixi installed - do that first.
- clone the repository and `cd` into it
- run `pixi install`, which will install `typst` and `mystmd`.
- run `pixi shell` to open a pixi shell (or prefix your commands with `pixi run`)
  /Users/roaldarbol/Filen/Thesis/typst-thesis.md
### Typst
To render the `typst` example, run:
```sh
typst compile examples/example-typst/main.typ --root ../..
```
or simply
```
pixi run render-typst
```

### MyST
To render the `myst` example, run:
```
myst build --typst
```
or simply
```
pixi run render-myst
```
