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
      it { expect(foo.generate).to eq(['vim', false]) }
      it { expect(foo.generate(format: 'emacs')).to eq(['emacs', false]) }
      it { expect(foo.generate(format: 'json')).to eq(['json', false]) }

      it { expect(foo.generate(gems: true)).to eq(['vim', true]) }
      it { expect(foo.generate(format: 'emacs', gems: true)).to eq(['emacs', true]) }
      it { expect(foo.generate(format: 'json', gems: true)).to eq(['json', true]) }
    end

    describe 'private methods' do
      describe '#do_tags' do
        let(:tags) { foo.send(:do_tags) }

        it { expect(tags).to be_a Tags}
        it { expect(tags).to respond_to(:format) }
        it { expect(tags).to respond_to(:filename) }
        it { expect(tags).to respond_to(:mask) }
      end

      describe '#do_gem_tags' do
        let(:gem_tags) { foo.send(:do_gem_tags) }

        it { expect(gem_tags).to be_a GemTags}
        it { expect(gem_tags).to respond_to(:format) }
      end
    end
  end
end