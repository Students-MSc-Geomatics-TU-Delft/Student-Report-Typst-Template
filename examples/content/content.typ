#import "../../other-tools/styled-blocks.typ": block-discussion, block-todo, styled-block
#import "@preview/subpar:0.2.1"

// // Uncomment the following line to hide the comments in the final document
// #let block-todo = block-todo.with(render: false)
// #let block-discussion = block-discussion.with(render: false)

= Typst Functionalities <typst-functionalities>

== Headings <headings>

#for i in range(3, 7) {
  [#heading("Title of a level " + str(i) + " heading", level: i) #label("level-" + str(i))]
}

== Figures

To learn about figures, you can refer to the #link("https://typst.app/docs/reference/model/figure/")[Typst documentation].

=== Tables

A nice table is shown below in @table-operating-systems.

#figure(
  table(
    columns: 3,
    table.header([], [Windows 11], [Ubuntu 24.04.2 LTS]),
    [Quality], [Bad], [Good],
    [Accessibility], [Good], [OK],
    [Performance], [OK], [Good],
  ),
  caption: [#strike()[Very objective] comparisons of operating systems.],
) <table-operating-systems>

=== Figures

You can refer to figures like @figure-art-subjective but also to sub-figures like @figure-piece-of-art.

#subpar.grid(
  columns: 3,
  figure(
    rect(
      height: 10%,
      width: 50%,
    ),
    caption: [A piece of art.],
  ),
  <figure-piece-of-art>,
  figure(
    rect(
      height: 20%,
      width: 20%,
    ),
    caption: [Emptiness is a form of art.],
  ),

  figure(
    rect(
      height: 8%,
      width: 80%,
    ),
    caption: [A very nice piece of art.],
  ),

  caption: [Art is subjective.],
  label: <figure-art-subjective>,
)

== Math

To learn about math, you can refer to the #link("https://typst.app/docs/reference/math/")[Typst documentation].

A famous equation is shown below.

$ sum_(k=1)^n k = (n(n+1)) / 2 $

You can also refer to equations like @equation-pythagorean-theorem.

$ a^2 + b^2 = c^2 $ <equation-pythagorean-theorem>

== References <references>

#let handle-missing-reference(references) = context {
  let working-refs = ()
  for potential-ref in references {
    if query(potential-ref).len() != 0 {
      working-refs.push(ref(potential-ref))
    }
  }
  working-refs.join(", ", last: " and ")
}
#let example-references = (
  <abstract>,
  <table-of-contents>,
  <comments>,
  <bibliography>,
  <appendix-content>,
)

#let formatted-references = handle-missing-reference(example-references)

We are in @typst-functionalities and in @references. It is possible to refer to any heading in the document, such as: #formatted-references. However it might not be the best idea to refer to unnumbered headings. You can see what happens with the different levels of headings for example:

#list(..([@typst-functionalities], [@headings]) + range(3, 7).map(it => ref(label("level-" + str(it)))))

== Comments <comments>

Typst doesn't really support comments, so we created styled blocks to add comments to the document. You can use them to add TODOs or discussions, but you can also create your own styled blocks.

#block-todo[Don't forget][Something to do.]
#block-discussion[Talk to people][A discussion about something.]

When you want to render the final document, you can either remove them or hide them by putting the following snippet at the top of the document:

```typst
#let block-todo = block-todo.with(render: false)
#let block-discussion = block-discussion.with(render: false)
```

= Using this Template

#block-todo[Explain how to use the template][
  Talk about:

  - The theoretical organisation in different parts
  - The practical organisation in different files
  - The short and long versions
]

= Other Typst Templates

This template was inspired from #cite(<ledoux_typst_template>, form: "prose") who made a Typst template for the theses of Geomatics students at TU Delft, and from #cite(<versatile_apa_typst_template>, form: "prose") who made a Typst template for the APA style. If you want a fully APA-compliant template, you should use @versatile_apa_typst_template.
