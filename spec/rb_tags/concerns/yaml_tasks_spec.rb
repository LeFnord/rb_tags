describe YamlTasks do
  subject { described_class }

  it { expect(subject.name).to eq 'YamlTasks' }

  describe '#store' do
    subject { Class.include described_class }
    describe 'default dir' do
      let(:store) { subject.send(:store) }

      it { expect(store).to eq File.join(Dir.getwd,'.tags') }
    end

    describe 'dir given' do
      let(:store) { subject.send(:store, '/somewhere') }

      it { expect(store).to eq File.join('/somewhere',".tags") }
    end
  end
end
