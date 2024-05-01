#import "typst-thesis.typ": *

[-IMPORTS-]

#show: template.with(
  frontmatter: (
    title: "[-doc.title-]",
    abstract: [
      [-parts.abstract-]
    ]
  ),
)

// This may be moved below the first paragraph to start columns later
#set page(columns: 1, margin: (x: 1.5cm, y: 2cm),)

[-CONTENT-]

[# if doc.bibtex #]
#bibliography("[-doc.bibtex-]", title: text(10pt, "References"), style: "ieee")
[# endif #]
