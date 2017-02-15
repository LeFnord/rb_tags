# frozen_string_literal: true
# author LeFnord
# email  pscholz.le@gmail.com
# date   2013-12-18

module SysInfo
  module_function

  def number_of_processors
    # :nocov:
    if RUBY_PLATFORM.match?(/linux/)
      `cat /proc/cpuinfo | grep processor | wc -l`.to_i
    elsif RUBY_PLATFORM.match?(/darwin/)
      `sysctl -n hw.logicalcpu`.to_i
    else
      2
    end
    # :nocov:
  end
end
