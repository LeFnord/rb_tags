class Json

  def self.parse(tags)
    input = Json.new(tags)
    input.to_hash
    return input.hash_step
  end

  attr_accessor :hash_step

  def initialize(tags)
    @tags = tags.split("\n")
    @hash_step = {}
  end

  def to_hash
    @tags.each do |line|
      tag_line = line.split(/\s+/)
      add_to_hash(tag_line)
    end
  end

  def add_to_hash(tag)
    key = tag[0].strip
    if tag[1] == 'singleton'
      hash = { type: tag[1].strip + ' ' + tag[2].strip, line_number: tag[3].strip, file: tag[4].strip }
    else
      hash = { type: tag[1].strip, line_number: tag[2].strip, file: tag[3].strip }
    end
    if @hash_step.key?(key)
      @hash_step[key] << hash
    else
      @hash_step[key] = [hash]
    end

  end

end