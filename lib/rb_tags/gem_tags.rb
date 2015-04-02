class GemTags

  attr_reader :filename, :mask, :format

  def initialize(filename: ".gem_tags")
    @filename = filename
  end

  def traverse_gemfile
    if File.exist? gem_file
      require 'bundler'
      @paths = Bundler.load.specs.map(&:full_gem_path).join(' ')
    end
  end

  def gem_file
    './Gemfile'
  end
end
