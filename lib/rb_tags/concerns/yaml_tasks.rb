module YamlTasks
  # # WRITE
  def write_to_yaml(dir: nil, this: {})
    FileUtils.rm(store(dir)) if File.exist?(store(dir))
    db = YAML::Store.new(store(dir), thread_safe: true)
    db.transaction { db["tags"] = this } unless this.nil?
  end

  # # READ
  def read_from_yaml_file(dir: nil)
    db = YAML::Store.new(store(dir), thread_safe: true)
    db.transaction { db.fetch("tags") }
  end

  private

  def store(dir = nil)
    if !!dir
      store = File.join(dir,".tags")
    else
      store = File.join(Dir.getwd,".tags")
    end
  end
end
