require 'awesome_print'
require 'yaml'
require 'parslet'
require 'parslet/convenience'

require 'rb_tags/version.rb'

require 'rb_tags/concerns/generate_tags'
require 'rb_tags/concerns/parser'
require 'rb_tags/concerns/yaml_tasks'

require 'rb_tags/tags'

module RbTags
  def generate(options={})
    set_options(options)

    tags = Tags.new(default_dir)
    tags.tag

    if @options[:gems]
      build_gem_list.each do |dir|
        gem_tags = Tags.new(dir)
        gem_tags.tag
        tags.add(gem_tags.tags)
      end
    end

    tags.save
  end

  def show
    get_existend_tags
    ap @tags.names
    ap @tags.tags.length
  end

  # attributes
  def options
    @options
  end

  def gem_list
    @gem_list
  end

  private
  def build_gem_list
    if File.exist? gem_file
      @gem_list = Bundler.load.specs.map(&:full_gem_path) - [default_dir]
    end
  end

  def gem_file
    File.join(default_dir, './Gemfile')
  end

  def set_options(options)
    @options = options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    @options.delete(:dir) if @options[:dir].nil?
    @options.merge!(defaults) { |key, opt, default| opt }
  end

  def defaults
    { gems: true }
  end

  def default_dir
    Dir.getwd
  end

  def get_existend_tags
    @tags ||= Tags.new
    @tags.read
  end
end
