class Parser < Parslet::Parser
  #atomic rules
  rule(:space) { match['[:space:]'] }
  rule(:spaces) { space.repeat(1) }
  rule(:word) { match['[:alpha:]'].repeat(1) }
  rule(:line) { match['[:digit:]'].repeat(1) }
  rule(:separator) { str('/') }

  # composing rules
  ## names, word-or_foo
  rule(:name_adds) { match['_-'] >> word.repeat(1) }
  rule(:name) { word.repeat(1) >> name_adds.repeat }

  ## filename, word_or-foo.ext
  rule(:file) { name.repeat(1) >> str('.') >> word.repeat(1) }

  ## part of path, word/
  rule(:path_part) { name.repeat(1) >> separator }
  rule(:path) { separator >> path_part.repeat >> file }

  ## full input
  rule(:whole_line) {
    name.as(:name) >> spaces >>
    (word >> space >> word | word).as(:type) >> spaces >>
    line.as(:line) >> spaces >>
    path.as(:path) >> spaces >>
    any.repeat.as(:definition)
  }


  root(:whole_line)
end

class ParserTransform < Parslet::Transform
  rule(name: simple(:name),
      type: simple(:type),
      line: simple(:line),
      path: simple(:path),
      definition: simple(:definition)
      ) {
        {
          name: name.str,
          type: type.str,
          line: line.str,
          path: path.str,
          definition: definition.str
        }
      }
end
