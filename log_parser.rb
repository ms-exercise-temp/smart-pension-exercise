require 'set'
require './log_line'
require './path_visit_datastore'
require './path_visit_data_reader'

class LogParser
  def initialize(log_file_path:)
    @log_file_path = log_file_path
  end

  def parse_and_output_sorted_logs
    data_store = PathVisitDatastore.new

    File.foreach(@log_file_path) do |logline|
      data_store.update_path_visit_quantities(log_line: LogLine.new(line_contents: logline))
    end

    data_reader = PathVisitDataReader.new(data_store: data_store)

    puts data_reader.paths_by_visit_count
    puts
    puts data_reader.paths_by_unique_visit_count
  end
end
