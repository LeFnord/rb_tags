describe Parser do
  it { expect(described_class).to eq(Parser) }

  let(:parser) { described_class.new }

  describe 'atoms' do
    describe '#space' do
      it { expect(parser.space).to parse(' ') }
      it { expect(parser.space).to parse("\t") }

      it { expect(parser.space).not_to parse('   ') }
      it { expect(parser.space).not_to parse('') }
      it { expect(parser.space).not_to parse('1') }
      it { expect(parser.space).not_to parse('a') }
    end

    describe '#spaces' do
      it { expect(parser.spaces).to parse(' ') }
      it { expect(parser.spaces).to parse("\t") }
      it { expect(parser.spaces).to parse('  ') }
      it { expect(parser.spaces).to parse("   \t") }
      it { expect(parser.spaces).not_to parse('1') }
      it { expect(parser.spaces).not_to parse('a') }
    end

    describe '#word' do
      it { expect(parser.word).to parse('tags') }
      it { expect(parser.word).to parse('RbTags') }
      it { expect(parser.word).to parse('rb_tags') }

      it { expect(parser.word).not_to parse(' ') }
      it { expect(parser.word).not_to parse("\t") }
      it { expect(parser.word).not_to parse('rb_tags/foo') }
      it { expect(parser.word).not_to parse('RbTags::Foo') }
    end

    describe '#line' do
      it { expect(parser.line).to parse('1') }
      it { expect(parser.line).to parse('23') }

      it { expect(parser.line).not_to parse(' ') }
      it { expect(parser.line).not_to parse("\t") }
      it { expect(parser.line).not_to parse("word") }
    end

    describe '#separator' do
      it { expect(parser.separator).to parse('/') }

      it { expect(parser.separator).not_to parse('1') }
      it { expect(parser.separator).not_to parse('23') }
      it { expect(parser.separator).not_to parse(' ') }
      it { expect(parser.separator).not_to parse("\t") }
      it { expect(parser.separator).not_to parse("word") }
    end
  end

  describe 'composite' do
    describe '#name' do
      it { expect(parser.name).to parse('tags') }
      it { expect(parser.name).to parse('RbTags') }
      it { expect(parser.name).to parse('rb_tags') }
      it { expect(parser.name).to parse('rb_tags_foo') }
      it { expect(parser.name).to parse('rb-tags') }
      it { expect(parser.name).to parse('rb-tags_foo') }

      it { expect(parser.name).not_to parse('RbTags::Foo') }
      it { expect(parser.name).not_to parse('RbTags::Foo::Bar') }
      it { expect(parser.name).not_to parse('rb_tags/foo') }
      it { expect(parser.name).not_to parse('rb_tags.foo') }
    end

    describe '#path' do
      it { expect(parser.path).to parse('/tags.rb') }
      it { expect(parser.path).to parse('/RbTags.rb') }
      it { expect(parser.path).to parse('/rb_tags.rb') }
      it { expect(parser.path).to parse('/rb_tags_foo.rb') }

      it { expect(parser.path).to parse('/foo/tags.rb') }
      it { expect(parser.path).to parse('/foo/RbTags.rb') }
      it { expect(parser.path).to parse('/foo/rb_tags.rb') }
      it { expect(parser.path).to parse('/foo/rb_tags_foo.rb') }

      it { expect(parser.path).to parse('/bar/foo/tags.rb') }
      it { expect(parser.path).to parse('/bar/foo/RbTags.rb') }
      it { expect(parser.path).to parse('/bar/foo/rb_tags.rb') }
      it { expect(parser.path).to parse('/bar/foo/rb_tags_foo.rb') }

      it { expect(parser.path).to parse('/barFoo/bar/foo_bar-foo/tags.rb') }
      it { expect(parser.path).to parse('/barFoo/bar/foo_bar-foo/RbTags.rb') }
      it { expect(parser.path).to parse('/barFoo/bar/foo_bar-foo/rb_tags.rb') }
      it { expect(parser.path).to parse('/barFoo/bar/foo_bar-foo/rb_tags_foo.rb') }
    end
  end

  describe 'whole line' do
    samples.each do |line|
      it { expect(parser).to parse(line) }
    end
  end


end