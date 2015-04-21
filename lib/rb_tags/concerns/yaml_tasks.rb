module YamlTasks
  def read_from_yaml_file dir: nil
    YAML.load_file(store(dir)) if File.exist?(store(dir))
  end

  def write_to_yaml dir: nil, this: {}
    File.open(store(dir), 'w') {|out| YAML.dump this, out}
  end

  private
  def store(dir)
    if !!dir
      store = File.join(dir,".tags")
    else
      store = File.join(Dir.getwd,".tags")
    end
  end
end