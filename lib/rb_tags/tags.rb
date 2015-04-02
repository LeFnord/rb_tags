class Tags
  include GenerateTags
  include YamlTasks

  attr_reader :dir, :filename, :save, :read
  attr_reader :tags

  def initialize(dir: Dir.getwd, save: false, read: false, filename: ".tags")
    @dir, @save, @read, @filename = dir, save, read, filename
    @tags = read_from_yaml_file if @read
  end

  def tag
    FileUtils.cd(@dir) { |dir| @tags = find_expressions(dir, @mask) }
    write_to_yaml(this: @tags) if @save
  end
end
