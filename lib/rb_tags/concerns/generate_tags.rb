# frozen_string_literal: true
module GenerateTags
  # find ctags and split in single lines
  #  dir - the gem directory
  #  mask - source file type, defaults to ruby
  def find_expressions(dir, _mask)
    found_tags = `find #{dir} -name '*.rb' | ctags -x -L -`.split("\n")
    parse_expression_line(found_tags)
    generate_hash
  end

  # parse found expression line
  #  found_tags - the tags found by ctags
  def parse_expression_line(found_tags)
    @tags = []
    found_tags.each do |tag_line|
      begin
        parsed_line = Parser.new.parse(tag_line)
        @tags << ParserTransform.new.apply(parsed_line)
      rescue Parslet::ParseFailed => error
        message = ['[RbTags] Error: ', 'line: ', "#{tag_line} ", 'error: ', error.cause.ascii_tree.to_s]
        message.each { |m| $stdout.puts m.to_s }
        @tags << message.join("\n")
      end
    end

    @tags
  end

  # converts array of hashes into single hash
  def generate_hash
    @tags.group_by do |x|
      x[:name]
      x.delete(:name)
    end
  end
end
