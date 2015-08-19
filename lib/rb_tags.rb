# external requirements
require 'bundler'
require 'awesome_print'
require 'yaml'
require 'readline'
require 'parallel'
require 'parslet'
require 'parslet/convenience'
require 'colorize'
require 'yaml/store'

# internal requirements
require 'rb_tags/version.rb'

require 'rb_tags/concerns/sys_info'
require 'rb_tags/concerns/generate_tags'
require 'rb_tags/concerns/parser'
require 'rb_tags/concerns/yaml_tasks'
require 'rb_tags/concerns/completion'

require 'rb_tags/tags'

module RbTags
  include SysInfo
  include Completion

  #
  # create or update tag list
  #

  def generate(options={})
    default_options(options)

    tags = Tags.new(@options[:dir])
    tags.tag
    if @options[:gems]
      result = tag_bundled_gems
      result.each { |g| tags.add(g.tags) }
    end

    tags.save
  end

  def tag_bundled_gems
    gem_list = build_gem_list
    results = ::Parallel.map(gem_list.each_slice(number_of_processors),
                             in_processes: number_of_processors) do |dir_list|
      gem_list = Tags.new(dir_list.shift)
      gem_list.tag

      dir_list.each do |dir|
        gem_tags = Tags.new(dir, read: false)
        unless !!gem_tags.tags
          gem_tags.tag
          gem_tags.save
          say_tagging(gem_tags.dir)
        end
        gem_list.add(gem_tags.tags)
      end

      gem_list
    end

    results
  end

  def say_tagging(dir)
    $stdout.print "tag gem: ".blue
    $stdout.print "#{dir}".colorize(:yellow_light)
    $stdout.print " first time\n".blue
  end

  #
  # using tag list
  #

  # get list of all names of methods/classes/modules
  def tags
    @tags ||= Tags.new(read: true)
    @tags.names
  end

  # get a tag name via readline
  def complete_tag
    arg = complete(tags).first
    found(arg)
  end

  # get all occurences of given tag name
  def found(tag_name)
    @found = @tags.tags[tag_name]
  end

  def open(what = 0)
    if what !~ /\d+/
      message = "\n       sorry '#{what.chomp!}' not yet supported ...\n       use an array index\n"
      message.rjust(27).split(//).each do |char|
        $stdout.print char.colorize(:light_red)
        sleep 0.0057
      end
      return
    end

    opend_found selected: @found[what.to_i], editor: ENV['EDITOR']
  end

  # attributes
  def options
    @options
  end

  private

  def build_gem_list
    if File.exist? gem_file
      return Bundler.load.specs.map(&:full_gem_path) - [default_dir]
    end
    []
  end

  def gem_file
    File.join(default_dir, './Gemfile')
  end

  def default_options(options)
    @options = options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    @options[:dir] = Dir.getwd if @options[:dir].nil? || @options[:dir].empty?
    @options.merge!(defaults) { |key, opt, default| opt }
  end

  def defaults
    { gems: false }
  end

  def default_dir
    Dir.getwd
  end

  def opend_found selected: {}, editor: 'mate'
    # :nocov:
    file_line = "#{selected[:line]} #{selected[:path]}"
    case editor
    when 'mate'
      `mate -l #{file_line}`
    when 'emacs'
      `emacs --no-splash +#{file_line}`
    else
      `vim +#{file_line}`
    end
    # :nocov:
  end

end
