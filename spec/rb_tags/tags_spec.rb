describe Tags do
  it { expect(described_class).to eq(Tags) }

  subject { Tags.new }

  it { expect(subject).to respond_to(:dir) }
  it { expect(subject).to respond_to(:save) }
  it { expect(subject).to respond_to(:read) }
  it { expect(subject).to respond_to(:filename) }
  it { expect(subject).to respond_to(:tags) }

  describe 'defaults' do
    it { expect(subject.dir).to eq Dir.getwd }
    it { expect(subject.save).to eq false }
    it { expect(subject.read).to eq false }
    it { expect(subject.filename).to eq '.tags' }
  end

  describe 'with params' do
    subject { Tags.new(dir: '.', save: true, read: true, filename: 'foo')}
    it { expect(subject.dir).to eq '.' }
    it { expect(subject.save).to eq true }
    it { expect(subject.read).to eq true }
    it { expect(subject.filename).to eq 'foo' }
  end

  describe '#tag' do
    it { expect(subject).to respond_to(:tag) }

    it 'tags default directory' do
      subject.tag
      expect(subject.tags.length).to be > 1
      expect(subject.tags).to be_a Hash
      expect(subject.tags.values.first.first).to include(:type, :line, :path, :definition)
    end

    it 'tags specified directory' do
      subject = Tags.new dir: FileUtils.pwd
      subject.tag
      expect(subject.tags.length).to be > 1
      expect(subject.tags).to be_a Hash
      expect(subject.tags.values.first.first).to include(:type, :line, :path, :definition)
    end
  end

  describe '#save' do
    it 'do it' do
      subject = Tags.new(save: true)
      subject.tag
      tag_file = File.join(subject.dir, subject.filename)
      expect(File.exist?(tag_file)).to eq true
    end
  end

  describe '#read' do
    it 'do it' do
      subject = Tags.new(save: true)
      subject.tag
      tag_file = File.join(subject.dir, subject.filename)
      expect(File.exist?(tag_file)).to eq true
      object = Tags.new(read: true)
      expect(object.tags).to eq subject.tags
    end
  end
end
