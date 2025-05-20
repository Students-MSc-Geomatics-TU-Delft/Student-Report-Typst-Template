#import "../../template/template-long.typ": (
  init,
  cover-container,
  pre-content-container,
  main-content-container,
  post-content-container,
  appendix-container,
)
#import "../../template/cover.typ"

#import "../../other-tools/custom-style.typ"

/* -------------------------------------------------------------------------- */
/*                 Define some parameters used multiple times                 */
/* -------------------------------------------------------------------------- */

/* ---------------------------- Document settings --------------------------- */
#let title = "The Art of Emptiness - A Journey into the Void"
#let authors-names = ("Author 1", "Author 2", "Author 3")
#let authors-data = (
  "Student IDs": ("1234567", "9876543", "7654321"),
  "Email": (
    "lorem.ipsum@email.com",
    "dolor.sit@email.com",
    "amet.consectetur@email.com",
  ),
)

/* -------------------------------------------------------------------------- */
/*                           Actual document content                          */
/* -------------------------------------------------------------------------- */

#show: init.with(
  title: title,
  authors-names: authors-names,
  authors-data: authors-data,
  // text-font: ("Source Serif 4", "Libertinus Serif"),
  // math-font: ("STIX Two Math", "New Computer Modern Math"),
)

#show: custom-style.custom-style

/* ------------------------------- Cover page ------------------------------- */

#[
  #show: cover-container.with(full-page: true)
  #cover.cover(
    title: title,
    authors-names: authors-names,
    authors-data: authors-data,
    full-page: true,
    alignment: center,
    date: datetime.today(),
  )
]

/* ---------------------- Parts before the main content --------------------- */

#[
  #show: pre-content-container.with()
  #include "../content/preface.typ"
  #include "../content/abstract.typ"
  #include "../content/table-of-contents.typ"
]

/* ------------------------------ Main content ------------------------------ */

#[
  #show: main-content-container.with()
  #include "../content/content.typ"
]

/* ---------------------- Parts after the main content ---------------------- */

#[
  #show: post-content-container.with()
  #include "../content/bibliography.typ"
]

/* ------------------------------- Appendices ------------------------------- */

#[
  #show: appendix-container.with()
  #include "appendix.typ"
]
