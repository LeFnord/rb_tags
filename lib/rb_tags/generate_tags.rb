module GenerateTags
  def find_expressions(dir,mask)
    return `find #{dir} | ctags -x -L -`.split("\n")
  end
end