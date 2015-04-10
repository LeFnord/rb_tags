module GenerateTags
  # find ctags and split in single lines
  def find_expressions(dir,mask)
    @found_tags = `find #{dir} | ctags -x -L -`.split("\n")
    parse_expression_line.and.generate_hash
  end

  #parse found expression line
  def parse_expression_line
    @parsed_expressions = []
    @found_tags.each do |tag_line|
      parsed_line = Parser.new.parse(tag_line)
      @parsed_expressions << ParserTransform.new.apply(parsed_line)
    end

    self
  end

  # converts array of hashes into single hash
  def generate_hash
    @parsed_expressions.group_by{|x| x[:name] }
  end

  def and
    self
  end
end
