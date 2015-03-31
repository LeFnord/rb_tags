describe GemTags do
  it { expect(described_class).to eq(GemTags) }

  subject { GemTags.new }

  it { expect(subject).to respond_to(:format) }
  it { expect(subject).to respond_to(:filename) }
  it { expect(subject).to respond_to(:mask) }

  describe 'defaults' do
    it { expect(subject.format).to eq 'vim' }
    it { expect(subject.filename).to eq '.gem_tags' }
    it { expect(subject.mask).to eq '*.rb' }
  end
end