require 'awesome_print'
require 'parslet'
require 'parslet/convenience'
require 'rb_tags/version.rb'

require 'rb_tags/generate_tags'
require 'rb_tags/parser'
require 'rb_tags/tags'
require 'rb_tags/gem_tags'
require 'rb_tags/json'

module RbTags
  def generate(format: 'vim', gems: false)
    @format = format
    @gems   = gems
    tags = do_tags
    gem_tags = do_gem_tags if gems
    # if @format == 'json'
    #   tags += gem_tags if gems
    #   hash_tags = Json.parse(tags)
    #   hash_tags
    # end
    return @format, @gems
    'expected return of #generate'
  end

  private

  def do_tags
    tags = Tags.new format: @format
    # tags.generate
  end

  def do_gem_tags
    gem_tags = GemTags.new format: @format
    # gem_tags.generate
  end
end
