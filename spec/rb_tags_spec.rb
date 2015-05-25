class Foo
  include RbTags
end

describe RbTags do
  it 'has a version number' do
    expect(RbTags::VERSION).not_to be nil
  end

  subject { Class.include RbTags }

  it { expect(described_class).to eq(RbTags) }
  it { expect(subject).to respond_to(:generate) }
  it { expect(subject).to have_attributes(options: nil, gem_list: nil) }

  context Foo do
    let(:foo) { Foo.new }

    describe '#generate' do
      describe 'in work dir' do
        it { expect { foo.generate }.to_not raise_error }
      end

      describe 'in gems' do
        it { expect { foo.generate(gems: true) }.to_not raise_error }
      end
    end

    describe '#say_tagging' do
      let(:dir) { '/something' }
      let(:message) { "tag gem: #{dir} first time\n"}

      it 'does something' do
        expect(foo).to receive(:say_tagging).with(dir).and_return(message)
        foo.say_tagging(dir)
      end
    end

    describe '#tags' do
      let(:tag_tags) { Tags.new(read: true).names}

      it 'has tags' do
        expect(foo.tags).to eq tag_tags
      end
    end

    describe '#find' do
      let(:tag) { Tags.new(read: true).tags}
      let(:arg) { tag.first.first }

      before do
        foo.send(:get_existend_tags)
        allow(foo).to receive(:complete).and_return(tag[arg])
      end

      it 'does something' do
        expect(foo.found(arg)).to eq tag[arg]
        foo.find
      end
    end

    describe '#found' do
      let(:tag) { Tags.new(read: true).tags.first}
      let(:key) { tag.first }

      it 'does something' do
        foo.send(:get_existend_tags)
        expect(foo.found(key)).to eq tag.last
      end
    end

    describe '#open' do
      describe 'what is valid' do
        let(:what) { 0 }

        it 'call open' do
          expect(foo).to receive(:open).with(what)
          foo.open(what)
        end
      end

      describe 'what is invalid' do
        let(:what) { 'a' }

        it { expect{ foo.open(what) }.to output.to_stdout }
      end
    end

    describe 'private methods' do
      describe '#default_options' do
        describe 'defaults' do
          let(:tags) { foo.send(:default_options, {})}
          let(:defaults) { foo.send(:defaults) }
          let(:default) { {gems: false} }

          it { expect { tags }.to_not raise_error }
          it { expect(tags).to eq defaults }
          it 'has defaults' do
            defs = foo.send(:default_options, {})
            expect(defs).to eq default
            expect(foo.options).to eq default
          end
        end

        describe 'set gems' do
          let(:options) { {gems: true} }
          let(:tag_w_options) { foo.send(:default_options, options)}
          it { expect(tag_w_options).to eq options }
        end

        describe 'from gli' do
          let(:income) { { "dir" => "..", :dir => "..", "save" => true, :save => true, "gems" => true, :read  => false } }
          let(:options) { foo.send(:default_options, income)}
          let(:expected) { { :dir => "..", :save => true, :gems => true, :read  => false } }

          it { expect(options).to eq expected }
        end
      end

      describe '#gem_list' do
        let(:bar) { foo.send(:build_gem_list) }

        it { expect(bar).to be_a Array }
        it { expect(bar).to_not include(foo.send(:default_dir))}
      end

      describe '#get_existend_tags' do
        let(:tags) { foo.send(:get_existend_tags) }

        it { expect(tags).to be_a Tags }
      end

    end
  end
end