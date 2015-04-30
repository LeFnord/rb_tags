class Tags
  include GenerateTags
  include YamlTasks

  attr_reader :dir, :tags, :names

  def initialize(dir = Dir.getwd, read = false)
    @dir = dir
    self.read if read
  end

  def tag
    FileUtils.cd(@dir) { |dir| @tags = find_expressions(dir, @mask) }
  end

  def add(tags)
    tags.each do |key,value|
      if self.tags.key?(key)
        self.tags[key] += value
      else
        self.tags[key] = value
      end
    end
  end

  def save
    write_to_yaml(dir: @dir, this: @tags)
  end

  def read
    @tags = read_from_yaml_file(dir: @dir)
  end

  def names
    @names ||= self.tags.keys
  end
end
