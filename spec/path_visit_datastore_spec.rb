require './log_line'
require './path_visit_data'
require './path_visit_datastore'

RSpec.describe PathVisitDatastore do
  subject { described_class.new }

  context 'when instanciated' do
    it 'stores no path_visits' do
      expect(subject.path_visits).to be {}
    end
  end

  context '#update_path_visit_quantities' do
    context 'with a valid log line' do
      let(:path) { '/about/2' }
      let(:valid_log_line) { LogLine.new(line_contents: "#{path} 836.973.694.403") }

      it 'stores an initial entry for the path' do
        subject.update_path_visit_quantities(log_line: valid_log_line)

        path_visit_data = subject.path_visits[path.to_sym]

        expect(path_visit_data.visit_count).to eq 1
        expect(path_visit_data.unique_visit_count).to eq 1
      end
    end

    context 'with an invalid log line' do
      let(:invalid_log_line) { '/about/2 836.973.694.403' }

      it 'raises an exception' do
        expect { subject.update_path_visit_quantities(log_line: invalid_log_line) }
          .to raise_error(StandardError)
      end
    end
  end
end
