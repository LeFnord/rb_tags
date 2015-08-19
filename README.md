[![Gem Version](https://badge.fury.io/rb/rb_tags.svg)](http://badge.fury.io/rb/rb_tags)

# RbTags

Generate tags file for your ruby project and bundled gems, based on ctags.

## Installation

Install it using

`gem install rb_tags`

## Requirements

The gem requires that you have

* `find`
* `ctags`

in your path.

## Usage

`cd` into your project and simple type

`rb_tags -h`

```

    NAME
        rb_tags - Describe your application here

    SYNOPSIS
        rb_tags [global options] command [command options] [arguments...]

    VERSION
        0.0.5

    GLOBAL OPTIONS
        --help    - Show this message
        --version - Display the program version

    COMMANDS
        find - search for a tag
        help - Shows a list of commands or help for one command
        show - show esisting tags
        tag  - tags a given directory

```

# RELEASE notes

* v0.2.2: rollback to version 0.2.0, to use this, be sure you have no `.tags` files in any gems, if not use v0.2.1 to replace old structure in tag files  

* v0.2.1: fixes introduced bug [changes](https://github.com/LeFnord/rb_tags/commit/465bdf427f11dce157f6113342f50464a12743f0), and is an migration version between changes in `yaml_tasks.rb`

* v0.2.0: changes in [`yaml_tasks.rb`](https://github.com/LeFnord/rb_tags/commit/9260cc7398ec84bac54d7d10aeadbb479049b315); replacing combination of File.read/write and YAML.load/dump through YAML:Store

  this introduced an incompatibility with existing tag files, causing in different structure

  these version is yanked from rubygems.org

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Author

LeFnord

## License

see [License](LICENSE.txt)
