# frozen_string_literal: true
module YamlTasks
  # # WRITE
  def write_to_yaml(dir: nil, this: {})
    db = YAML::Store.new(store(dir), thread_safe: true)
    db.transaction { db['tags'] = this }
  end

  # # READ
  def read_from_yaml(dir: nil)
    db = YAML::Store.new(store(dir), thread_safe: true)
    db.transaction { db.fetch('tags') }
  rescue StandardError => e
    $stdout.puts e
  end

  private

  def store(dir = nil)
    if dir
      File.join(dir, '.tags')
    else
      File.join(Dir.getwd, '.tags')
    end
  end
end
