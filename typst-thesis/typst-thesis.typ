#import "@preview/pubmatter:0.1.0"
#import "@preview/i-figured:0.2.4"

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
  logo: (),
  heading-numbering: "1.1.1",
  // A color for the theme of the document
  line_spacing: (),
  bib: (),
  theme: blue.darken(30%),
  // The thesis' content.
  body
) = {

  // === Load Front Matter === //
  let fm = pubmatter.load(frontmatter)
  let dates;
  if ("date" in fm and type(fm.date) == "datetime") {
    dates = ((title: "Published", date: fm.date),)
  } else {
    dates = date
  }

  // === Set document metadata === //
  set document(
    title: fm.title, 
    author: fm.authors.map(author => author.name)
    )
  set page(
    paper: "a4",
    columns: 1, 
    margin: (left: 4cm, right: 2cm, y: 2.5cm),
  )
  
  set par(
    // justify: true,
    leading: 1.5em,
  )

  // === Document Settings === //
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
  
  // Configure figure numbering
  set figure(numbering: (..args) => {
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [#chapter.#numbering("1", ..args.pos())]
  })

  // Attempt with i-figured
  // show heading: i-figured.reset-counters
  // show figure: i-figured.show-figure 

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



  // --------------------------------------------- //
  // ---------- Document Begins ------------------ //
  // --------------------------------------------- //

  // Title Page
  // Title and subtitle
  // box(inset: (bottom: 2pt), text(17pt, weight: "bold", fill: theme, fm.title))
  // if fm.subtitle != none {
  //   parbreak()
  //   box(text(14pt, fill: gray.darken(30%), fm.subtitle))
  // }
  align(center + horizon)[#box(width: 200%, image(logo))]

  // In here needs to go all the front matter pages

  // Table of Content
  pagebreak()
  show outline.entry.where(level: 1): (it) => {
    v(12pt, weak: true)
    strong(it)
  }
  outline(indent: auto)

  // show heading: i-figured.reset-counters
  // show figure: i-figured.show-figure
  // pagebreak()
  // i-figured.outline()

  // List of Figures
  pagebreak()
  outline(target: figure.where(kind: "figure"), title: "List of Figures")

  // // List of Tables
  pagebreak()
  outline(target: figure.where(kind: table), title: "List of Tables")

  // Configure chapter headings
  show heading.where(level: 1): (it) => {
    pagebreak()
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    if it.body != [References] {
      if chapter > 1 [
        #place(
          top + right,
          box(height: 40%,
            text(
              300pt, 
              fill: gray.lighten(30%), 
              str(chapter)))
        )
        #box(height: 35%)
      ]
    }
    it.body
  }

  // Display the book's contents.
  body

    // Bibliography
  if bib != none {
    heading(
      level: 1,
      numbering: none,
      "References"
    )
  
    show bibliography: set text(size: 0.9em)
    set bibliography(title: none)
    bibliography(bib, style: "frontiers")
  }
}