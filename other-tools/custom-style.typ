/// Define a custom style for figures, tables, and raw blocks.
/// This function allows you to customize the appearance of figures, tables, and raw blocks in your document.
///
/// -> body
#let custom-style(
  /// The body of the document
  ///
  /// -> content
  body,
  /// Whether to use custom figure captions.
  ///
  /// -> bool
  custom-figure-captions: true,
  /// Whether to use custom tables.
  ///
  /// -> bool
  custom-tables: true,
  /// The background colour for raw blocks.
  /// Set to `none` to disable the custom styling for raw blocks.
  ///
  /// -> color
  raw-background: luma(220, 60%),
) = {
  /* --------------------------------- Figures -------------------------------- */
  // Set caption text to italic
  show figure.caption: set text(style: "italic") if custom-figure-captions
  // Set caption position to top for tables and raw figures
  show selector.or(
    figure.where(kind: table),
    figure.where(kind: raw),
  ): set figure.caption(position: top) if custom-figure-captions

  /* ---------------------------------- Table --------------------------------- */
  // Set tables style
  set table(
    stroke: (x, y) => (
      top: if y <= 1 { 1pt } else { 0.4pt },
      bottom: 1pt,
    ),
    inset: 6pt,
    align: center + horizon,
  ) if custom-tables
  show table.cell.where(y: 0): set text(weight: "bold") if custom-tables

  /* ------------------------------- Raw blocks ------------------------------- */
  // Set the background colour of raw elements
  show: body => {
    if raw-background != none {
      body = {
        show raw.where(block: false): box.with(
          fill: raw-background,
          inset: (x: 3pt, y: 0pt),
          outset: (y: 3pt),
          radius: 2pt,
        )
        show raw.where(block: true): block.with(
          fill: raw-background,
          width: 100%,
          inset: 10pt,
          radius: 4pt,
          breakable: true,
        )
        body
      }
    }
    body
  }

  // DO NOT REMOVE THIS LINE
  body
}
