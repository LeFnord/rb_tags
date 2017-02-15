# frozen_string_literal: true
describe Tags do
  let(:default_dir) { Dir.getwd }

  after(:each) do
    tag_file = File.join(default_dir, '.tags')
    FileUtils.rm(tag_file) if File.exist?(tag_file)
  end

  it { expect(described_class).to eq(Tags) }

  subject { Tags.new }

  it { expect(subject).to respond_to(:dir) }
  it { expect(subject).to respond_to(:tags) }
  it { expect(subject).to respond_to(:names) }

  describe 'defaults' do
    it { expect(subject.dir).to eq Dir.getwd }

    describe '#check dir' do
      it 'dir exist' do
        dir = subject.check(default_dir)
        expect(dir).to eql default_dir
        expect(Dir.exist?(default_dir)).to be true
      end

      let(:to_create_dir) { File.join(default_dir, 'spec', 'what') }

      before do
        FileUtils.rmdir(to_create_dir)
      end

      it 'create dirs' do
        expect(Dir.exist?(to_create_dir)).to be false

        dir = subject.check(to_create_dir)

        expect(dir).to eql to_create_dir
        expect(Dir.exist?(to_create_dir)).to be true
      end
    end

    describe 'with params' do
      subject { Tags.new(dir: './wo') }
      it { expect(subject.dir).to eq './wo' }
    end
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
      subject = Tags.new(dir: FileUtils.pwd)
      subject.tag
      expect(subject.tags.length).to be > 1
      expect(subject.tags).to be_a Hash
      expect(subject.tags.values.first.first).to include(:type, :line, :path, :definition)
    end
  end

  describe '#save' do
    it { expect { subject.save }.not_to raise_error }
    it 'do it' do
      subject.tag
      subject.save
      foo = File.join(subject.dir, '.tags')
      expect(File.exist?(foo)).to eq true
    end
  end

  describe '#read' do
    it { expect { subject.read }.not_to raise_error }
    it 'do it' do
      subject.tag
      tag_file = File.join(subject.dir, '.tags')
      expect(File.exist?(tag_file)).to eq true
      object = Tags.new
      object.read
      expect(object.tags).to eq subject.tags
    end
  end

  describe '#add' do
    subject { Tags.new }

    it 'has same length, if both are equal' do
      subject.tag
      tags_one = subject.tags
      expect { subject.add(tags_one) }.not_to raise_error
      expect(subject.tags.length).to eq tags_one.length
    end

    it 'has greater length, if not equal' do
      dir = Bundler.load.specs.map(&:full_gem_path).last
      compare = Tags.new(dir: dir)
      subject.tag
      compare.tag
      subject.add(compare.tags)
      expect(subject.tags.length).to be > compare.tags.length
    end
  end

  describe '#names' do
    before { subject.tag }
    it { expect(subject.names).to be_a Array }
    it { expect(subject.names.first).to be_a String }
  end

  describe '#delete' do
    before do
      subject = Tags.new(dir: FileUtils.pwd)
      subject.tag
    end

    it 'tag file' do
      expect(subject).to receive(:delete)
      subject.delete
      tag_file = File.join(subject.dir, '.tags')

      expect(Dir.exist?(tag_file)).to be false
    end
  end
end
