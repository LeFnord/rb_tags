module Completion
  module_function

  def complete(list)
    comp = proc { |s| list.grep(/^#{Regexp.escape(s)}/) }

    Readline.completer_word_break_characters = ""
    Readline.completion_append_character = " "
    Readline.completion_proc = comp

    while line = Readline.readline('$ ', true)
      unless line[-1] =~ /(\n\r)/
        args = line.split(' ')
        break
      end
    end

    args
  end

end

