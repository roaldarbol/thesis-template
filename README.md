# Thesis Template
A typst template for creating a thesis using MyST Markdown.

![](thumbnail.png)

## Development
I use [pixi][https://pixi.sh] for managing the environment, so if you don't have pixi installed - do that first.
- clone the repository
- run `pixi install`, which will install `typst` and `mystmd`.

To render the example, run:
```sh
typst compile examples/example-typst/main.typ --root ../..
```
