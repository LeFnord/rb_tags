describe Tags do
  it { expect(described_class).to eq(Tags) }

  subject { Tags.new }

  it { expect(subject).to respond_to(:dir) }
  it { expect(subject).to respond_to(:format) }
  it { expect(subject).to respond_to(:filename) }
  it { expect(subject).to respond_to(:mask) }
  it { expect(subject).to respond_to(:tags) }

  describe 'defaults' do
    it { expect(subject.dir).to eq FileUtils.pwd }
    it { expect(subject.format).to eq 'vim' }
    it { expect(subject.filename).to eq '.tags' }
    it { expect(subject.mask).to eq '*.rb' }
  end

  describe '#tag' do
    it { expect(subject).to respond_to(:tag) }

    it 'tags a directory' do
      subject.tag
      pp subject.tags
      expect(subject.tags.length).to be > 1
      expect(subject.tags).to be_a Hash
      expect(subject.tags.values.first.first).to include(:type, :line, :path, :definition)
    end
  end
end
