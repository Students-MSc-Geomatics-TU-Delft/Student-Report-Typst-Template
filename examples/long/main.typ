#import "../../template/template-long.typ": (
  appendix-container, cover-container, init, main-content-container, post-content-container, pre-content-container,
)
#import "../../template/cover.typ" as cover

#import "../../other-tools/custom-style.typ"

/* -------------------------------------------------------------------------- */
/*                 Define some parameters used multiple times                 */
/* -------------------------------------------------------------------------- */

/* ---------------------------- Document settings --------------------------- */
#let title = "The Art of Emptiness"
#let subtitle = "A Journey into the Void"
#let authors-names = ("Lorem Ipsum", "Dolor Sit", "Amet Consectetur")
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
  subtitle: subtitle,
  authors-names: authors-names,
  authors-data: authors-data,
  text-font: ("Source Serif 4", "Libertinus Serif"),
  // math-font: ("STIX Two Math", "New Computer Modern Math"),
)

/* -------------------------------------------------------------------------- */
/*                      Custom styling for this document                      */
/* -------------------------------------------------------------------------- */

#show: custom-style.custom-style

/* ------------------------------- Cover page ------------------------------- */

#[
  #show: cover-container.with(full-page: true)
  ///// Cover
  #set page(background: image("../images/Cover-image-2.jpg", width: 100%, height: 100%), margin: 1em)
  // Title
  #let title-content = cover.cover-group(
    contents: (
      cover.cover-text-block(
        cover.cover-group(
          contents: (
            // Title
            text(title, size: 46pt, weight: 400, fill: white),
            // Subtitle
            text(subtitle, size: 34pt, weight: 300, style: "italic", fill: white),
            // Authors
            text(
              cover.authors-grid(
                alignment: left,
                authors-data: (:),
                authors-names: authors-names,
                row-gutter: 0.9em,
                header: false,
              ),
              size: 20pt,
              fill: white,
            ),
          ),
          spaces: (1em, 2em, 4em, 1em),
          dir: "v",
          individual-alignments: (left, left, left),
          general-alignment: left,
          perpendicular-space: auto,
        ),
        alignment: left,
        background-color: luma(20%, 70%),
        // background-top-space: 3em,
        // background-bottom-space: 2em,
        // background-left-space: 5em,
        // background-right-space: 20em,
      ),
    ),
    spaces: (2em, 10em),
    dir: "h",
    individual-alignments: (right,),
    general-alignment: left,
  )
  // Logos
  #let logos-content = cover.cover-image-block(
    cover.cover-group(
      contents: (
        image("../images/TU_Delft_Logos/TUDelft_logo_white-cropped.svg", height: 2.5cm),
        image("../images/Typst.svg", height: 1.5cm),
      ),
      spaces: (2em, 2fr, 2em),
      dir: "h",
      individual-alignments: (left + bottom, right + bottom),
      general-alignment: center,
    ),
  )
  #cover.cover-group(
    contents: (title-content, logos-content),
    spaces: (8em, 1fr, 1em),
    dir: "v",
    individual-alignments: (left, center),
  )

  ///// Back of the cover
  #set page(background: none, margin: auto)
  #cover.cover(
    full-page: true,
    title: title,
    subtitle: subtitle,
    authors-names: authors-names,
    authors-data: authors-data,
    logos: (
      image("../images/TU_Delft_Logos/TUDelft_logo_cmyk-cropped.svg", height: 2cm),
      image("../images/Typst.svg", height: 1cm),
    ),
    date: datetime.today(),
    other-content: text(
      [Template: #link("https://github.com/Students-MSc-Geomatics-TU-Delft/Student-Report-Typst-Template")[Student Report Typst Template] by Alexandre Bry],
      size: 14pt,
      style: "italic",
    ),
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
