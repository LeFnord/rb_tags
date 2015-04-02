require 'awesome_print'
require 'yaml'
require 'parslet'
require 'parslet/convenience'

require 'rb_tags/version.rb'

require 'rb_tags/concerns/generate_tags'
require 'rb_tags/concerns/parser'
require 'rb_tags/concerns/yaml_tasks'

require 'rb_tags/tags'
require 'rb_tags/gem_tags'

module RbTags
  def generate(gems: false)
    @gems   = gems
    return @gems
  end

  private
end
