class Tags
  include GenerateTags
  include YamlTasks

  attr_reader :dir, :tags, :names

  def initialize(dir: Dir.getwd, force: false)
    @dir = check(dir)

    self.delete if force
    self.read
  end

  def tag
    FileUtils.cd(@dir) { |dir| @tags = find_expressions(dir, @mask) }
    save
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
    @tags = read_from_yaml(dir: @dir)
    tag if @tags.nil? || @tags.empty?
  end

  def delete
    tag_file = File.join(@dir,".tags")
    FileUtils.rm(tag_file) if File.exist?(tag_file)
  end

  def names
    @tags.keys
  end

  def check(dir)
    return dir if Dir.exist?(dir)
    FileUtils.mkdir_p(dir)

    dir
  end
end
