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

  context Foo do
    let(:foo) { Foo.new }

    describe '#generate' do
      describe 'do it' do
        it 'generates' do
          # expect { foo.generate }.to_not raise_error
        end
        it 'generates with gems true' do
          # expect { foo.generate(gems: true) }.to_not raise_error
        end
      end
    end

    describe 'private methods' do
      describe '#default_options' do
        describe 'defaults' do
          let(:tags) { foo.send(:default_options, {})}
          let(:defaults) { foo.send(:defaults) }

          it { expect { tags }.to_not raise_error }
          it { expect(tags).to eq defaults }
        end

        describe 'set gems' do
          let(:options) { {gems: true} }
          let(:tag_w_options) { foo.send(:default_options, options)}
          it { expect(tag_w_options).to eq options }
        end

        describe 'from gli' do
          let(:income) { { "dir"  => "..", :dir   => "..", "save" => true, :save  => true, "gems" => true, :read  => false } }
          let(:options) { foo.send(:default_options, income)}
          let(:expected) { { :dir   => "..", :save  => true, :gems => true, :read  => false } }
          it { expect(options).to eq expected }
        end
      end

      describe '#gem_list' do
        let(:bar) { foo.send(:build_gem_list) }
        it { expect(bar).to be_a Array }
        it { expect(bar).to_not include(foo.send(:default_dir))}
      end
    end
  end
end