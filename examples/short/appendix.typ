= Actual Typst Content <appendix-content>

Several sections of the document are displayed here:

- @appendix-main-file show the main file of the document, which puts everything together,
- @appendix-main-content shows the main content of the document,
- @appendix-appendix-content shows the appendices.

== Main File <appendix-main-file>

#[
  #show figure: set block(breakable: true)
  #figure(
    raw(
      read("main.typ"),
      lang: "typst",
      block: true,
    ),
    caption: [The main file of the document.],
  ) <code-main-file>
]

== Main Content <appendix-main-content>

In @code-content below is displayed the actual Typst content of the document.

#[
  #show figure: set block(breakable: true)
  #figure(
    raw(
      read("../content/content.typ"),
      lang: "typst",
      block: true,
    ),
    caption: [The content of the document.],
  ) <code-content>
]

== Appendix Content <appendix-appendix-content>

#[
  #show figure: set block(breakable: true)
  #figure(
    raw(
      read("appendix.typ"),
      lang: "typst",
      block: true,
    ),
    caption: [The content of the appendix.],
  ) <code-appendix>
]

= Another Appendix

== A Subsection

Something written.

== Another Subsection

Something else written.

= Again Another Appendix

== Again A Subsection

Something written.

== Another Subsection Again

Something else written.
