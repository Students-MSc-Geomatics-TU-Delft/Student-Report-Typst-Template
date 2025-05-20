/// Combine the supplement and numbering of a heading into a single element.
///
/// -> str | content | none
#let _combine-supplement-numbering(
  /// The supplement to be added to the numbering.
  ///
  /// -> str | content | none
  supplement: none,
  /// The numbering of the heading.
  ///
  /// -> str | content | none
  numbering-value: none,
) = {
  if supplement == none or supplement == [] {
    return numbering-value
  }
  if numbering-value == none {
    return supplement
  }
  return supplement + " " + numbering-value
}

/// Process the attributes to style all heading levels to get an array of 6 attributes.
///
/// -> array
#let _process-heading-attributes(
  /// The attributes to be applied to the heading levels.
  /// The possible types are the ones specified in the `possible-types` argument.
  ///
  /// -> any
  attributes: none,
  /// The name of the attribute to be used in the error message.
  ///
  /// -> str
  attribute-name: "",
  /// The possible types of the attributes.
  ///
  /// -> array
  possible-types: (none, str, function),
) = {
  let panic-msg = (
    attribute-name
      + " must be "
      + possible-types.map(t => if t == none { "none" } else { "a " + str(t) }).join(", ")
      + " or an array containing 6 of them"
  )
  let real-attributes = if attributes == none {
    (none,) * 6
  } else if type(attributes) in (str, function) {
    (attributes,) * 6
  } else if type(attributes) == array {
    if attributes.len() != 6 {
      panic(panic-msg)
    } else if not attributes.all(it => type(it) in (str, function) or it == none) {
      panic(panic-msg)
    } else {
      attributes
    }
  }
  real-attributes
}
