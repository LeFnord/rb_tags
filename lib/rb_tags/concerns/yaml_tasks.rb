module YamlTasks
  # # WRITE
  def write_to_yaml(dir: nil, this: {})
    db = YAML::Store.new(store(dir), thread_safe: true)
    db.transaction { db["tags"] = this }
  end

  # # READ
  def read_from_yaml(dir: nil)
    begin
      db = YAML::Store.new(store(dir), thread_safe: true)
      db.transaction { db.fetch("tags") }
    rescue Exception => e
    end

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
