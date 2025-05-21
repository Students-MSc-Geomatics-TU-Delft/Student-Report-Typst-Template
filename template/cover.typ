#import "utils.typ": format-authors-data

#let reshape-authors-data(
  authors-data: (:),
  authors-names: (),
) = {
  let authors-len = authors-names.len()
  for key in authors-data.keys() {
    if authors-data.at(key).len() != authors-len {
      panic("The length of the data for each author must match the number of authors.")
    }
  }
  let data = ()
  for i in range(authors-names.len()) {
    let author-name = authors-names.at(i)
    let author-data = authors-data.values().map(t => t.at(i))
    data.push((author-name, ..author-data))
  }
  data
}

#let author-column(
  author-data-reshaped,
  row-gutter: 0.5em,
) = {
  grid(
    columns: 1,
    align: center,
    row-gutter: row-gutter,
    strong(author-data-reshaped.at(0)),
    ..author-data-reshaped.slice(1),
  )
}

#let authors-centered(
  authors-names: (),
  authors-data: (:),
  row-gutter: 0.5em,
) = {
  let authors-data-reshaped = reshape-authors-data(
    authors-data: authors-data,
    authors-names: authors-names,
  )

  let authors-len = authors-names.len()
  if authors-len == 0 {
    return
  }

  let cols = calc.min(2, authors-len)
  let rows = calc.ceil(authors-len / cols)
  let final-row-cols = calc.rem-euclid(authors-len, cols)
  if final-row-cols == 0 { final-row-cols = cols }
  let actual-cols = calc.lcm(cols, final-row-cols)
  let grid-content = ()

  // Create the cells of the grid (except the last row).
  let colspan = calc.div-euclid(actual-cols, cols)
  for row in range(0, rows - 1) {
    for col in range(0, cols) {
      let index = row * cols + col
      grid-content.push(
        grid.cell(
          colspan: colspan,
          author-column(authors-data-reshaped.at(index)),
        ),
      )
    }
  }
  // Create the last row of the grid.
  let colspan = calc.div-euclid(actual-cols, final-row-cols)
  let row = rows - 1
  for col in range(0, final-row-cols) {
    let index = row * cols + col
    grid-content.push(
      grid.cell(
        colspan: colspan,
        author-column(authors-data-reshaped.at(index)),
      ),
    )
  }

  grid(
    columns: (1fr,) * actual-cols,
    align: center,
    row-gutter: row-gutter,
    ..grid-content,
  )
}

#let authors-grid(
  authors-names: (),
  authors-data: (:),
  alignment: left,
  row-gutter: 0.5em,
  column-gutter: 1em,
) = {
  let authors-data-reshaped = reshape-authors-data(
    authors-data: authors-data,
    authors-names: authors-names,
  )
  let headers = ("Name", ..authors-data.keys())
  let columns = authors-data.len() + 1
  grid(
    columns: columns,
    align: alignment,
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    grid.header(..headers.map(t => strong(t))),
    ..authors-data-reshaped.flatten().map(t => [#t])
  )
}

/// Cover page template.
/// Supports full page and non-full page formats.
/// There are two versions of the cover page depending on the desired alignment.
///
/// ```example
/// >>> #show: it => { block(width: 16cm, height: 23cm)[#it] }
/// >>> #show: init.with(_documentation: true)
/// #[
///   #show: cover-container.with(_documentation: true)
///   #for alignment in (left, center, right) {
///     cover.cover(
///       title: "Title of the Document",
///       authors-names: ("Lorem Ipsum", "Dolor Sit", "Amet Consectetur"),
///       authors-data: (
///         "Student IDs": ("1234567", "9876543", "7654321"),
///         "Email": (
///           "lorem.ipsum@email.com",
///           "dolor.sit@email.com",
///           "amet.consectetur@email.com",
///         ),
///       ),
///       full-page: false,
///       alignment: alignment,
///       date: datetime.today(),
///       _documentation: true,
///     )
///     v(2cm, weak: true)
///   }
/// ]
/// ```
///
/// -> content
#let cover(
  /// The title of the document.
  ///
  /// -> str | content
  title: "",
  /// The names of the authors.
  ///
  /// -> str | array
  authors-names: (),
  /// The data of the authors. Can contain any number for (key, value) pairs.
  /// The key is a string and the value is an array of strings.
  /// The key is used as a label for the piece of information and the values correspond to the authors.
  ///
  /// -> dictionary
  authors-data: (:),
  /// The date to be displayed on the cover page.
  /// If not provided, the current date is used.
  ///
  /// -> datetime
  date: datetime.today(),
  /// Whether to use the full page format or not.
  /// This only changes the vertical layout of the content.
  ///
  /// -> bool
  full-page: true,
  /// The alignment of the content on the page.
  /// Can be left, center, right, start, or end.
  ///
  /// -> alignment
  alignment: left,
  /// Special argument for the documentation.
  ///
  /// -> bool
  _documentation: false,
) = {
  if not alignment in (left, center, right, start, end) {
    panic("Invalid alignment value. Use left, center, or right.")
  }
  let formatted-authors = format-authors-data(
    authors-data: authors-data,
    authors-names: authors-names,
  )
  authors-names = formatted-authors.authors-names
  authors-data = formatted-authors.authors-data
  let authors-display = if alignment == center {
    authors-centered(
      authors-names: authors-names,
      authors-data: authors-data,
      row-gutter: 1.5em,
    )
  } else {
    authors-grid(
      authors-names: authors-names,
      authors-data: authors-data,
      alignment: alignment,
      row-gutter: 1em,
    )
  }
  if full-page {
    set page(
      numbering: none,
      header: none,
      footer: none,
    ) if not _documentation
    align(alignment + horizon)[
      #v(1fr, weak: true)
      // Title
      #text(24pt, weight: 700, title)
      #v(4em, weak: true)
      // Authors
      #text(14pt)[#authors-display]
      #v(1fr, weak: true)
      // Date
      #let date-format = "[day padding:none] [month repr:long] [year]"
      #text(12pt, [#date.display(date-format)])
    ]
    if not _documentation { pagebreak(weak: true) }
  } else {
    align(alignment)[
      // Title
      #text(18pt, weight: 700, title)
      #v(3em, weak: true)
      // Date
      #let date-format = "[day padding:none] [month repr:long] [year]"
      #date.display(date-format)
      #v(1.5em, weak: true)
      // Authors
      #authors-display
      #v(2em, weak: true)
    ]
    let line-space = 10%
    line(length: 100% - 2 * line-space, start: (line-space, 0em))
    v(2em, weak: true)
  }
}
