class GemTags

  attr_reader :filename, :mask, :format

  def initialize(filename: ".gem_tags", mask: '*.rb', format: 'vim')
    @filename = filename
    @format   = format
    @mask     = mask
  end

  def generate
    traverse_gemfile
    ctags_expression
  end

  private

  def ctags_expression
    case @format
    when 'emacs'
      `ctags --tag-relative=yes -e -R -f .gemtags #{@paths}`
    when 'json'
      return `ctags --tag-relative=yes -x -R -f .gemtags #{@paths}`
    else
      `ctags --tag-relative=yes -R -f .gemtags #{@paths}`
    end
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
