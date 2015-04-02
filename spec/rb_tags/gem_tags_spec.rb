describe GemTags do
  it { expect(described_class).to eq(GemTags) }

  subject { GemTags.new }

  it { expect(subject).to respond_to(:filename) }

  describe 'defaults' do
    it { expect(subject.filename).to eq '.gem_tags' }
  end
end