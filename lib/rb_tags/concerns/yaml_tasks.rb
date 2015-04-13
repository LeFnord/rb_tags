module YamlTasks
  def read_from_yaml_file
    YAML.load_file(store) if File.exist?(store)
  end

  def write_to_yaml this: {}
    File.open(store, 'w') {|out| YAML.dump this, out}
  end

  private
  def store
    store = File.join(Dir.getwd,".tags")
  end
end