#import "@preview/pubmatter:0.1.0"

#let leftCaption(it) = {
  set text(size: 8pt)
  set align(left)
  set par(justify: true)
  text(weight: "bold")[#it.supplement #it.counter.display(it.numbering)]
  "."
  h(4pt)
  set text(fill: black.lighten(20%), style: "italic")
  it.body
}

#let template(
  frontmatter: (),
  heading-numbering: "1.1.1",
  // A color for the theme of the document
  theme: blue.darken(30%),
  // The thesis' content.
  body
) = {

  // Load Front Matter
  let fm = pubmatter.load(frontmatter)
  let dates;
  if ("date" in fm and type(fm.date) == "datetime") {
    dates = ((title: "Published", date: fm.date),)
  // } else if (type(date) == "dictionary") {
  //   dates = (date,)
  } else {
    dates = date
  }

  // Set document metadata.
  set document(title: fm.title, author: fm.authors.map(author => author.name))

  // Headings
  set heading(numbering: (..args) => {
    let nums = args.pos()
    let level = nums.len()
    if level == 1 {
      // Reset the numbering on figures
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      [#numbering("1.", ..nums)]
    } else {
      [#numbering("1.1.1", ..nums)]
    }
  })


  set figure(numbering: (..args) => {
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [#chapter.#numbering("1", ..args.pos())]
  })

  // Configure equation numbering and spacing.
  set math.equation(numbering: (..args) => {
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [(#chapter.#numbering("1)", ..args.pos())]
  })
  show math.equation: set block(spacing: 1em)
  show figure.caption: leftCaption
  set figure(placement: auto)

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)


  // Title and subtitle
  box(inset: (bottom: 2pt), text(17pt, weight: "bold", fill: theme, fm.title))
  if fm.subtitle != none {
    parbreak()
    box(text(14pt, fill: gray.darken(30%), fm.subtitle))
  }

  // Outline of book
  pagebreak()
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  outline(indent: auto)

  
  show heading.where(level: 1): (it) => {
    pagebreak()
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [Chapter #chapter]
    it
  }

  // Display the book's contents.
  body
}