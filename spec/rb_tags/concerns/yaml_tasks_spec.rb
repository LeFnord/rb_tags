# frozen_string_literal: true
describe YamlTasks do
  after(:each) do
    tag_file = File.join(Dir.getwd, '.tags')
    FileUtils.rm(tag_file) if File.exist?(tag_file)
  end

  subject { described_class }

  it { expect(subject.name).to eq 'YamlTasks' }

  describe 'include methods' do
    subject { Class.include described_class }

    describe '#write_to_yaml' do
      it { expect { subject.write_to_yaml(this: {}) }.not_to raise_error }
    end

    describe '#read_from_yaml' do
      it { expect { subject.read_from_yaml }.not_to raise_error }
      it 'does something' do
        subject.write_to_yaml(this: { foo: 'bar' })
        expect { subject.read_from_yaml }.not_to raise_error
        expect(subject.read_from_yaml).not_to be nil
      end
    end

    describe '#store' do
      describe 'default dir' do
        let(:store) { subject.send(:store) }

        it { expect(store).to eq File.join(Dir.getwd, '.tags') }
      end

      describe 'dir given' do
        let(:store) { subject.send(:store, '/somewhere') }

        it { expect(store).to eq File.join('/somewhere', '.tags') }
      end
    end
  end
end
