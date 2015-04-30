require 'spec_helper'

describe SysInfo do
  subject { described_class }

  it { expect(subject.name).to eq 'SysInfo' }

  describe '#number_of_processors' do
    let(:number) { subject.number_of_processors }

    it 'does something' do
      expect(subject).to receive(:number_of_processors).and_return(Fixnum)
      subject.number_of_processors
    end

    it { expect(number).to be_a Fixnum }
    it { expect(number).to be >= 2 }
  end
end
