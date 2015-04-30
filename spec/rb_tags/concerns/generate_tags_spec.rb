describe GenerateTags do
  subject { described_class }

  it { expect(subject.name).to eq 'GenerateTags' }

  let(:valid) { ["RbTags           module        1 /Users/le_fnord/sandbox/github/rb_tags/lib/rb_tags/version.rb module RbTags"] }
  let(:invalid) { ["Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."] }

  describe '#parse_expression_line' do
    subject { Class.include described_class }
    let(:tags) { subject.parse_expression_line(valid) }
    let(:no_tags) { subject.parse_expression_line(invalid) }

    describe 'valid example' do
      it { expect {tags}.not_to raise_error }
      it { expect(tags).to be_a Array }
      it { expect(tags.first).to be_a Hash }
      it { expect(tags.first).to include(:name, :type, :line, :path, :definition) }
    end

    describe 'invalid example' do
      it { expect(no_tags).to be_a Array }
      it { expect(no_tags.first).to be_a String }
      it { expect(no_tags.first).to include('[RbTags] Error') }
    end
  end
end

