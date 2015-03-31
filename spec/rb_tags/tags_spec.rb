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
    before do
      # allow(subject).to receive(:tag)
    end
    it { expect(subject).to respond_to(:tag) }
    it { expect(subject.tags).to be_a Array }

    it 'tags a directory' do
      subject.tag
      expect(subject.tags.length).to be > 1
    end
  end
end