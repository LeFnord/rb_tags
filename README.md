fork of: [iamkristian/ctags_ruby](https://github.com/iamkristian/ctags_ruby)

# RbTags

Generate ctags files for your ruby project and your bundled gems.

It will generate a `.tags` file for the project files and a `.gemtags`
for the dependencies, based upon you `Gemfile`.

It could be consumed by `vim` or `emacs`, for additional functionality: `rb_tags -h`.

It has the ability to search for a tag and open the referenced file in environment editor.

## Installation

Install it using

`gem install rb_tags`

## Requirements

The gem requires that you have

* `find`
* `ctags`

in your path.

## Usage

Cd into your project and simply type

`rb_tags`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Author

LeFnord

## License
MIT
