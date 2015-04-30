# author LeFnord
# email  pscholz.le@gmail.com
# date   2013-12-18


module SysInfo
  module_function

  def number_of_processors
    if RUBY_PLATFORM =~ /linux/
      return `cat /proc/cpuinfo | grep processor | wc -l`.to_i
    elsif RUBY_PLATFORM =~ /darwin/
      return `sysctl -n hw.logicalcpu`.to_i
    else
      return 2
    end
  end

end
