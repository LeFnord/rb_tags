module GenerateTags
  # find ctags and split in single lines
  def find_expressions(dir,mask)
    found_tags = `find #{dir} | ctags -x -L -`.split("\n")
    parse_expression_line(found_tags).and.generate_hash
  end

  #parse found expression line
  def parse_expression_line(found_tags)
    @tags = []
    found_tags.each do |tag_line|
      begin
        parsed_line = Parser.new.parse(tag_line)
        @tags << ParserTransform.new.apply(parsed_line)
      rescue Parslet::ParseFailed => error
        puts error.cause.ascii_tree
      end
    end

    self
  end

  # converts array of hashes into single hash
  def generate_hash
    @tags.group_by{|x| x[:name]; x.delete(:name) }
  end

  def and
    self
  end
end
