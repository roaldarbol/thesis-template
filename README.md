# MyST/Typst Thesis Template
A typst template for creating a thesis using MyST Markdown.

## Development
I use [pixi](https://pixi.sh) for managing the environment, so if you don't have pixi installed - do that first.
- clone the repository and `cd` into it
- run `pixi install`, which will install `typst` and `mystmd`.
- run `pixi shell` to open a pixi shell (or prefix your commands with `pixi run`)

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

## Process
To create or edit a template.
To create a template, first create a folder inside the root of your folder. So if we want to create `my-template`, I make a folder called `my-template`.
```
mkdir my-template
cd my-template
```
Inside this folder, you need 3 file:
- my-template.typ
- template.typ
- template.yml
Note that `template.typ` and `template.yml` *need* to be named this way, so don't change them.

Let's start by creating the files, and then fill them out along the way.
```
touch my-template.typ template.typ template.yml
```

### Editing files
Note on `pubmatter`.

#### Adding options
E.g. say I want to add degree. Currently, the workflow is this:
- In `template.yml`, add `degree` under options.
- In `template.typ`, add `degree` after `frontmatter`.
- In `my-template.typ`, add `degree` after `frontmatter`.
- In `my-template.typ`, for use, reference it with `degree`.


### Editing `myst.yml`
All under `project`
Edit `exports`
For local testing, make `template: ../..`

## Testing our template
Create example folders
```
mkdir examples/myst-example examples/typst-example
```

### Test on `typst` content


### Test on `myst` content
```
cd examples/myst-example
```

```
myst build --typst --debug
```