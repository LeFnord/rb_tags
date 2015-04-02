module GenerateTags
  # find ctags and split in single lines
  def find_expressions(dir,mask)
    @found_tags = `find #{dir} | ctags -x -L -`.split("\n")
    parse_expression_line.and.generate_hash
  end

  #parse found expression line
  def parse_expression_line
    @parsed_expression = []
    @found_tags.each do |tag_line|
      parsed_line = Parser.new.parse(tag_line)
      @parsed_expression << ParserTransform.new.apply(parsed_line)
    end

    self
  end

  # convert array of hashes into single hash
  def generate_hash
    tags = {}
    @parsed_expression.each do |expression|
      key   = expression.keys.first
      value = expression.values.last
      if tags.key?(key)
        tags[key] << value
      else
        tags[key] = [value]
      end
    end

    tags
  end

  def and
    self
  end
end