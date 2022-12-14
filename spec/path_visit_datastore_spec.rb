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
      let(:ip_address) { '836.973.694.403' }
      let(:valid_log_line) { LogLine.new(line_contents: "#{path} #{ip_address}") }

      it 'stores an initial entry for the path' do
        subject.update_path_visit_quantities(log_line: valid_log_line)

        path_visit_data = subject.path_visits[path.to_sym]

        expect(path_visit_data.visit_count).to eq 1
        expect(path_visit_data.unique_visit_count).to eq 1
      end

      it 'stores an entry for the log line' do
        subject.update_path_visit_quantities(log_line: valid_log_line)

        expect(subject.visited_paths).to include [path, ip_address]
      end

      context "with a path and IP combination that's already logged" do
        let(:path) { '/about/2' }
        let(:ip_address) { '836.973.694.403' }
        let(:log_line) { LogLine.new(line_contents: "#{path} #{ip_address}") }

        context 'with an IP address that has already visited the path' do
          let(:duplicate_log_line) { LogLine.new(line_contents: "#{path} #{ip_address}") }

          it 'increments the visit count for the path' do
            subject.update_path_visit_quantities(log_line: log_line)
            subject.update_path_visit_quantities(log_line: duplicate_log_line)

            path_visit_data = subject.path_visits[path.to_sym]

            expect(path_visit_data.visit_count).to eq 2
          end

          it 'does not increment the unique visit count for the path' do
            subject.update_path_visit_quantities(log_line: log_line)
            subject.update_path_visit_quantities(log_line: duplicate_log_line)

            path_visit_data = subject.path_visits[path.to_sym]

            expect(path_visit_data.unique_visit_count).to eq 1
          end
        end

        context 'with a unique IP address' do
          let(:unique_log_line) { LogLine.new(line_contents: "#{path} '123.456.789.000'") }

          it 'increments the visit count for the path' do
            subject.update_path_visit_quantities(log_line: log_line)
            subject.update_path_visit_quantities(log_line: unique_log_line)

            path_visit_data = subject.path_visits[path.to_sym]

            expect(path_visit_data.visit_count).to eq 2
          end

          it 'increments the unique visit count for the path' do
            subject.update_path_visit_quantities(log_line: log_line)
            subject.update_path_visit_quantities(log_line: unique_log_line)

            path_visit_data = subject.path_visits[path.to_sym]

            expect(path_visit_data.unique_visit_count).to eq 2
          end
        end

        it 'does not store an additional entry' do
          subject.update_path_visit_quantities(log_line: valid_log_line)
          subject.update_path_visit_quantities(log_line: valid_log_line)

          expect(subject.visited_paths.size).to eq 1
        end
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
