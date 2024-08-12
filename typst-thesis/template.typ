#import "typst-thesis.typ": *

[-IMPORTS-]

#show: template.with(
  frontmatter: (
    title: "[-doc.title-]",
    subtitle: "[-doc.subtitle-]",
    authors: (
      [# for author in doc.authors #] (
        name: "{{ author.name }}",
        [# if author.orcid #]
          orcid: "[-author.orcid-]",
        [# endif #]
        [# if author.email #]
          email: "[-author.email-]",
        [# endif #]
        [# if author.affiliations #]
          affiliations: ([#- for aff in author.affiliations -#]"[-aff.index-]"[#- if not loop.last -#],[#- endif -#][#- endfor -#]),
        [# endif #]
      )
      [# endfor #]
      ),
    affiliations: (
      [# for aff in doc.affiliations #]
          (
            id: "[-aff.index-]",
            name: "[-aff.name-]",
          ),
      [# endfor #]
    ),
    abstract: [
      [-parts.abstract-]
    ],
  ),
  line_spacing: "[-options.line_spacing-]",
  bib: "[-doc.bibtex-]",
  logo: "[-options.logo-]",
)

// This may be moved below the first paragraph to start columns later

[-CONTENT-]
