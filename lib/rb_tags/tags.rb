class Tags
  include GenerateTags
  attr_reader :dir, :filename, :mask, :format
  attr_reader :tags

  def initialize(dir: FileUtils.pwd, filename: ".tags", mask: '*.rb', format: 'vim')
    @dir      = dir
    @filename = filename
    @format   = format
    @mask     = mask
  end

  def tag
    FileUtils.cd(@dir) { |dir| @tags = find_expressions(dir, @mask) }
  end
end
