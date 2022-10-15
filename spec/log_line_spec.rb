require './log_line'

RSpec.describe LogLine do
  subject { described_class.new(line_contents: log_contents) }

  context 'with a valid log line' do
    let(:log_contents) { '/about/2 836.973.694.403' }

    it 'sets the path value' do
      expect(subject.path).to eq '/about/2'
    end

    it 'sets the ip address value' do
      expect(subject.ip_address).to eq '836.973.694.403'
    end
  end

  context 'with an invalid log line' do
    let(:log_contents) { '/about/2836.973.694.403' }

    it 'raises an exception' do
      expect { subject.path }.to raise_error(StandardError)
    end
  end
end
