#import "@preview/tidy:0.4.3"

#import "../other-tools/custom-style.typ"
#import "../template/template-long.typ"
#import "../template/cover.typ"

#let title = "Documentation of the Template"
#let subtitle = "Conventions, functions and attributes"
#let authors-names = "Alexandre Bry"

#show: template-long.init.with(
  title: title,
  subtitle: subtitle,
  authors-names: authors-names,
)
#show: custom-style.custom-style.with(raw-background: none)

#show ref: it => {
  if it.element == none { return it }
  if it.element.func() == box {
    set text(style: "italic")
    show: it => underline(it, stroke: 0.5pt, offset: 1pt)
    let (function-name, argument-name) = str(it.target).slice(1).split(".")
    link(it.target)[#argument-name argument in #function-name]
  } else {
    it
  }
}

#[
  #show: template-long.cover-container
  #cover.cover(title: title, subtitle: subtitle, authors-names: authors-names, date: datetime.today())
]

#[
  #show: template-long.pre-content-container.with(h1-new-page: false)
  #align(center)[
    #v(1fr, weak: true)
    #outline(depth: 2)
    #v(1fr, weak: true)
  ]
]

#[
  #show: template-long.main-content-container.with(
    heading-numbering: ("1.", none, none, none, none, none),
    reset-page-numbering: true,
  )
  #show heading.where(level: 4): set text(style: "italic")


  #let show-module = tidy.show-module.with(
    style: tidy.styles.default,
    first-heading-level: 1,
    sort-functions: none,
  )

  = Template

  The template functions are defined in `template/template.typ`. However, to make it easier to switch between a "long" report and a "short" assignment submission, we created two sub-versions:

  - `template/template-long.typ` for long reports
  - `template/template-short.typ` for short reports

  Both use the same functions but with different default values. Therefore, all the functions mentioned below can be imported from any of these files with the same capabilities, except the default values will be better suited for the type of document you are writing.

  Here are the functions available in `template/template.typ`:

  #import "../template/template.typ"
  #import "../template/cover.typ"
  #import "../template/utils.typ"
  #import "@preview/numbly:0.1.0"

  #let docs = tidy.parse-module(
    read("../template/template.typ"),
    scope: (template: template, cover: cover, utils: utils, numbly: numbly),
    preamble: "#import template: *\n#import cover \n#import utils: _combine-supplement-numbering, _process-heading-attributes\n#import numbly\n",
  )
  #for (i, function) in docs.functions.enumerate() {
    for arg in function.args {
      if arg.at(1).description.starts-with("@") {
        let function-reference-name = arg.at(1).description.slice(1)
        let function-reference-doc = docs.functions.find(t => t.name == function-reference-name)
        let arg-name = arg.at(0)
        let arg-in-generic = arg-name in function-reference-doc.args.keys()
        if arg-in-generic != none {
          let arg-type = function-reference-doc.args.at(arg-name).types
          docs.functions.at(i).args.at(arg-name).insert("types", arg-type)
          let description = (
            "Refer to the #ref(<-generic-container." + arg-name + ">) for more details."
          )
          docs.functions.at(i).args.at(arg-name).description = description
        }
      }
    }
  }
  #show-module(docs)

  = Cover Page

  A simple cover page is defined in `template/cover.typ`. It is a simple function that takes the title, authors, and date as arguments, as well as some optional arguments to customize the layout.

  Here are the functions available in `template/cover.typ`:

  #let docs = tidy.parse-module(
    read("../template/cover.typ"),
    scope: (template: template, cover: cover, utils: utils, numbly: numbly),
    preamble: "#import template: *\n#import cover \n",
  )
  #show-module(docs)

  = Styled Blocks

  `other-tools/styled-blocks.typ` contains a set of functions to add colourful blocks of text to the document. The intended use is to highlight tasks or information useful to the authors in writing the document. Then, the blocks can be hidden or removed when the document is rendered, using the `render` argument like this at the beginning of the file:

  ```typst
  #let block-todo = block-todo.with(render: false)
  ```

  Here are the functions available in `other-tools/styled-blocks.typ`:

  #import "../other-tools/styled-blocks.typ"

  #let docs = tidy.parse-module(
    read("../other-tools/styled-blocks.typ"),
    scope: (styled-blocks: styled-blocks),
    preamble: "#import styled-blocks: *\n",
  )
  #show-module(docs)

  = Custom Style

  `other-tools/custom-style.typ` contains a function to add custom styles to the document. These styles are not directly included in the template because they are not really standard.

  Here are the functions available in `other-tools/custom-style.typ`:

  #import "../other-tools/custom-style.typ"
  #let docs = tidy.parse-module(
    read("../other-tools/custom-style.typ"),
    scope: (custom-style: custom-style),
    preamble: "#import custom-style: *\n",
  )
  #show-module(docs)

]
